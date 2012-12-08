# coding: utf-8
class UsersController < ApplicationController
  before_filter :save_login_state, :only => [:new, :create]

  def index
    @users = User.all
    @sw_developers = SwDeveloper.all
    @evaluators = Evaluator.all
    @administrators = Administrator.all
    @requestors = Requestor.all

    respond_to do |format|
      format.html {}
      format.json { render json: @users }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        u = nil
        case @user.roll
          when "개발자" then
            u =  SwDeveloper.new
          when "평가자" then
            u =  Evaluator.new
          when "관리자" then
            u = Administrator.new
          when "용역의뢰자" then
            u = Requestor.new
        end
        if u
          u.user = @user
          u.save
        end

        format.html { redirect_to sessions_login_path, :notice => "joined successfully" }
        format.json { render json: @users, status: :created, location: @user }
      else
        format.html { render 'new', :notice => @user.errors.full_messages}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def initialize_all_data
    # initialize pro_fields
    pro_fields = ["DB","네트워크","임베이드"]
    pro_fields.each do |pro_field|
      selected_pro_field = ProField.where(:name => pro_field).first

      if selected_pro_field == nil
        selected_pro_field = ProField.new
        selected_pro_field.name = pro_field
        selected_pro_field.save
      end
    end

    @pro_fields = ProField.all

    respond_to do |format|
      format.json { render json: @pro_fields }
    end
  end
end
