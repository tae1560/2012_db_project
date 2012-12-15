class RequestorsController < ApplicationController
  before_filter :authenticate_user
  before_filter :proper_user

  def home
    @time_out_services = @requestor.services.where("due_date < ?", Time.now).where(:team_id => nil)

    #@service_경매내역이 변경되었습니다.

    @changed_services = []
    last_login = @current_user.last_login

    if last_login == nil
      last_login = Time.now
    end

    @requestor.services.where(:team_id => nil).each do |service|
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
  end

  def edit_profile
    @user = @current_user
  end

  def proper_user
    @requestor = @current_user.requestor
    if @requestor == nil
      redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end

  def services
    @services = Service.where(:team_id => nil).all
  end

  def new_service
    @service = Service.new
  end

  def finished_services
    @services = Service.where("team_id IS NOT NULL").all
  end
end
