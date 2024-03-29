class SwDevelopersController < ApplicationController
  before_filter :authenticate_user, :except => :index
  before_filter :proper_user, :except => :index

  def index
    @pro_field_id = params[:pro_field_id]
    @users = User.all

    user_sw_developers = []
    @users.each do |user|
      if user.sw_developer
        if @pro_field_id
          if user.sw_developer.pro_fields.find(@pro_field_id).exist?
            user_sw_developers.push user
          end
        else
          user_sw_developers.push user
        end
      end
    end

    respond_to do |format|
      format.json { render :json => user_sw_developers }
    end
  end

  def update
    @sw_developer = SwDeveloper.find(params[:id])
    pro_field_params = params[:pro_field]

    # 모두 삭제
    @sw_developer.sw_developer_pro_fields.each do |sw_developer_pro_field|
      sw_developer_pro_field.destroy
    end

    pro_field_params.each do |pro_field_param|
      pro_field_id = pro_field_param[0].to_i
      is_selected = (pro_field_param[1].to_i == 1)
      pro_field = ProField.find(pro_field_id)

      if is_selected
        @sw_developer.pro_fields << pro_field
      end
    end

    respond_to do |format|
      if @sw_developer.update_attributes(params[:sw_developer])
        format.html { redirect_to :back }
      else
        format.html { redirect_to :back, :notice => @sw_developer.errors.full_messages  }
      end
    end
  end

  def home
    last_login = @current_user.last_login
    if last_login == nil
      last_login = Time.now
    end

    # 관리자에게 선정된 정보가 있는 경우
    @selected_services = []
    @sw_developer.pre_chosen_developers.each do |pre_chosen_developer|
      if pre_chosen_developer.updated_at > last_login - User.debug_time
                                                       # 바뀐 사람이 있으면 체크
        @selected_services.push pre_chosen_developer.service
      end
    end

    # 팀 초대 왔을때
    # 자신에 관련된 모든 서비스
    @invited_teams = []
    @sw_developer.services.where(:team_id => nil).each do |service|
      # 서비스에 관련된 모든 팀
      service.teams.each do |team|
        # 팀에 있는 모든 팀원중 내가 있는 팀원
        team.team_people.where(:sw_developer_id => @sw_developer.id).each do |team_person|
          # 미응답 상태
          if team_person.state == 0
            @invited_teams.push team
          end
        end
      end
    end

    # 경매 정보 변경
    @changed_services = []
    @sw_developer.services.where(:team_id => nil).each do |service|
      # 서비스의 팀들 중 완성된 팀 고르기

      total_number_of_developers = 0

      service.service_pro_fields.each do |service_pro_field|
        total_number_of_developers += service_pro_field.number_of_developers
      end


      service.teams.each do |team|
        # 완성된 팀
        if team.team_people.size == total_number_of_developers
          # 팀원 중 내용이 바뀐 사람이 있는지 체크
          team.team_people.each do |team_person|
            if team_person.updated_at > last_login - User.debug_time
                                                             # 바뀐 사람이 있으면 체크
              @changed_services.push service
              break
            end
          end
        end
      end
    end

    # last_login 업데이트
    @current_user.last_login = Time.now
    @current_user.save
  end

  def profile
    @user = @current_user
    @development_results = @sw_developer.development_results
  end

  def edit_profile
    @user = @current_user
    @pro_fields = ProField.all
  end

  def development_results
    @sw_developer = @current_user.sw_developer
    @development_results = @sw_developer.development_results
  end

  def new_development_results

  end

  def services
    @pro_fields = ProField.all
    @services = @sw_developer.services.where("due_date > ?", Time.now - User.debug_time).where(:team_id => nil)

    # 자신이 만든 팀

    @service_data = []
    @services.each do |service|
      # my team
      service_datum = {}
      @service_data.push service_datum
      service_datum[:service] = service
      service_datum[:service_pro_fields] = service.service_pro_fields
      #service_datum["own_team"] = @sw_developer.teams.where(:service_id => service.id).first

      service_datum[:complete_team] = []
      service_datum[:incomplete_team] = []
      service_datum[:own_team] = nil
      service_datum[:participated_team] = []
      service_datum[:my_team_people] = []

      # pro_field 별 횟수 받아오기
      number_of_developers_in_service = {}
      service_datum[:service_pro_fields].each do |service_pro_field|
        if number_of_developers_in_service[service_pro_field.pro_field.id]
          number_of_developers_in_service[service_pro_field.pro_field.id] += service_pro_field.number_of_developers
        else
          number_of_developers_in_service[service_pro_field.pro_field.id] = service_pro_field.number_of_developers
        end
      end
      service_datum[:number_of_developers_in_service] = number_of_developers_in_service

      service_datum[:need_pro_field_ids] = []
      number_of_developers_in_service.each do |pro_field_id, number_of_developer|
        service_datum[:need_pro_field_ids].push pro_field_id
      end

      service.teams.each do |team|
        team_reader = team.sw_developer
        team_people = team.team_people

        # 자신이 속한 팀원
        if team.team_people.where(:sw_developer_id => @sw_developer.id).exists?
          service_datum[:my_team_people].push team.team_people.where(:sw_developer_id => @sw_developer.id).first
        end

        # 팀에 해당되는 용역의 개발자 수와 현재 결성된 개발자 수를 비교하여 완성인지 불완성인지 확인
        total_pay = 0
        number_of_developers_in_team = {}
        is_all_team_people_agreed = true
         team_people.each do |team_person|
          # state 0 means not yet agreed, 1 means agreed, 2 means disagreed
          if team_person.state == 1 or team_person.state == 0
            team_person_pro_field = team_person.pro_field

            if number_of_developers_in_team[team_person_pro_field.id]
              number_of_developers_in_team[team_person_pro_field.id] += 1
            else
              number_of_developers_in_team[team_person_pro_field.id] = 1
            end

            total_pay += team_person.personal_pay
          end

           unless team_person.state == 1
             is_all_team_people_agreed = false
           end
        end

        # 모두 참가했는지 체크
        need_pro_field_id_and_developers = {}

        number_of_developers_in_service.each do |pro_field_id, number_of_developer|
          if !number_of_developers_in_team[pro_field_id] or number_of_developer > number_of_developers_in_team[pro_field_id]
            need_pro_field_id_and_developers[pro_field_id] = []
          end
        end

        need_pro_field_id_and_developers.each do |pro_field_id, sw_developers|
          # 해당 전문분야의 모든 개발자 검색  TODO 아직 개발자가 적어서 전체 개발자로 #pro_field.sw_developers.inspect
          service.sw_developers.find_each do |sw_developer|
            # 아직 팀에 참여하고 있지 않다면
            unless sw_developer.team_people.where(:team_id => team.id).exists?
              # pro_field
               if sw_developer.pro_fields.include? ProField.find(pro_field_id)
                 sw_developers.push sw_developer
               end
            end
          end
        end

        # view로 데이터 이동
        team_data = {}
        team_data[:team_reader] = team_reader
        team_data[:team_people] = team_people
        team_data[:total_pay] = total_pay
        team_data[:need_pro_field_id_and_developers] = need_pro_field_id_and_developers
        team_data[:team] = team

        if team_reader == @sw_developer
          service_datum[:own_team] = team_data
        end

        if need_pro_field_id_and_developers.size == 0 and is_all_team_people_agreed
          service_datum[:complete_team].push team_data
        else
          service_datum[:incomplete_team].push team_data
        end

        if team_people.where(:sw_developer_id => @sw_developer.id).exists?
          service_datum[:participated_team].push team_data
        end

        # 완성된 경우 수당 합계 계산
        # total_pay로 이미 계산

        # 완성되지 않은 경우 인원정보
        # number_of_developers_in_team[pro_field_id]
      end
    end




  end

  def proper_user
    @sw_developer = @current_user.sw_developer
    if @sw_developer == nil
      redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end
end
