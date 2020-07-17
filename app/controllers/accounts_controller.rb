require 'prawn'
require 'prawn/table'


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
    @accounts=Account.new
    # p "#{custid['cust_id']}"
    @accounts=Account.all.joins(:customer).where(customers: {cust_id: custid}).page(params[:page]).per(10)
    @rowsum= @accounts.count()
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

               puts @stats
       if  params[:page]==""
         @page="nochange"


       end
       @rowsum=Account.all.where(acc_date:  params[:acc_date]).joins(:customer).where(customers: {cust_id:  custid}).count()
       @sumcost=Account.all.where(acc_date:  params[:acc_date]).joins(:customer).where(customers: {cust_id: custid}).sum(:acc_cost)
       #沒資訊自動帶上個月

       Account.find_by_sql("INSERT INTO accounts(acc_kind, acc_no,acc_date,acc_cost,cust_id,cust_type,cre_date,acc_note,created_at,updated_at) SELECT acc_kind, acc_no,acc_date="+params[:acc_date]+",acc_cost,cust_id,cust_type,cre_date,acc_note,created_at,updated_at FROM accounts a WHERE a.acc_date="+usemakedate+" and (select COUNT(*) from accounts where acc_date="+params[:acc_date]+")< 1")
    else
       custid = Customer.select(:cust_id).where(cust_id:  params[:cust_id],won_staff: @wonstaff)
       @accounts=Account.all.where(cust_id: params[:cust_id],acc_date: params[:acc_date]).joins(:customer).where(customers: {cust_id: custid}).order(cust_id: :asc,created_at: :desc).page(params[:page]).per(10)
       firstpage2 = @accounts.current_page
       puts "firstpage2=" +firstpage2.to_s
       if firstpage2 != 1 and params[:page]==""
         params[:page]= 1
           @accounts=Account.all.where(cust_id: params[:cust_id],acc_date: params[:acc_date]).joins(:customer).where(customers: {cust_id: custid}).order(cust_id: :asc,created_at: :desc).page(params[:page]).per(10)
       end
       @accounts=Account.all.where(cust_id: params[:cust_id],acc_date: params[:acc_date]).joins(:customer).where(customers: {cust_id: custid}).order(cust_id: :asc,created_at: :desc).page(params[:page]).per(10)
       @rowsum=Account.all.where(cust_id: params[:cust_id],acc_date: params[:acc_date]).joins(:customer).where(customers: {cust_id:  custid}).count()
       @sumcost=Account.all.where(cust_id: params[:cust_id],acc_date: params[:acc_date]).joins(:customer).where(customers: {cust_id: custid}).sum(:acc_cost)
       puts "noempty"
    end

       puts params[:page]
   if params[:page].to_i == 1
    @page="change"
    puts "change1"
  elsif params[:page].to_i == 0
     puts "nochange"
    @page="nochange"
  else
    @page="change"
    puts "change2"
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
  #列印的ACTION
 def printp

   @menubars = Menubar.all
   @menubar = @menubars.first
   @menus = Menubar.order(:menu_sn)

   acc_yyyy_mm = params[:acc_date]
   yyyy_mm = (acc_yyyy_mm[0..3].to_i-1911).to_s+"年"+(acc_yyyy_mm[4..5])+'月'
   user_name = @wonstaff
   # acc_total = 0

   $dlurl=["#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.pdf","#{Rails.root}/public/#{yyyy_mm+"倉儲費用小計"}.pdf","#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.xlsx"]

   generate_pdf(yyyy_mm,acc_yyyy_mm,user_name)

   @dlfilenamep=$dlurl[0].last(15)
   @dlfilenamep1=$dlurl[1].last(17)
   @dlfilenamee=$dlurl[2].last(16)

   send_file $dlurl[0],
            type: "application/pdf",
            streaming: "true",
            buffer_size: "4096"

   #render :resultp
 end
   # ----------------------------------------------------------------------------------------------------------------------

   # ----------------------------------------------------------------------------------------------------------------------

 def resulte
   send_file $dlurl[2],
          type: "application/xlsx",
          streaming: "true",
          buffer_size: "4096"
 end

 def resultp
   send_file $dlurl[0],
            type: "application/pdf",
            streaming: "true",
            buffer_size: "4096"

 end

def resultp1

  send_file $dlurl[1],
         type: "application/pdf",
         streaming: "true",
         buffer_size: "4096"

end
   private

    # Use callbacks to share common setup or constraints between actions.
    # def set_account
    # end

  def generate_pdf(yyyy_mm,acc_yyyy_mm,user_name)

   # if File.exists?("#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.pdf")
   #   File.delete("#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.pdf")
   # end



   # Prawn::Document.generate("#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.pdf") do
     # 産生「倉儲費用報表」

    if File.exist?("#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.pdf")
       File.delete("#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.pdf")
    end

     info = {
     :Title        => "ACCOUNT GENERAL",
     :Author       => "CROWN VAN",
     :Subject      => "ACCOUNT GENERAL LIST",
     :Keywords     => "",
     :Creator      => "CROWN VAN DOCUMENT MANAGEMENT SYSTEM",
     :Producer     => "CROWN VAN LINES CO., LTD.",
     :CreationDate => Time.now
     }


     Prawn::Document.generate("#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.pdf", :page_size => "A4", :page_layout => :portrait, :print_scaling => :none, :info => info) do

       acc_total = 0
       Account.joins(:customer).select("sum(acc_cost) as acc_cost").where(accounts: {acc_date: acc_yyyy_mm}).each { |row|
         acc_total = acc_total + row['acc_cost'] if !row['acc_cost'].nil?
       }

       keep_position = 0
       # stroke_axis
       font("#{Prawn::DATADIR}/fonts/wt024.ttf") do
         repeat(:all) do

           text "海灣國際股份有限公司", :align => :center, :size => 18
           text yyyy_mm+"倉儲費用", :align => :center, :size => 14
           text "總金額："+acc_total.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse, :align => :center, :size => 14

           keep_position = cursor.to_i
           bounding_box([400, 764], :width => 120, :height => 15) do
             transparent(0) { stroke_bounds }
             text "列印日期："+Date.today.strftime("%Y/%m/%d")
           end

           bounding_box([400, 747], :width => 120, :height => 15) do
             transparent(0) { stroke_bounds } # This will stroke on one page
             text "列印人員："+user_name
             transparent(0) { stroke_bounds } # And this will stroke on the next
           end

           move_cursor_to keep_position

         end
       end

       i = 0
       iItem = 0
       iRowCount = Account.joins(:customer).where(accounts: {acc_date: acc_yyyy_mm}).count

       font("#{Prawn::DATADIR}/fonts/wt024.ttf") do
         data = [["項次","客戶編號","客戶名稱","帳單編號","帳單金額","帳單種類","備註"]]

         Account.joins(:customer).select("accounts.cust_id, cust_name, cust_type, acc_kind, acc_no, acc_cost, acc_note").where(accounts: {acc_date: acc_yyyy_mm}).order("cust_id ASC, cust_type ASC").each { |row|

           i = i + 1
           iItem = iItem + 1
           data += [[iItem.to_s,
                    "#{row['cust_id']}",
                    "#{row['cust_name']}",
                    "#{row['acc_kind']}-#{row['acc_no']}",
                    "#{row['acc_cost']}".reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse,
                    "#{row['cust_type']}",
                    "#{row['acc_note']}" ]]

           if iItem.modulo(31)==0
             table data do |dt|
               dt.header = true
               dt.column_widths = [35, 50, 130, 60, 60, 60, 127]
               dt.column(0).style(:align => :center, :size => 10)
               dt.column(1).style(:align => :center, :size => 10)

               dt.cells.columns(2).rows(1..-1).filter do |cell|
                   auto_size = (cell.content.size/12.0).ceil()>1 ? 10 - ((cell.content.size/12.0).ceil()-1)*3 : 10
                   cell.style(:align => :left, :size => auto_size )
               end

               dt.column(3).style(:align => :left, :size => 10)
               dt.column(4).style(:align => :right, :size => 10)

               dt.cells.columns(5).rows(1..-1).filter do |cell|
                   auto_size = (cell.content.size/12.0).ceil()>1 ? 10 - ((cell.content.size/12.0).ceil()-1)*3 : 10
                   cell.style(:align => :left, :size => auto_size )
               end

               dt.cells.columns(6).rows(1..-1).filter do |cell|
                  auto_size = (cell.content.size/11.0).ceil()>1 ? 10 - ((cell.content.size/11.0).ceil()-1)*3 : 10
                  cell.style(:align => :left, :size => auto_size )
               end

               dt.row(0).columns(0..6).size = 10
               data = [["項次","客戶編號","客戶名稱","帳單編號","帳單金額","帳單種類","備註"]]
               move_cursor_to keep_position
             end

             start_new_page
           end

           if iItem.modulo(31)!=0 && iRowCount==(i+1)
             move_cursor_to keep_position
             table data do |dt|
               dt.header = true
               dt.column_widths = [35, 50, 130, 60, 60, 60, 127]
               dt.column(0).style(:align => :center, :size => 10)
               dt.column(1).style(:align => :center, :size => 10)
               dt.column(2).style(:align => :left, :size => 10)
               dt.column(3).style(:align => :left, :size => 10)
               dt.column(4).style(:align => :right, :size => 10)
               dt.column(5).style(:align => :left, :size => 10)
               dt.column(6).style(:align => :left, :size => 10)
               dt.row(0).columns(0..6).size = 10
             end
           end

         }

           string = "page <page> of <total>"
           options = { :at => [0, 0],
           :align => :center,
           :start_count_at => 1,
           :color => "000000" }
           number_pages string, options

       end
     end
   # end


   # 産生「倉儲費用小計報表」


   if File.exist?(yyyy_mm+"倉儲費用小計.pdf")
     File.delete(yyyy_mm+"倉儲費用小計.pdf")
   end

   info = {
   :Title        => "ACCOUNT GENERAL SUMMARY",
   :Author       => "CROWN VAN",
   :Subject      => "ACCOUNT GENERAL SUMMARY LIST",
   :Keywords     => "",
   :Creator      => "CROWN VAN DOCUMENT MANAGEMENT SYSTEM",
   :Producer     => "CROWN VAN LINES CO., LTD.",
   :CreationDate => Time.now
   }

   Prawn::Document.generate("#{Rails.root}/public/#{yyyy_mm+"倉儲費用小計"}.pdf", :page_size => "A4", :page_layout => :portrait, :print_scaling => :none, :info => info) do

     acc_total = 0
     Account.joins(:customer).select("sum(acc_cost) as acc_cost").where(accounts: {acc_date: acc_yyyy_mm}).each { |row|
       acc_total = acc_total + row['acc_cost'] if !row['acc_cost'].nil?
     }

     keep_position = 0
     font("#{Prawn::DATADIR}/fonts/wt024.ttf") do
       repeat(:all) do

           text "海灣國際股份有限公司", :align => :center, :size => 18
           text yyyy_mm+"倉儲費用小計", :align => :center, :size => 14
           text "總金額："+acc_total.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse, :align => :center, :size => 14

           keep_position = cursor.to_i
           bounding_box([400, 764], :width => 120, :height => 15) do
             transparent(0) { stroke_bounds }
             text "列印日期："+Date.today.strftime("%Y/%m/%d")
           end

           bounding_box([400, 747], :width => 120, :height => 15) do
             transparent(0) { stroke_bounds } # This will stroke on one page
             text "列印人員："+user_name
             transparent(0) { stroke_bounds } # And this will stroke on the next
           end

           move_cursor_to keep_position

       end
     end

     i = 0
     iItem = 0
     iRowCount = Account.joins(:customer).group("accounts.cust_id").where(accounts: {acc_date: acc_yyyy_mm}).count

     font("#{Prawn::DATADIR}/fonts/wt024.ttf") do
       data = [["項次","客戶編號","客戶名稱","小計金額"]]

       Account.joins(:customer).select("accounts.cust_id, cust_name, sum(acc_cost) as acc_cost").group("accounts.cust_id, cust_name").where(accounts: {acc_date: acc_yyyy_mm}).order("cust_id ASC").each { |row|

         i = i + 1
         iItem = iItem + 1
         data += [[iItem.to_s,
                  "#{row['cust_id']}",
                  "#{row['cust_name']}",
                  "#{row['acc_cost']}".reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse ]]

         if iItem.modulo(31)==0
           table data do |dt|
             dt.header = true
             dt.column_widths = [35, 50, 377, 60]
             dt.column(0).style(:align => :center, :size => 10)
             dt.column(1).style(:align => :center, :size => 10)
             dt.column(2).style(:align => :left, :size => 10)
             dt.column(3).style(:align => :right, :size => 10)
             dt.row(0).columns(0..3).size = 10

             data = [["項次","客戶編號","客戶名稱","小計金額"]]
             move_cursor_to keep_position
           end

           start_new_page
         end

         if (iItem.modulo(31)!=0) && (iRowCount.size==(iItem))
           move_cursor_to keep_position
           table data do |dt|
             dt.header = true
             dt.column_widths = [35, 50, 377, 60]
             dt.column(0).style(:align => :center, :size => 10)
             dt.column(1).style(:align => :center, :size => 10)
             dt.column(2).style(:align => :left, :size => 10)
             dt.column(3).style(:align => :right, :size => 10)
             dt.row(0).columns(0..3).size = 10
           end
         end

       }

         string = "page <page> of <total>"
         options = { :at => [0, 0],
         :align => :center,
         :start_count_at => 1,
         :color => "000000" }
         number_pages string, options

     end

 end
 if File.exist?("#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.xlsx")
    File.delete("#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.xlsx")
 end
 workbook = WriteXLSX.new("#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.xlsx")

 # Add a worksheet
 worksheet = workbook.add_worksheet
 # worksheet1 = workbook.add_worksheet('Named colors')

 # Add and define a format
 # format = workbook.add_format # Add a format
 # format.set_bold
 # format.set_color('red')
 # format.set_align('center')

 # Some common formats
 center  = workbook.add_format(:align => 'center')
 # heading = workbook.add_format(:align => 'center', :bold => 1)
 # bold = workbook.add_format( :bold => 1 )

 # Write a hyperlink
 # hyperlink_format = workbook.add_format(
 #                      :color     => 'blue',
 #                      :underline => 1
 #                                       )

 # Formats used in the workbook.
 # percent_format = workbook.add_format(:num_format => '0.0%'
 # date_format = workbook.add_format(:num_format => 'dd/mm/yyyy')
 # chart       = workbook.add_chart(:type => 'stock', :embedded => 1)


 # colors = {
 #                 0x08 => 'black',
 #                 0x0C => 'blue',
 #                 0x10 => 'brown',
 #                 0x0F => 'cyan',
 #                 0x17 => 'gray',
 #                 0x11 => 'green',
 #                 0x0B => 'lime',
 #                 0x0E => 'magenta',
 #                 0x12 => 'navy',
 #                 0x35 => 'orange',
 #                 0x21 => 'pink',
 #                 0x14 => 'purple',
 #                 0x0A => 'red',
 #                 0x16 => 'silver',
 #                 0x09 => 'white',
 #                 0x0D => 'yellow',
 #         }



 # order.each do |index|
 #   format = workbook.add_format(
 #       :fg_color => colors[index],
 #       :pattern  => 1,
 #       :border   => 1
 #   )


 # (8..63).each do |i|
 #   format = workbook.add_format(
 #       :fg_color => i,
 #       :pattern  => 1,
 #       :border   => 1
 #   )

 # text_wrap  = workbook.add_format( :text_wrap => 1, :valign => 'top' )

 # Light red fill with dark red text.
 # format1 = workbook.add_format(
 #     :bg_color => '#FFC7CE',
 #     :color    => '#9C0006'
 # )

 # Green fill with dark green text.
 # format2 = workbook.add_format(
 #     :bg_color => '#C6EFCE',
 #     :color    => '#006100'
 # )


 # heading = workbook.add_format(
 #     :bold  => 1,
 #     :color => 'blue',
 #     :size  => 16,
 #     :merge => 1,
 #     :align => 'vcenter'
 # )
 #
 # hyperlink_format = workbook.add_format(
 #     :color => 'blue',
 #     :underline => 1
 # )


 #######################################################################
 #
 # Some text examples
 #
 # text_format = workbook.add_format(
 #     :bold   => 1,
 #     :italic => 1,
 #     :color  => 'red',
 #     :size   => 18,
 #     :font   => 'Lucida Calligraphy'
 # )

 #######################################################################
 #
 # Some numeric examples
 #
 # num1_format = workbook.add_format(:num_format => '$#,##0.00')
 # num2_format = workbook.add_format(:num_format => ' d mmmm yyy')

 # format1 = workbook.add_format(:diag_type => 1)
 # format2 = workbook.add_format(:diag_type => 2)
 # format3 = workbook.add_format(:diag_type => 3)
 #
 # format4 = workbook.add_format(
 #     :diag_type   => 3,
 #     :diag_border => 7,
 #     :diag_color  => 'red'
 # )


 # worksheet.set_column(0, 0, 60)
 #
 # format = workbook.add_format
 # format.set_bold
 # format.set_size(14)
 # format.set_color('blue')
 # format.set_align('center')
 #
 # format2 = workbook.add_format
 # format2.set_bold
 # format2.set_color('blue')
 #
 # format3 = workbook.add_format(
 #                               :color     => 'blue',
 #                               :underline => 1,
 #                              )

 # format = workbook.add_format(
 #                              :bg_color => color,
 #                              :pattern  => 1,
 #                              :border   => 1
 #                             )

 # Create a merged format
 # format = workbook.add_format(
 #     :center_across => 1,
 #     :bold          => 1,
 #     :size          => 15,
 #     :pattern       => 1,
 #     :border        => 6,
 #     :color         => 'white',
 #     :fg_color      => 'green',
 #     :border_color  => 'yellow',
 #     :align         => 'vcenter'
 # )


 # Write a formatted and unformatted string, row and column notation.
 item = 0
 worksheet.write(item, 0, "項次")
 worksheet.write(item, 1, "客戶編號")
 worksheet.write(item, 2, "客戶名稱")
 worksheet.write(item, 3, "帳單名稱")
 worksheet.write(item, 4, "帳單類別")
 worksheet.write(item, 5, "帳單編號")
 worksheet.write(item, 6, "帳單金額")
 worksheet.write(item, 7, "其他說明")


 worksheet.autofilter( 'A1:G1' )

 # worksheet.write(row, col, "Hi Excel!", format)
 # worksheet.write(1,   col, "Hi Excel!")

 # Write a number and a formula using A1 notation
 # worksheet.write('A3', 1.2345)
 # worksheet.write('A4', '=SIN(PI()/4)')


 #
 Account.joins(:customer).select("accounts.cust_id, cust_name, cust_type, acc_kind, acc_no, acc_cost, acc_note").where(accounts: {acc_date: acc_yyyy_mm}).order("cust_id ASC, cust_type ASC").each { |row|

   item = item + 1
   worksheet.write(item, 0, item)
   worksheet.write(item, 1, "#{row['cust_id']}")
   worksheet.write(item, 2, "#{row['cust_name']}")
   worksheet.write(item, 3, "#{row['cust_type']}")
   worksheet.write(item, 4, "#{row['acc_kind']}")
   worksheet.write(item, 5, "#{row['acc_no']}")
   worksheet.write(item, 6, "#{row['acc_cost']}")
   worksheet.write(item, 7, "#{row['acc_note']}")

   # puts "#{row['id']}"" #{row['acc_kind']} #{row['acc_no']}"
 }

 workbook.close

  return ["#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.pdf","#{Rails.root}/public/#{yyyy_mm+"倉儲費用小計"}.pdf","#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.xlsx"]
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
