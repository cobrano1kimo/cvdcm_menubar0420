class AccountsController < ApplicationController
  before_action :user_group
  before_action :set_account, only: [ :edit, :destroy]


  # GET /accounts
  # GET /accounts.json
  def index
    @stats="index"
    @pagestat=="N"
    custid = Customer.select(:cust_id).where(won_staff: @wonstaff)
    @sumcost=Account.all.joins(:customer).where(customers: {cust_id: custid}).sum(:acc_cost)
    #@accounts=Account.new
    # p "#{custid['cust_id']}"
    @accounts=Account.all.joins(:customer).where(customers: {cust_id: custid}).page(params[:page]).per(10)
    @rowsum= @accounts.count()
    @menubars = Menubar.all
    @menubar = @menubars.first
    @menus = Menubar.order(:menu_sn)
    # if @current_page != params[:page] || @current_menu_id.blank? then
    #   @current_menu_id = @menubar.menu_id
    #   @current_page = params[:page]
    # end
  end

  # GET /accounts/1$('
  # GET /accounts/1.json
  def query



    #@accounts=Account.new
    # p "#{custid['cust_id']}"

    @menubars = Menubar.all
    @menubar = @menubars.first
    @menus = Menubar.order(:menu_sn)
    # if @current_page != params[:page] || @current_menu_id.blank? then
    #   @current_menu_id = @menubar.menu_id
    #   @current_page = params[:page]
    # end

    usemakedate= nextMonth(params[:acc_date])

    #accout add
    if params[:cust_id].empty?
      puts "empty"
       custid = Customer.select(:cust_id).where(won_staff: @wonstaff)
       @accounts=Account.all.where(acc_date:  params[:acc_date]).joins(:customer).where(customers: {cust_id:  custid}).order(cust_id: :asc,created_at: :desc).page(params[:page]).per(10)
       @rowsum=Account.all.where(acc_date:  params[:acc_date]).joins(:customer).where(customers: {cust_id:  custid}).count()
       @sumcost=Account.all.where(acc_date:  params[:acc_date]).joins(:customer).where(customers: {cust_id: custid}).sum(:acc_cost)
       Account.find_by_sql("INSERT INTO accounts(acc_kind, acc_no,acc_date,acc_cost,cust_id,cust_type,cre_date,acc_note,created_at,updated_at) SELECT acc_kind, acc_no,acc_date="+params[:acc_date]+",acc_cost,cust_id,cust_type,cre_date,acc_note,created_at,updated_at FROM accounts a WHERE a.acc_date="+usemakedate+" and (select COUNT(*) from accounts where acc_date="+params[:acc_date]+")< 1")
    else
       custid = Customer.select(:cust_id).where(cust_id:  params[:cust_id],won_staff: @wonstaff)
       @accounts=Account.all.where(cust_id: params[:cust_id],acc_date: params[:acc_date]).joins(:customer).where(customers: {cust_id: custid}).order(cust_id: :asc,created_at: :desc).page(params[:page]).per(10)
       @rowsum=Account.all.where(cust_id: params[:cust_id],acc_date: params[:acc_date]).joins(:customer).where(customers: {cust_id:  custid}).count()
       @sumcost=Account.all.where(cust_id: params[:cust_id],acc_date: params[:acc_date]).joins(:customer).where(customers: {cust_id: custid}).sum(:acc_cost)
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

    #@accs=Account.all.where(cust_date: @acc_date).joins(:customer).where(customers: {cust_id: custid}).page(params[:page]).per(10)
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
  if custid.size !=0 then
    @acc_count=Account.select(:cust_id).where(cust_id: params[:cust_id],
                              acc_date: params[:acc_date],
                              acc_kind: params[:acc_kind],
                              cust_type: params[:cust_type],
                              acc_cost: params[:acc_cost],
                              acc_note: params[:acc_note],
                              acc_no: params[:acc_no])

         if @acc_count.size == 0 then
              @account=Account.create(cust_id: params[:cust_id],
                            acc_date: params[:acc_date],
                            acc_kind: params[:acc_kind],
                            cust_type: params[:cust_type],
                            acc_cost: params[:acc_cost],
                            acc_note: params[:acc_note],
                            acc_no: params[:acc_no])
              @history =History.create(cust_id: @account.cust_id,
                     acc_date: @account.acc_date,
                     acc_kind: @account.acc_kind,
                     type_bef: @account.cust_type,
                     cost_bef: @account.acc_cost,
                     cost_aft: "",
                     note_bef: @account.acc_note,
                     note_aft: "",
                     no_bef:  @account.acc_no,
                     no_aft:  "",
                     user_id: @wonstaff,
                     mark: "C" )
          end
  else
      puts"ffffff"
  end
      #@accounts=Account.new
      # p "#{custid['cust_id']}"
end





  # GET /accounts/new
  def new
    puts "new"
    @menubars = Menubar.all
    @menubar = @menubars.first
    @menus = Menubar.order(:menu_sn)
    if @current_page != params[:page] || @current_menu_id.blank? then
      @current_menu_id = @menubar.menu_id
      @current_page = params[:page]
    end
=begin
    @acc_count=Account.select(:cust_id).where(cust_id: params[:cust_id],
                              acc_date: params[:acc_date],
                              acc_kind: params[:acc_kind],
                              cust_type: params[:cust_type],
                              acc_cost: params[:acc_cost],
                              acc_note: params[:acc_note],
                              acc_no: params[:acc_no])

         if @acc_count.size == 0 then
             @account=Account.create(cust_id: params[:cust_id],
                              acc_date: params[:acc_date],
                              acc_kind: params[:acc_kind],
                              cust_type: params[:cust_type],
                              acc_cost: params[:acc_cost],
                              acc_note: params[:acc_note],
                              acc_no: params[:acc_no])
            custidsum = Customer.select(:cust_id).where(won_staff: @wonstaff)
            @sumcost=Account.all.joins(:customer).where(customers: {cust_id: custidsum}).sum(:acc_cost)
        end
=end
  end

  # GET /accounts/1/edit
  # POST /accounts
  # POST /accounts.json
  def user_group
    staff = UserGroup.select("won_staff","group").where(login: 'Wu.Doris')  #authenticate_user![:login]
    staff.each do |variable|
      @wonstaff =variable.won_staff
      @group =variable.group

  end


    # puts  u.login+u.won_staff+u.group

  end


  def edit
       @account=Account.find_by(id: params[:id])
       #history now data
       @history =History.create(cust_id: @account.cust_id,
                        acc_date: @account.acc_date,
                        acc_kind: @account.acc_kind,
                        type_bef: @account.cust_type,
                        cost_bef: @account.acc_cost,
                        cost_aft: "",
                        note_bef: @account.acc_note,
                        note_aft: "",
                        no_bef:  @account.acc_no,
                        no_aft:  "",
                        user_id: @wonstaff,
                        mark: "E" )
       @account.update(cust_type: params[:cust_type],acc_cost: params[:acc_cost],acc_note: params[:acc_note],acc_no: params[:acc_no] )
       #history aft change
       @history.update( type_aft: @account.cust_type,
                        cost_aft: @account.acc_cost,
                        note_aft: @account.acc_note,
                        no_aft:  @account.acc_no, )

       custidsum = Customer.select(:cust_id).where(won_staff: @wonstaff)
       @sumcost=Account.all.joins(:customer).where(customers: {cust_id: custidsum}).sum(:acc_cost)
  end
  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json


  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy

      account=Account.find_by(id: params[:id])
      #save History
      History.create(cust_id: account.cust_id,
                       acc_date: account.acc_date,
                       acc_kind: account.acc_kind,
                       type_bef: account.cust_type,
                       cost_bef: account.acc_cost,
                       note_bef: account.acc_note,
                       no_bef: account.acc_no,
                       user_id: @wonstaff,
                       mark: "D" )
      account.destroy


  #  respond_to do |format|
  #    format.html { render :index, notice: 'Account was successfully destroyed.' }
  #    format.json { head :no_content }
  #  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account

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
    def account_params
      params.require(:account).permit(:id,:acc_kind,
      :acc_no,
     :acc_date,
      :acc_cost,
     :cust_id ,
      :cust_type,
        :cre_date,
      :acc_note,
     :cust_name
    )
  end

  def user_params
    params.require(:user_group).permit(:login,
    :group,
   :won_staff
  )
end
end
