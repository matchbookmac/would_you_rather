class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :ensure_admin!, except: [:show]

  # GET /users/1
  def show
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:username, :admin)
  end

  def ensure_admin!
    unless current_user.admin?
      flash[:alert] = "You do not have the permissions to perform that action"
      redirect_to root_path

      return false
    end
  end
end
