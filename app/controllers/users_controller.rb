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
      #format.html {redirect_to new_user_url, :alert => 'Post was successfully updated.'}
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
        case @user.roll

          when "개발자" then
            u =  SwDeveloper.new
          when "평가자" then
            u =  Evaluator.new
          when "관리자" then
            u = Administrator.new
          when "용역의뢰자" then
            u = Requestor.new

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
end
