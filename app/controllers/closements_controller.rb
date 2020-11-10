class ClosementsController < ApplicationController
  before_action :user_group
  before_action :set_closement, only: [:show, :edit, :update, :destroy]

  # GET /closements
  # GET /closements.json
  def index
    @menubars = Menubar.all
    @menubar = @menubars.first
    @menus = Menubar.order(:menu_sn)
    @closements = Closement.all
  end

  # GET /closements/1
  # GET /closements/1.json
  def query
    @closements = Closement.all
    if params[:close_day].present?
      @closements.update_all(close_day: params[:close_day].to_i)
    end
  end

  def user_group
    staff = UserGroup.select("won_staff","group").where(login: authenticate_user![:login])  #authenticate_user![:login]
    staff.each do |variable|
      @wonstaff =variable.won_staff
      @group =variable.group
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_closement
      @closement = Closement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def closement_params
      params.require(:closement).permit(:close_day)
    end
end
