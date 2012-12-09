class ProFieldsController < ApplicationController
  def index
    @pro_field = ProField.all

    respond_to do |format|
      format.json { render json: @pro_field }
    end
  end

  def show
    @pro_field = ProField.find(params[:id])

    respond_to do |format|
      #format.html # show.html.erb
      format.json { render json: @pro_field }
    end
  end

  def create
    @pro_field = ProField.new(params[:pro_field])

    respond_to do |format|
      if @pro_field.save
        format.html { redirect_to :back }
      else
        format.html { redirect_to :back }
      end
    end
  end

  def destroy
    @pro_field = ProField.find(params[:id])
    @pro_field.destroy

    respond_to do |format|
      #format.html { redirect_to pro_fields_url }
      format.json { head :no_content }
    end
  end
end
