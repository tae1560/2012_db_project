class TeamPeopleController < ApplicationController
  def update
    @team_person = TeamPerson.find(params[:id])
    #pro_field_id = params[:team_person][:pro_field].to_i

    respond_to do |format|
      if @team_person.update_attributes(params[:team_person])
        # 자신을 team member로 추가
        format.html { redirect_to :back}
      else
        format.html { redirect_to :back, :notice => @team.errors.full_messages }
      end
    end
  end
end
