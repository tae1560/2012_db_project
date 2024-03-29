# coding: utf-8
class UsersController < ApplicationController
  before_filter :save_login_state, :only => [:new, :create]
  before_filter :authenticate_user, :only => [:show]

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

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.sw_developer
        @development_results = @user.sw_developer.development_results
        format.html { render "/sw_developers/profile"}
      elsif @user.requestor
        format.html { render "/requestors/profile"}
      elsif @user.evaluator
        format.html { render "/evaluators/profile"}
      elsif @user.administrator
        format.html { render "/administrators/profile"}
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.encrypt_password

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

        @user.last_login = Time.now
        @user.save

        format.html { redirect_to sessions_login_path, :notice => "joined successfully" }
        format.json { render json: @users, status: :created, location: @user }
      else
        format.html { render 'new', :notice => @user.errors.full_messages}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    @user = User.find(params[:id])
    user_params = params[:user]

    if !user_params[:password] or user_params[:password].length == 0
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end

    user_params.each do |key, value|
      @user[key] = value
    end

    if user_params[:password]
      @user.encrypt_password
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to :back }
      else
        format.html { redirect_to :back, :notice => @user.errors.full_messages  }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def initialize_all_data
    # initialize pro_fields
    pro_fields = ["DB","네트워크","임베디드"]
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
