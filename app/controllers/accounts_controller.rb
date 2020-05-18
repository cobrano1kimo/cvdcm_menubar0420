class AccountsController < ApplicationController
  before_action :user_group
  before_action :set_account, only: [ :edit, :destroy]


  # GET /accounts
  # GET /accounts.json
  def index
    @stat="index"
    custid = Customer.select(:cust_id).where(won_staff: @wonstaff)
    @sumcost=Account.all.joins(:customer).where(customers: {cust_id: custid}).sum(:acc_cost)
    @account=Account.new

    # p "#{custid['cust_id']}"
    @accounts=Account.all.joins(:customer).where(customers: {cust_id: custid}).page(params[:page]).per(10)

    @menubars = Menubar.all
    @menubar = @menubars.first
    @menus = Menubar.order(:menu_sn)
    if @current_page != params[:page] || @current_menu_id.blank? then
      @current_menu_id = @menubar.menu_id
      @current_page = params[:page]
    end

  end

  # GET /accounts/1$('
  # GET /accounts/1.json
  def query
    @menubars = Menubar.all
    @menubar = @menubars.first
    @menus = Menubar.order(:menu_sn)
    if @current_page != params[:page] || @current_menu_id.blank? then
      @current_menu_id = @menubar.menu_id
      @current_page = params[:page]
    end
      @stat="query"
    custid = Customer.select(:cust_id).where(won_staff: @wonstaff)
    @account=Account.new
    puts  params[:cust_id] +  params[:acc_date]
    if params[:cust_id].empty?
      puts "empty"
       @accounts=Account.all.where(acc_date:  params[:acc_date]).joins(:customer).where(customers: {cust_id:  custid}).page(params[:page]).per(10)
       @sumcost=Account.all.where(acc_date:  params[:acc_date]).joins(:customer).where(customers: {cust_id: custid}).sum(:acc_cost)
    else
      puts "no empty"
       @accounts=Account.all.where(cust_id:  params[:cust_id],acc_date:  params[:acc_date]).joins(:customer).where(customers: {cust_id:  params[:cust_id]}).page(params[:page]).per(10)
       @sumcost=Account.all.where(cust_id:  params[:cust_id],acc_date:  params[:acc_date]).joins(:customer).where(customers: {cust_id: custid}).sum(:acc_cost)
    end


  end
    # p "#{custid['cust_id']}"

    #@accs=Account.all.where(cust_date: @acc_date).joins(:customer).where(customers: {cust_id: custid}).page(params[:page]).per(10)






  # GET /accounts/new
  def new
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
  end

  # GET /accounts/1/edit
  # POST /accounts
  # POST /accounts.json
  def user_group
    staff = UserGroup.select("won_staff").where(login: 'Chen.Eileen')  #authenticate_user![:login]
    staff.each do |variable|
      @wonstaff =variable.won_staff

  end


    # puts  u.login+u.won_staff+u.group

  end


  def edit
       @account=Account.find_by(id: params[:id])
       @account.update(cust_type: params[:cust_type],acc_cost: params[:acc_cost],acc_note: params[:acc_note],acc_no: params[:acc_no] )
       custidsum = Customer.select(:cust_id).where(won_staff: @wonstaff)
       @sumcost=Account.all.joins(:customer).where(customers: {cust_id: custidsum}).sum(:acc_cost)
  end
  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json


  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy

      account=Account.find_by(id: params[:id])
      account.destroy

 #format.js   { render :layout => false }

  #  respond_to do |format|
  #    format.html { render :index, notice: 'Account was successfully destroyed.' }
  #    format.json { head :no_content }
  #  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account

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
