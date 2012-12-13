class TeamsController < ApplicationController

  def create
    @team = Team.new(params[:team])
    service_id = params[:service][:id].to_i
    sw_developer_id = params[:sw_developer][:id].to_i
    personal_pay = params[:team_person][:personal_pay].to_i
    pro_field_id = params[:team_person][:pro_field].to_i

    @team.service = Service.find(service_id)
    @team.sw_developer = SwDeveloper.find(sw_developer_id)

    respond_to do |format|
      if @team.save
        # 자신을 team member로 추가
        team_person = TeamPerson.new(:personal_pay => personal_pay, :state => 1)
        team_person.pro_field = ProField.find(pro_field_id)
        team_person.sw_developer = SwDeveloper.find(sw_developer_id)
        @team.team_people << team_person

        format.html { redirect_to :back}
      else
        format.html { redirect_to :back, :notice => @team.errors.full_messages }
      end
    end
  end


  def update
    @team = Team.find(params[:id])
    pro_field_id = params[:team_person][:pro_field].to_i

    team_person = params[:team_person]
    if team_person
      sw_developer_id = team_person[:sw_developer_id]
      pro_field_id = params[:pro_field][:id].to_i

      team_person = TeamPerson.new(:personal_pay => 0, :state => 0)
      team_person.pro_field = ProField.find(pro_field_id)
      team_person.sw_developer = SwDeveloper.find(sw_developer_id)
      @team.team_people << team_person
    end

    respond_to do |format|
      if @team.update_attributes(params[:team])
        # 자신을 team member로 추가
        format.html { redirect_to :back}
      else
        format.html { redirect_to :back, :notice => @team.errors.full_messages }
      end
    end
  end



end
