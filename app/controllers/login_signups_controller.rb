# frozen_string_literal: true

class LoginSignupsController < ApplicationController
  before_action :set_login_signup, only: %i[show edit update destroy]

  def index
    return unless user_signed_in?

    redirect_to groups_path
  end

  def show; end

  def new
    @login_signup = LoginSignup.new
  end

  def edit; end

  def create
    @login_signup = LoginSignup.new(login_signup_params)

    respond_to do |format|
      if @login_signup.save
        format.html { redirect_to login_signup_url(@login_signup), notice: 'Login signup was successfully created.' }
        format.json { render :show, status: :created, location: @login_signup }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @login_signup.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @login_signup.update(login_signup_params)
        format.html { redirect_to login_signup_url(@login_signup), notice: 'Login signup was successfully updated.' }
        format.json { render :show, status: :ok, location: @login_signup }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @login_signup.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @login_signup.destroy

    respond_to do |format|
      format.html { redirect_to login_signups_url, notice: 'Login signup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_login_signup
    @login_signup = LoginSignup.find(params[:id])
  end

  def login_signup_params
    params.fetch(:login_signup, {})
  end
end
