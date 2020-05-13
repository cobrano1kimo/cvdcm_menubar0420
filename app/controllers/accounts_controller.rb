class AccountsController < ApplicationController
  before_action :user_group
  before_action :set_account, only: [:show, :edit, :update, :destroy]


  # GET /accounts
  # GET /accounts.json
  def index

    custid = Customer.select(:cust_id).where(won_staff: @wonstaff)
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
  def show
    custid = Customer.select(:cust_id).where(won_staff: @wonstaff)

    if params[:id].size == 6
       @acc_date=params[:id]
       @accounts=Account.where(acc_date: @acc_date).joins(:customer).where(customers: {cust_id: custid}).page(params[:page]).per(10)
    else
       @acc_date=params[:id][5,6]
       @cust_id= params[:id][0,5]
       @accounts=Account.where(cust_id: @cust_id,acc_date: @acc_date).joins(:customer).where(customers: {cust_id: custid}).page(params[:page]).per(10)
    end




  end
    # p "#{custid['cust_id']}"

    #@accs=Account.all.where(cust_date: @acc_date).joins(:customer).where(customers: {cust_id: custid}).page(params[:page]).per(10)





  # GET /accounts/new
  def new
    @account = Account.new
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

  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
       @account=Account.find_by(id: params[:id])
       @account.update(cust_type: params[:cust_type],acc_cost: params[:acc_cost],acc_note: params[:acc_note],acc_no: params[:acc_no] )
  end
  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json


  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy

      account=Account.find_by(id: params[:id])
      account.destroy
      respond_to do |format|
      format.html { render :showform , notice: 'Account was successfully destroyed.'}
      format.json { head :no_content }
 #format.js   { render :layout => false }
end
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
