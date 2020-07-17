class CustomersController < ApplicationController
  before_action :user_group
  before_action :set_customer, only: [ :edit, :destroy]


  # GET /customers
  # GET /customers.json
  def index
    @stats="index"
    @pagestat=="N"
    @customers = Customer.all.where(won_staff: @wonstaff).page(params[:page]).per(10)
    @rowsum= @customers.count()
    @menubars = Menubar.all
    @menubar = @menubars.first
    @menus = Menubar.order(:menu_sn)
    render :query
    # if @current_page != params[:page] || @current_menu_id.blank? then
    #   @current_menu_id = @menubar.menu_id
    #   @current_page = params[:page]
    # end
  end

  # GET /customers/1$('
  # GET /customers/1.json
  def query

    #@customers=customer.new
    # p "#{custid['cust_id']}"
    @menubars = Menubar.all
    @menubar = @menubars.first
    @menus = Menubar.order(:menu_sn)
    # if @current_page != params[:page] || @current_menu_id.blank? then
    #   @current_menu_id = @menubar.menu_id
    #   @current_page = params[:page]
    # end

    #accout add
    if params[:cust_id].empty?
      puts "empty"
       @customers=Customer.all.where(won_staff: @wonstaff).page(params[:page]).per(10)
    else
       @customers=Customer.all.where(cust_id: params[:cust_id],won_staff: @wonstaff).order(cust_id: :asc,created_at: :desc).page(params[:page]).per(10)
      puts "noempty"
    end

    puts params[:page].to_i
   if params[:page].to_i > 0
    @page="change"
   elsif params[:page].to_i >= 0
      params[:page]= "1"
    @page="nochange"
   end

  end
    # p "#{custid['cust_id']}"

    #@accs=customer.all.where(cust_date: @acc_date).joins(:customer).where(customers: {cust_id: custid}).page(params[:page]).per(10)
def create
  @menubars = Menubar.all
  @menubar = @menubars.first
  @menus = Menubar.order(:menu_sn)
  if @current_page != params[:page] || @current_menu_id.blank? then
    @current_menu_id = @menubar.menu_id
    @current_page = params[:page]
  end
  puts "create"

  custid = Customer.select(:cust_id).where(cust_id: params[:cust_id],won_staff: @wonstaff)
  if custid.size ==0 then
  @cust_count=Customer.select(:cust_id).where(cust_id: params[:cust_id],
                            cust_name: params[:cust_name],
                            cust_stat: params[:cust_stat],
                            won_staff: params[:won_staff],
                            cust_note: params[:cust_note])

       if @cust_count.size == 0 then
            @customer=Customer.create(cust_id: params[:cust_id],
                                      cust_name: params[:cust_name],
                                      cust_stat: params[:cust_stat],
                                      won_staff: params[:won_staff],
                                      cust_note: params[:cust_note])
          end
  else
      puts"ffffff"
  end
      #@customers=customer.new
      # p "#{custid['cust_id']}"
end





  # GET /customers/new
  def new
    @menubars = Menubar.all
    @menubar = @menubars.first
    @menus = Menubar.order(:menu_sn)
    if @current_page != params[:page] || @current_menu_id.blank? then
      @current_menu_id = @menubar.menu_id
      @current_page = params[:page]
    end
=begin
    @acc_count=customer.select(:cust_id).where(cust_id: params[:cust_id],
                              acc_date: params[:acc_date],
                              acc_kind: params[:acc_kind],
                              cust_type: params[:cust_type],
                              acc_cost: params[:acc_cost],
                              acc_note: params[:acc_note],
                              acc_no: params[:acc_no])

         if @acc_count.size == 0 then
             @customer=customer.create(cust_id: params[:cust_id],
                              acc_date: params[:acc_date],
                              acc_kind: params[:acc_kind],
                              cust_type: params[:cust_type],
                              acc_cost: params[:acc_cost],
                              acc_note: params[:acc_note],
                              acc_no: params[:acc_no])
            custidsum = Customer.select(:cust_id).where(won_staff: @wonstaff)
            @sumcost=customer.all.joins(:customer).where(customers: {cust_id: custidsum}).sum(:acc_cost)
        end
=end
  end

  # GET /customers/1/edit
  # POST /customers
  # POST /customers.json
  def user_group
    staff = UserGroup.select("won_staff","group").where(login: 'Wu.Doris')  #authenticate_user![:login]
    staff.each do |variable|
      @wonstaff =variable.won_staff
      @group =variable.group

  end


    # puts  u.login+u.won_staff+u.group

  end


  def edit
       @customer=Customer.find_by(cust_id: params[:cust_id])
       #history now data
       @customer.update(cust_name: params[:cust_name],cust_stat: params[:cust_stat],cust_note: params[:cust_note])
       #history aft change


  end
  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json


  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy

      customer=Customer.find_by(cust_id: params[:id])
      #save History
      customer.destroy
      puts "destroy"

  #  respond_to do |format|
  #    format.html { render :index, notice: 'customer was successfully destroyed.' }
  #    format.json { head :no_content }
  #  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer

    end
    #依查詢加上個月的資料
    def nextMonth(acc_date)
      if acc_date[4,5]=="01"
        acc_date= "20"+((acc_date[2,2].to_i) - 1).to_s + "12"

      else
        acc_date= acc_date[0,4].to_s+ (acc_date[4,2].to_i - 1).to_s
          if acc_date.size() == 5
              acc_date=acc_date[0,4]+"0"+acc_date[4,1]
          end
      end
    end

    # Only allow a list of trusted parameters through.
    def customer_params
       params.require(:customer).permit(:cust_id,
      :cust_name,
      :cust_stat,
      :won_staff,
      :cust_note,
      :created_at,
      :updated_at )
    end

  def user_params
    params.require(:user_group).permit(:login,
    :group,
   :won_staff
  )
end
end
