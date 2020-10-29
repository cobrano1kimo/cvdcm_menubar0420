class AccountsController < ApplicationController
  include AccountsHelper
  before_action :user_group
  before_action only: [:destroy,:colse_edit]


  # GET /accounts
  # GET /accounts.json
  def index

    @stats=""
    @pagestat=="N"
    #custid = Customer.select(:cust_id).where(won_staff: @wonstaff)
    #@sumcost=Account.all.joins(:customer).where(customers: {cust_id: custid}).sum(:acc_cost)
    @accounts=Account.new
    # p "#{custid['cust_id']}"
    @accounts= Account.all.where(acc_date: @stats).page(params[:page]).per(10)
    #@rowsum= @accounts.count()



    @menubars = Menubar.all
    @menubar = @menubars.first
    @menus = Menubar.order(:menu_sn)
    render :query
    # if @current_page != params[:page] || @current_menu_id.blank? then
    #   @current_menu_id = @menubar.menu_id
    #   @current_page = params[:page]
    # end
  end

  # GET /accounts/1$('
  # GET /accounts/1.json
  def query
    @stats= "query"
    #@accounts=Account.new
    # p "#{custid['cust_id']}"
    @menubars = Menubar.all
    @menubar = @menubars.first
    @menus = Menubar.order(:menu_sn)
    if @current_page != params[:page] || @current_menu_id.blank? then
       @current_menu_id = @menubar.menu_id
       @current_page = params[:page]
    end
     #下個月月份參數
    usemakedate= nextMonth(params[:acc_date])


    if @group=="3" then
      @wonstaff= params[:won_staff]
      #業務人員
      @jobstaff= params[:won_staff]

    end
    #accout add
    if params[:cust_id].empty?

        if @group=="3" then
           #如果是IT人員查詢秀全部
          if @itstaff == @wonstaff then
            custid = Customer.select(:cust_id)

          else
            custid = Customer.select(:cust_id).where(won_staff: @wonstaff)
          end
        else
            #個人使用
          custid = Customer.select(:cust_id).where(won_staff: @wonstaff)
       end

        #account 含　付款月份明細
      @account_test= Account.find_by_sql("EXEC sp_executesql N'SELECT  [accounts].*,[customers].[paymonth01],[customers].[paymonth02],
                              [customers].[paymonth03],[customers].[paymonth04],[customers].[paymonth05]
                             ,[customers].[paymonth06],[customers].[paymonth07],[customers].[paymonth08],[customers].[paymonth09]
                            ,[customers].[paymonth10],[customers].[paymonth11],[customers].[paymonth12]
                            FROM [accounts] INNER JOIN [customers] ON [customers].[cust_id] =
                           [accounts].[cust_id] WHERE [accounts].[acc_date] = @0 AND [customers].[cust_id] IN
                            (SELECT [customers].[cust_id] FROM [customers] WHERE 1 = @1)',
                            N'@0 nvarchar(4000), @1 nvarchar(4000)', @0 = N'202008', @1 =1")
     #puts 40100111111111111
      @custid_paymounts= Account.find_by_sql("EXEC sp_executesql N'SELECT  a.cust_id+b.paymonth01+b.paymonth02+b.paymonth03+b.paymonth04+b.paymonth05
                                                 +b.paymonth06+b.paymonth07+b.paymonth08+b.paymonth09+b.paymonth10+
                                                 b.paymonth11+b.paymonth12 as paymontharry
                                                FROM accounts a INNER JOIN customers b ON b.cust_id =
                                               a.cust_id WHERE a.acc_date = @0 AND b.cust_id IN
                                                (SELECT b.cust_id FROM customers b WHERE 1 = @1)',
                                              N'@0 nvarchar(4000), @1 nvarchar(4000)', @0 = N'"+params[:acc_date]+"', @1 = 1" )

       @accounts=Account.all.where(acc_date:  params[:acc_date]).joins(:customer).where(customers: {cust_id:  custid}).order(cust_id: :asc,created_at: :desc).page(params[:page]).per(10)
       @account_test=change_Paymark(@account_test) #是否出不出帳邏輯
         @account_test.each do |p|
           @accounts.each do |a|
             if p.cust_id==a.cust_id && p.cust_type==a.cust_type
                a.paymark=p.paymark
             end
           end
         end
       @rowsum=Account.all.where(acc_date:  params[:acc_date]).joins(:customer).where(customers: {cust_id:  custid}).count()
       @sumcost=Account.all.where(acc_date:  params[:acc_date]).joins(:customer).where(customers: {cust_id: custid}).sum(:acc_cost).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse

       #Account.find_by_sql("INSERT INTO accounts(acc_kind, acc_no,acc_date,acc_cost,cust_id,cust_type,cre_date,acc_note,created_at,updated_at) SELECT acc_kind, acc_no,acc_date="+params[:acc_date]+",acc_cost,cust_id,cust_type,cre_date,acc_note,created_at,updated_at FROM accounts a WHERE a.acc_date="+usemakedate+" and (select COUNT(*) from accounts where acc_date="+params[:acc_date]+")< 1")
     #沒資訊自動帶上個月
     if @rowsum==0 then
                       Account.find_by_sql("EXEC sp_executesql N'INSERT INTO accounts(acc_kind, acc_no,acc_date,acc_cost,cust_id,cust_type,cre_date,acc_note,created_at,updated_at) SELECT a.acc_kind, acc_no= @5,acc_date= @0,acc_cost= @6,a.cust_id,a.cust_type,a.cre_date,a.acc_note,a.created_at,a.updated_at FROM accounts a inner join customers b on a.cust_id=b.cust_id and a.acc_date= @1 and b.won_staff= @2
                          where not exists(select c.cust_id,c.cust_type, c.acc_date from accounts c where a.cust_id=c.cust_id and a.cust_type=c.cust_type and a.acc_date=c.acc_date and a.acc_date<> @3 and b.won_staff= @4)', N'@0 nvarchar(4000),@1 nvarchar(4000),@2 nvarchar(4000),@3 nvarchar(4000),@4 nvarchar(4000),@5 nvarchar(4000),@6 int',@0 = N'"+params[:acc_date]+"', @1 = N'"+usemakedate+"',@2 = N'"+@wonstaff+"',@3 = N'"+usemakedate+"',@4 = N'"+@wonstaff+"'
                          ,@5 = N'',@6 = N'0'")
     end

    else
      if @group=="3" then
         #如果是IT人員查詢秀全部
        if @itstaff == @wonstaff then
           custid = Customer.select(:cust_id).where(cust_id:  params[:cust_id])
        else
           custid = Customer.select(:cust_id).where(cust_id:  params[:cust_id],won_staff: @wonstaff)
        end
      else
          #個人使用
         custid = Customer.select(:cust_id).where(cust_id:  params[:cust_id],won_staff: @wonstaff)
     end

       @accounts=Account.all.where(cust_id: params[:cust_id],acc_date: params[:acc_date]).joins(:customer).where(customers: {cust_id: custid}).order(cust_id: :asc,cust_type: :asc,acc_no: :asc,created_at: :desc).page(params[:page]).per(10)

       @rowsum=Account.all.where(cust_id: params[:cust_id],acc_date: params[:acc_date]).joins(:customer).where(customers: {cust_id:  custid}).count()
       @sumcost=Account.all.where(cust_id: params[:cust_id],acc_date: params[:acc_date]).joins(:customer).where(customers: {cust_id: custid}).sum(:acc_cost).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse

    end



   @input0 = params[:cust_id] if params[:cust_id].present?
   @date_yy = params[:acc_date].first(4) if params[:acc_date].present?
   @date_mm = params[:acc_date].last(2) if params[:acc_date].present?
   @won_staff = params[:won_staff] if params[:won_staff].present?
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

  if @group=="3" then
  @wonstaff=params[:won_staff]
  @jobstaff=params[:won_staff]
  end
  custid = Customer.select(:cust_id).where(cust_id: params[:cust_id],won_staff: @wonstaff)
  puts custid
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
            if @group=="3" then
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
                     user_id:  @jobstaff,
                     operator: @itstaff,
                     mark: "C" )
              else
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
                     operator: @wonstaff,
                     mark: "C" )
                   end
          end
          @accounts =Account.all.where(cust_id: params[:cust_id],acc_no: params[:acc_no],acc_date: params[:acc_date]).page(params[:page]).per(10)
          render :query
  else
        @msgcreat="無此客戶編號"
      render :new

  end

      #@accounts=Account.new
      # p "#{custid['cust_id']}"
end





  # GET /accounts/new
  def new

    @menubars = Menubar.all
    @menubar = @menubars.first
    @menus = Menubar.order(:menu_sn)
    if @current_page != params[:page] || @current_menu_id.blank? then
      @current_menu_id = @menubar.menu_id
      @current_page = params[:page]
    end
    if @group=="3" then
      #將業務人員帶入
    @wonstaff=  params[:won_staff]

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
    staff = UserGroup.select("won_staff","group").where(login: authenticate_user![:login])  #authenticate_user![:login]"Wu.Doris"
    staff.each do |variable|
      @wonstaff =variable.won_staff
      @group =variable.group
      @itstaff =variable.won_staff
  end


    # puts  u.login+u.won_staff+u.group

  end


  def edit
    @menubars = Menubar.all
    @menubar = @menubars.first
    @menus = Menubar.order(:menu_sn)
    if @current_page != params[:page] || @current_menu_id.blank? then
      @current_menu_id = @menubar.menu_id
      @current_page = params[:page]
    end
       @account=Account.find_by(id: params[:id])
       if @group=="3" then
         Customer.select('DISTINCT won_staff').where(cust_id: @account.cust_id).each do |x|
         @jobstaff= x.won_staff
         end
       end
       #history now data

       if @group=="3" then

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
                        user_id:  @jobstaff,
                        operator: @itstaff,
                        mark: "E" )

          else
          @history = History.create(cust_id: @account.cust_id,
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
                           operator: @wonstaff,
                           mark: "E" )

            end
       @account.update(cust_type: params[:cust_type],acc_cost: params[:acc_cost],acc_note: params[:acc_note],acc_no: params[:acc_no] )
       #history aft change
       @history.update( type_aft: @account.cust_type,
                        cost_aft: @account.acc_cost,
                        note_aft: @account.acc_note,
                        no_aft:  @account.acc_no, )

      end
  def colse_edit
     @menubars = Menubar.all
     @menubar = @menubars.first
     @menus = Menubar.order(:menu_sn)
     if @current_page != params[:page] || @current_menu_id.blank? then
      @current_menu_id = @menubar.menu_id
      @current_page = params[:page]
     end
     @account=Account.find_by(id: params[:id])
     @account.update(clo_date: Time.now,clo_mark: "Y")

  end
  def open_edit
     @menubars = Menubar.all
     @menubar = @menubars.first
     @menus = Menubar.order(:menu_sn)
     if @current_page != params[:page] || @current_menu_id.blank? then
      @current_menu_id = @menubar.menu_id
      @current_page = params[:page]
     end
     @account=Account.find_by(id: params[:id])
     @account.update(clo_date: "NULL",clo_mark: "N")

  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json


  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
      account=Account.find_by(id: params[:id])

      if @group=="3" then
        Customer.select('DISTINCT won_staff').where(cust_id: account.cust_id).each do |x|
        @jobstaff= x.won_staff
        end
      end
      #save History
      History.create(cust_id: account.cust_id,
                       acc_date: account.acc_date,
                       acc_kind: account.acc_kind,
                       type_bef: account.cust_type,
                       cost_bef: account.acc_cost,
                       note_bef: account.acc_note,
                       no_bef: account.acc_no,
                       user_id: @jobstaff,
                       operator: @wonstaff,
                       mark: "D" )
      account.destroy
  #  respond_to do |format|
  #    format.html { render :index, notice: 'Account was successfully destroyed.' }
  #    format.json { head :no_content }
  #  end
  end
  #列印的ACTION
 def printp

   @menubars = Menubar.all
   @menubar = @menubars.first
   @menus = Menubar.order(:menu_sn)

   acc_yyyy_mm = params[:acc_date]
   yyyy_mm = (acc_yyyy_mm[0..3].to_i-1911).to_s+"年"+(acc_yyyy_mm[4..5])+'月'
   user_name = @wonstaff
   if  params[:won_staff]!="undefined" then
     user_name= params[:won_staff]
   end
   group = @group
   # $dlurl=["#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.pdf","#{Rails.root}/public/#{yyyy_mm+"倉儲費用小計"}.pdf","#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.xlsx"]

   send_file printp_pdf(yyyy_mm,acc_yyyy_mm,user_name),
            type: "application/pdf",
            streaming: "true",
            buffer_size: "4096"

   #render :resultp
 end

 def printe

   @menubars = Menubar.all
   @menubar = @menubars.first
   @menus = Menubar.order(:menu_sn)

   acc_yyyy_mm = params[:acc_date]
   yyyy_mm = (acc_yyyy_mm[0..3].to_i-1911).to_s+"年"+(acc_yyyy_mm[4..5])+'月'
   user_name = @wonstaff
   puts @wonstaff
    if  params[:won_staff]!="undefined" then
      user_name= params[:won_staff]
    end
   group = @group
   # $dlurl=["#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.pdf","#{Rails.root}/public/#{yyyy_mm+"倉儲費用小計"}.pdf","#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.xlsx"]

   send_file printe_xlsx(yyyy_mm,acc_yyyy_mm,user_name),
            type: "application/xlsx",
            streaming: "true",
            buffer_size: "4096"

   #render :resultp
 end
   # ----------------------------------------------------------------------------------------------------------------------

   # ----------------------------------------------------------------------------------------------------------------------

 def printp1

   acc_yyyy_mm = params[:acc_date]
   yyyy_mm = (acc_yyyy_mm[0..3].to_i-1911).to_s+"年"+(acc_yyyy_mm[4..5])+'月'

   user_name = @wonstaff
    if  params[:won_staff]!="undefined" then
      user_name= params[:won_staff]
    end
   group = @group
   # $dlurl=["#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.pdf","#{Rails.root}/public/#{yyyy_mm+"倉儲費用小計"}.pdf","#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.xlsx"]

   send_file printp1_pdf(yyyy_mm,acc_yyyy_mm,user_name),
            type: "application/pdf",
            streaming: "true",
            buffer_size: "4096"
 end
   private

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
     :cust_name,
     :pagebar

    )
  end

  def user_params
    params.require(:user_group).permit(:login,
    :group,
   :won_staff
  )
end
end
