class HistoriesController < ApplicationController
  before_action :user_group


  # GET /histories
  # GET /histories.json
  def index
    @histories = History.all.page(params[:page]).per(10)
    # @menubars = Menubar.all
    # @menubar = @menubars.first
    @menus = Menubar.order(:menu_sn)
    # if @current_page != params[:page] || @current_menu_id.blank? then
    #   @current_menu_id = @menubar.menu_id
    #   @current_page = params[:page]
    # end

  end

  # GET /histories/1
  # GET /histories/1.json
  def query

    # @menubars = Menubar.all
    # @menubar = @menubars.first
    @menus = Menubar.order(:menu_sn)

    # if @current_page != params[:page] || @current_menu_id.blank? then
    #   @current_menu_id = @menubar.menu_id
    #   @current_page = params[:page]
    # end
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

@hiscustID = params[:cust_id] if params[:cust_id].present?
@date_yy = params[:acc_date].first(4) if params[:acc_date].present?
@date_mm = params[:acc_date].last(2) if params[:acc_date].present?
@input2 = params[:user_id] if params[:user_id].present?
@input1 = params[:mark] if params[:mark].present?
@hisdateS = params[:star_date] if params[:star_date].present?
@hisdateE = params[:end_date] if params[:end_date].present?
# @won_staff = params[:won_staff] if params[:won_staff].present?
# cust_id = $("#input0").val()
# acc_date= $("#date_yy").val()+$("#date_mm").val()
# mark = $("#input1").val()
# user_id= $("#input2").val()
# star_date = $("#input3").val()
# end_date = $("#input4").val()

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
