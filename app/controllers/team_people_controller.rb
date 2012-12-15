# coding: utf-8
class TeamPeopleController < ApplicationController
  def update
    @team_person = TeamPerson.find(params[:id])
    #pro_field_id = params[:team_person][:pro_field].to_i

    # 3번까지만 수정하게 하기 위해서
    @team_person.change_counter -= 1

    respond_to do |format|
      if @team_person.update_attributes(params[:team_person])
        # 자신을 team member로 추가

        # 승낙 및 거절 시 메시지
        if params[:team_person][:state]
          if @team_person.state == 1
            @team_person.team.sw_developer.user.send_message "#{@team_person.sw_developer.user.name}님이 초대를 승낙 하셨습니다."
          elsif @team_person.state == 2
            @team_person.team.sw_developer.user.send_message "#{@team_person.sw_developer.user.name}님이 초대를 거절 하셨습니다."
          end
        else
          # 경매 정보 변경시 메시지

          # 팀에 관련된 서비스만
          service = @team_person.team.service

          total_number_of_developers = 0

          service.service_pro_fields.each do |service_pro_field|
            total_number_of_developers += service_pro_field.number_of_developers
          end

          # 경매 정보가 변경된 팀이 완성된 팀일 경우
          if @team_person.team.team_people.size == total_number_of_developers
            service.teams.each do |team|
              # 완성된 팀
              if team.team_people.size == total_number_of_developers
                # 팀장에게 message
                team.sw_developer.user.send_message "#{service.name} 용역의 경매정보가 변경되었습니다."
              end
            end
          end

        end



        format.html { redirect_to :back}
      else
        format.html { redirect_to :back, :notice => @team.errors.full_messages }
      end
    end
  end
end
