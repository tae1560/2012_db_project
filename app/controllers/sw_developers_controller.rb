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

  def home

  end

  def profile
    @user = @current_user
  end

  def development_results
    @sw_developer = @current_user.sw_developer
    @development_results = @sw_developer.development_results
  end

  def new_development_results

  end

  def services
    @pro_fields = ProField.all
    @services = @sw_developer.services
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

        # 팀에 해당되는 용역의 개발자 수와 현재 결성된 개발자 수를 비교하여 완성인지 불완성인지 확인
        total_pay = 0
        number_of_developers_in_team = {}
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
          SwDeveloper.find_each do |sw_developer|
            unless sw_developer.team_people.where(:team_id => team.id).exists?
              sw_developers.push sw_developer
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

        if need_pro_field_id_and_developers.size == 0
          service_datum[:complete_team].push team_data
        else
          service_datum[:incomplete_team].push team_data
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
