class SubFieldsController < ApplicationController
  def index
    @sub_field = SubField.all

    respond_to do |format|
      format.json { render json: @sub_field }
    end
  end

  def show
    @sub_field = SubField.find(params[:id])

    respond_to do |format|
      #format.html # show.html.erb
      format.json { render json: @sub_field }
    end
  end

  def create
    @sub_field = SubField.new(params[:sub_field])

    respond_to do |format|
      if @sub_field.save
        format.html { redirect_to :back }
      else
        format.html { redirect_to :back }
      end
    end
  end

  def destroy
    @sub_field = SubField.find(params[:id])

    @sub_field.evaluation_result_sub_fields.each do |evaluation_result_sub_field|
      evaluation_result_sub_field.destroy
    end

    @sub_field.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      #format.json { head :no_content }
    end
  end
end
