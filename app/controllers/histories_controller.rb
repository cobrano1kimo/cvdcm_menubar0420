class HistoriesController < ApplicationController
  before_action :user_group


  # GET /histories
  # GET /histories.json
  def index
    @histories = History.all.page(params[:page]).per(10)
    @menubars = Menubar.all
    @menubar = @menubars.first
    @menus = Menubar.order(:menu_sn)
    if @current_page != params[:page] || @current_menu_id.blank? then
      @current_menu_id = @menubar.menu_id
      @current_page = params[:page]
    end

  end

  # GET /histories/1
  # GET /histories/1.json
  def query

    @menubars = Menubar.all
    @menubar = @menubars.first
    @menus = Menubar.order(:menu_sn)
    if @current_page != params[:page] || @current_menu_id.blank? then
      @current_menu_id = @menubar.menu_id
      @current_page = params[:page]
    end



    hissql = "SELECT * FROM histories WHERE 1=1 "
     if    !params[:cust_id].empty?
              hissql = hissql + "and cust_id='"+params[:cust_id]+ "' "
            end
       if !params[:acc_date].empty?
              hissql = hissql + "and acc_date='"+params[:acc_date]+ "' "
                end
           if !params[:mark].empty?
                     hissql = hissql + "and mark='"+params[:mark]+ "' "
                       end
                   if !params[:user_id].empty?
                            hissql = hissql + "and user_id='"+params[:user_id]+ "' "
                              end
                              if !params[:star_date].empty?
                                       hissql = hissql + "and CONVERT(date, '"+params[:star_date]+ "') <= CONVERT(date, created_at) "
                                         end
                                         if !params[:end_date].empty?
                                                 hissql = hissql + "and CONVERT(date, '"+params[:end_date]+ "') >= CONVERT(date, created_at) "
                                                    end

     hissql = hissql + "order by created_at desc"+" OFFSET 0 ROWS FETCH NEXT 100 ROWS ONLY"
       @histories=History.find_by_sql(hissql)


    #@histories=History.all.where(cust_id: hissqlfile.cust_id).order(created_at: :desc).page(params[:page]).per(10)

=begin
    if params[:cust_id].empty? and params[:acc_date].empty?
      @histories=History.s.order(created_at: :desc).page(params[:page]).per(10)
    elsif params[:cust_id].empty? and !params[:acc_date].empty?
      @histories=History.all.where("acc_date = ?", params[:acc_date]).order(created_at: :desc).page(params[:page]).per(10)
    elsif !params[:cust_id].empty? and params[:acc_date].empty?
      @histories=History.all.where("cust_id= ?", params[:cust_id]).order(created_at: :desc).page(params[:page]).per(10)
    elsif !params[:cust_id].empty? and !params[:acc_date].empty?
      @histories=History.all.where("cust_id= ? and acc_date = ?", params[:cust_id],params[:acc_date]).order(created_at: :desc).page(params[:page]).per(10)
    end
=end
puts params[:page].to_i
if params[:page].to_i > 0
@page="change"
elsif params[:page].to_i >= 0
  params[:page]= "1"
@page="nochange"
end
end

  # GET /histories/new

  # DELETE /histories/1.json
  def destroy

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
    def set_history
      @history = History.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def history_params
      params.require(:history).permit(:cust_id)
    end
end
