class UserGroupsController < ApplicationController
  before_action :user_group
  before_action :set_user_group, only: [:show, :edit, :update, :destroy]

  # GET /user_groups
  # GET /user_groups.json
  def index
    @menubars = Menubar.all
    @menubar = @menubars.first
    @menus = Menubar.order(:menu_sn)
    @user_groups = UserGroup.all.where("[group] <> ?","3").page(params[:page]).per(10)


  end

  # GET /user_groups/1/edit
  def query

    @user_groups =  UserGroup.find_by(login: params[:login])
    @user_groups.update(group: params[:group])
    @user_groups=UserGroup.all

  end
  def user_group
    staff = UserGroup.select("won_staff","group").where(login: authenticate_user![:login])  #authenticate_user![:login]
    staff.each do |variable|
      @wonstaff =variable.won_staff
      @group =variable.group
    end
  end
  # POST /user_groups
  # POST /user_groups.json


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_group
      @user_group = UserGroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_group_params
      params.fetch(:user_group, {})
    end
end
