module AccountsHelper

  #EXCEL含小計
  def printe_xlsx(yyyy_mm,acc_yyyy_mm,user_name)
  if @group=="1" then
  custid = Customer.select(:cust_id).where(won_staff: user_name)
  if File.exist?("#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.xlsx")
    File.delete("#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.xlsx")
  end
  workbook = WriteXLSX.new("#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.xlsx")


  # Add a worksheet1
  worksheet1 = workbook.add_worksheet(yyyy_mm+'倉儲費用')
  # worksheet1.margins = 0.2
  worksheet1.margin_left = 0.5
  worksheet1.margin_right = 0.5
  worksheet1.margin_top = 0.5
  worksheet1.margin_bottom = 0.5


  worksheet1.repeat_rows(0, 3)


  worksheet1.set_footer('&CPage &P of &N');

  # The activate() method is used to specify which worksheet1 is initially visible in a multi-sheet workbook:
  worksheet1.activate



  format_title = workbook.add_format(:num_format => '@', :size => 16, :bold => 1)
  format_subtitle = workbook.add_format(:num_format => '@', :size => 14, :bold => 0)
  format_string_center = workbook.add_format(:num_format => '@', :align => 'center')
  format_string_center_background = workbook.add_format(:num_format => '@', :align => 'center', :bg_color => 'silver')
  format_string = workbook.add_format(:num_format => '@')
  format_string_background = workbook.add_format(:num_format => '@', :bg_color => 'silver')


  format_string_shrink = workbook.add_format()
  format_string_shrink.set_num_format('@')
  format_string_shrink.set_shrink(1)

  format_number = workbook.add_format(:num_format => '#,##0')

  worksheet1.set_column('A:A', 5)    # 項次
  worksheet1.set_column('B:B', 8)    # 客戶編號
  worksheet1.set_column('C:C', 18)   # 客戶名稱
  worksheet1.set_column('D:D', 8)    # 帳單編號
  worksheet1.set_column('E:E', 12)   # 帳單金額
  worksheet1.set_column('F:F', 13)   # 帳單名稱
  worksheet1.set_column('G:G', 15)   # 其他說明


  item = 0
  item_count = 0
  worksheet1.set_row(0, 25)
  worksheet1.write(item, 2, "海灣文件倉儲管理系統", format_title)

  item = 1
  worksheet1.set_row(1, 20)
  worksheet1.write(item, 2, yyyy_mm+"倉儲費用", format_subtitle)
  worksheet1.write(item, 5, "列印日期："+Date.today.strftime("%Y/%m/%d"), format_string)

  item = 2
  worksheet1.write(item, 5, "列印人員："+user_name)

  item = 3
  worksheet1.write(item, 0, "項次", format_string_center_background)
  worksheet1.write(item, 1, "客戶編號", format_string_background)
  worksheet1.write(item, 2, "客戶名稱", format_string_background)
  worksheet1.write(item, 3, "帳單編號", format_string_background)
  worksheet1.write(item, 4, "帳單金額", format_string_background)
  worksheet1.write(item, 5, "帳單名稱", format_string_background)
  worksheet1.write(item, 6, "其他說明", format_string_background)

  worksheet1.freeze_panes(item+1, 0)    # Freeze the item row

  worksheet1.autofilter( 'A4:G4' )


  acc_total = 0

  Account.joins(:customer).select("accounts.cust_id, cust_name, cust_type, acc_kind, acc_no, acc_cost, acc_note").where(accounts: {acc_date: acc_yyyy_mm,cust_id: custid}).order("cust_id ASC, cust_type ASC").each { |row|

    item = item + 1
    item_count =  item_count + 1
    worksheet1.write(item, 0, item_count, format_string_center)
    worksheet1.write(item, 1, "#{row['cust_id']}", format_string)
    worksheet1.write(item, 2, "#{row['cust_name']}", format_string_shrink)
    worksheet1.write(item, 3, "#{row['acc_kind']}-#{row['acc_no']}", format_string)
    worksheet1.write(item, 4, "#{row['acc_cost']}", format_number)
    worksheet1.write(item, 5, "#{row['cust_type']}", format_string_shrink)
    worksheet1.write(item, 6, "#{row['acc_note']}", format_string_shrink)
    acc_total = acc_total + row['acc_cost'] if !row['acc_cost'].nil?

  }


  worksheet1.write(2, 2, "總金額："+acc_total.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse, format_string)

  worksheet2 = workbook.add_worksheet(yyyy_mm+'倉儲費用小計')

  worksheet1.margin_left = 0.5
  worksheet1.margin_right = 0.5
  worksheet1.margin_top = 0.5
  worksheet1.margin_bottom = 0.5

  worksheet2.repeat_rows(0, 3)

  worksheet2.set_footer('&CPage &P of &N');

  worksheet2.activate

  format_title = workbook.add_format(:num_format => '@', :size => 16, :bold => 1)
  format_subtitle = workbook.add_format(:num_format => '@', :size => 14, :bold => 0)
  format_string_center = workbook.add_format(:num_format => '@', :align => 'center')
  format_string_center_background = workbook.add_format(:num_format => '@', :align => 'center', :bg_color => 'silver')
  format_string = workbook.add_format(:num_format => '@')
  format_string_background = workbook.add_format(:num_format => '@', :bg_color => 'silver')

  format_string_shrink = workbook.add_format()
  format_string_shrink.set_num_format('@')
  format_string_shrink.set_shrink(1)


  format_number = workbook.add_format(:num_format => '#,##0')

  worksheet2.set_column('A:A', 5)    # 項次
  worksheet2.set_column('B:B', 8)    # 客戶編號
  worksheet2.set_column('C:C', 40)   # 客戶名稱
  worksheet2.set_column('D:D', 15)    # 帳單金額

  item_count = 0
  worksheet2.set_row(0, 25)
  worksheet2.write(item, 2, "海灣文件倉儲管理系統", format_title)

  item = 1
  worksheet2.set_row(1, 20)
  worksheet2.write(item, 2, yyyy_mm+"倉儲費用", format_subtitle)
  worksheet2.write(item, 3, "列印日期："+Date.today.strftime("%Y/%m/%d"), format_string)

  item = 2
  worksheet2.write(item, 3, "列印人員："+user_name)

  item = 3
  worksheet2.write(item, 0, "項次", format_string_center_background)
  worksheet2.write(item, 1, "客戶編號", format_string_background)
  worksheet2.write(item, 2, "客戶名稱", format_string_background)
  worksheet2.write(item, 3, "小計金額", format_string_background)

  worksheet2.freeze_panes(item+1, 0)    # Freeze the item row

  worksheet2.autofilter( 'A4:D4' )

  #
  acc_total = 0

  Account.joins(:customer).select("accounts.cust_id, cust_name, sum(acc_cost) as acc_cost").group("accounts.cust_id, cust_name").where(accounts: {acc_date: acc_yyyy_mm,cust_id: custid}).order("cust_id ASC").each { |row|

    item = item + 1
    item_count =  item_count + 1
    worksheet2.write(item, 0, item_count, format_string_center)
    worksheet2.write(item, 1, "#{row['cust_id']}", format_string)
    worksheet2.write(item, 2, "#{row['cust_name']}", format_string_shrink)
    worksheet2.write(item, 3, "#{row['acc_cost']}", format_number)
    acc_total = acc_total + row['acc_cost'] if !row['acc_cost'].nil?

  }


  worksheet2.write(2, 2, "總計金額："+acc_total.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse, format_string)

  worksheet1.activate

  workbook.close

 else
   custid = Customer.select(:cust_id).where(won_staff: user_name) #使用業務人員名稱找客戶
   #如果用自己帳戶
  if custid.size == 0 then

  if File.exist?("#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.xlsx")
    File.delete("#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.xlsx")
  end
   workbook = WriteXLSX.new("#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.xlsx")


   # Add a worksheet1
   worksheet1 = workbook.add_worksheet(yyyy_mm+'倉儲費用')
   # worksheet1.margins = 0.2
   worksheet1.margin_left = 0.5
   worksheet1.margin_right = 0.5
   worksheet1.margin_top = 0.5
   worksheet1.margin_bottom = 0.5


   worksheet1.repeat_rows(0, 3)


   worksheet1.set_footer('&CPage &P of &N');

   # The activate() method is used to specify which worksheet1 is initially visible in a multi-sheet workbook:
   worksheet1.activate



   format_title = workbook.add_format(:num_format => '@', :size => 16, :bold => 1)
   format_subtitle = workbook.add_format(:num_format => '@', :size => 14, :bold => 0)
   format_string_center = workbook.add_format(:num_format => '@', :align => 'center')
   format_string_center_background = workbook.add_format(:num_format => '@', :align => 'center', :bg_color => 'silver')
   format_string = workbook.add_format(:num_format => '@')
   format_string_background = workbook.add_format(:num_format => '@', :bg_color => 'silver')


   format_string_shrink = workbook.add_format()
   format_string_shrink.set_num_format('@')
   format_string_shrink.set_shrink(1)

   format_number = workbook.add_format(:num_format => '#,##0')

   worksheet1.set_column('A:A', 5)    # 項次
   worksheet1.set_column('B:B', 8)    # 客戶編號
   worksheet1.set_column('C:C', 18)   # 客戶名稱
   worksheet1.set_column('D:D', 8)    # 帳單編號
   worksheet1.set_column('E:E', 12)   # 帳單金額
   worksheet1.set_column('F:F', 13)   # 帳單名稱
   worksheet1.set_column('G:G', 15)   # 其他說明


   item = 0
   item_count = 0
   worksheet1.set_row(0, 25)
   worksheet1.write(item, 2, "海灣文件倉儲管理系統", format_title)

   item = 1
   worksheet1.set_row(1, 20)
   worksheet1.write(item, 2, yyyy_mm+"倉儲費用", format_subtitle)
   worksheet1.write(item, 5, "列印日期："+Date.today.strftime("%Y/%m/%d"), format_string)

   item = 2
   worksheet1.write(item, 5, "列印人員："+user_name)

   item = 3
   worksheet1.write(item, 0, "項次", format_string_center_background)
   worksheet1.write(item, 1, "客戶編號", format_string_background)
   worksheet1.write(item, 2, "客戶名稱", format_string_background)
   worksheet1.write(item, 3, "帳單編號", format_string_background)
   worksheet1.write(item, 4, "帳單金額", format_string_background)
   worksheet1.write(item, 5, "帳單名稱", format_string_background)
   worksheet1.write(item, 6, "其他說明", format_string_background)

   worksheet1.freeze_panes(item+1, 0)    # Freeze the item row

   worksheet1.autofilter( 'A4:G4' )


   acc_total = 0

   Account.joins(:customer).select("accounts.cust_id, cust_name, cust_type, acc_kind, acc_no, acc_cost, acc_note").where(accounts: {acc_date: acc_yyyy_mm}).order("cust_id ASC, cust_type ASC").each { |row|

     item = item + 1
     item_count =  item_count + 1
     worksheet1.write(item, 0, item_count, format_string_center)
     worksheet1.write(item, 1, "#{row['cust_id']}", format_string)
     worksheet1.write(item, 2, "#{row['cust_name']}", format_string_shrink)
     worksheet1.write(item, 3, "#{row['acc_kind']}-#{row['acc_no']}", format_string)
     worksheet1.write(item, 4, "#{row['acc_cost']}", format_number)
     worksheet1.write(item, 5, "#{row['cust_type']}", format_string_shrink)
     worksheet1.write(item, 6, "#{row['acc_note']}", format_string_shrink)
     acc_total = acc_total + row['acc_cost'] if !row['acc_cost'].nil?

   }


   worksheet1.write(2, 2, "總金額："+acc_total.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse, format_string)

   worksheet2 = workbook.add_worksheet(yyyy_mm+'倉儲費用小計')

   worksheet1.margin_left = 0.5
   worksheet1.margin_right = 0.5
   worksheet1.margin_top = 0.5
   worksheet1.margin_bottom = 0.5

   worksheet2.repeat_rows(0, 3)

   worksheet2.set_footer('&CPage &P of &N');

   worksheet2.activate

   format_title = workbook.add_format(:num_format => '@', :size => 16, :bold => 1)
   format_subtitle = workbook.add_format(:num_format => '@', :size => 14, :bold => 0)
   format_string_center = workbook.add_format(:num_format => '@', :align => 'center')
   format_string_center_background = workbook.add_format(:num_format => '@', :align => 'center', :bg_color => 'silver')
   format_string = workbook.add_format(:num_format => '@')
   format_string_background = workbook.add_format(:num_format => '@', :bg_color => 'silver')

   format_string_shrink = workbook.add_format()
   format_string_shrink.set_num_format('@')
   format_string_shrink.set_shrink(1)


   format_number = workbook.add_format(:num_format => '#,##0')

   worksheet2.set_column('A:A', 5)    # 項次
   worksheet2.set_column('B:B', 8)    # 客戶編號
   worksheet2.set_column('C:C', 40)   # 客戶名稱
   worksheet2.set_column('D:D', 15)    # 帳單金額

   item_count = 0
   worksheet2.set_row(0, 25)
   worksheet2.write(item, 2, "海灣文件倉儲管理系統", format_title)

   item = 1
   worksheet2.set_row(1, 20)
   worksheet2.write(item, 2, yyyy_mm+"倉儲費用", format_subtitle)
   worksheet2.write(item, 3, "列印日期："+Date.today.strftime("%Y/%m/%d"), format_string)

   item = 2
   worksheet2.write(item, 3, "列印人員："+user_name)

   item = 3
   worksheet2.write(item, 0, "項次", format_string_center_background)
   worksheet2.write(item, 1, "客戶編號", format_string_background)
   worksheet2.write(item, 2, "客戶名稱", format_string_background)
   worksheet2.write(item, 3, "小計金額", format_string_background)

   worksheet2.freeze_panes(item+1, 0)    # Freeze the item row

   worksheet2.autofilter( 'A4:D4' )

   #
   acc_total = 0

   Account.joins(:customer).select("accounts.cust_id, cust_name, sum(acc_cost) as acc_cost").group("accounts.cust_id, cust_name").where(accounts: {acc_date: acc_yyyy_mm}).order("cust_id ASC").each { |row|

     item = item + 1
     item_count =  item_count + 1
     worksheet2.write(item, 0, item_count, format_string_center)
     worksheet2.write(item, 1, "#{row['cust_id']}", format_string)
     worksheet2.write(item, 2, "#{row['cust_name']}", format_string_shrink)
     worksheet2.write(item, 3, "#{row['acc_cost']}", format_number)
     acc_total = acc_total + row['acc_cost'] if !row['acc_cost'].nil?

   }


   worksheet2.write(2, 2, "總計金額："+acc_total.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse, format_string)

   worksheet1.activate

   workbook.close
 else

   if File.exist?("#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.xlsx")
     File.delete("#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.xlsx")
   end
    workbook = WriteXLSX.new("#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.xlsx")


    # Add a worksheet1
    worksheet1 = workbook.add_worksheet(yyyy_mm+'倉儲費用')
    # worksheet1.margins = 0.2
    worksheet1.margin_left = 0.5
    worksheet1.margin_right = 0.5
    worksheet1.margin_top = 0.5
    worksheet1.margin_bottom = 0.5


    worksheet1.repeat_rows(0, 3)


    worksheet1.set_footer('&CPage &P of &N');

    # The activate() method is used to specify which worksheet1 is initially visible in a multi-sheet workbook:
    worksheet1.activate



    format_title = workbook.add_format(:num_format => '@', :size => 16, :bold => 1)
    format_subtitle = workbook.add_format(:num_format => '@', :size => 14, :bold => 0)
    format_string_center = workbook.add_format(:num_format => '@', :align => 'center')
    format_string_center_background = workbook.add_format(:num_format => '@', :align => 'center', :bg_color => 'silver')
    format_string = workbook.add_format(:num_format => '@')
    format_string_background = workbook.add_format(:num_format => '@', :bg_color => 'silver')


    format_string_shrink = workbook.add_format()
    format_string_shrink.set_num_format('@')
    format_string_shrink.set_shrink(1)

    format_number = workbook.add_format(:num_format => '#,##0')

    worksheet1.set_column('A:A', 5)    # 項次
    worksheet1.set_column('B:B', 8)    # 客戶編號
    worksheet1.set_column('C:C', 18)   # 客戶名稱
    worksheet1.set_column('D:D', 8)    # 帳單編號
    worksheet1.set_column('E:E', 12)   # 帳單金額
    worksheet1.set_column('F:F', 13)   # 帳單名稱
    worksheet1.set_column('G:G', 15)   # 其他說明


    item = 0
    item_count = 0
    worksheet1.set_row(0, 25)
    worksheet1.write(item, 2, "海灣文件倉儲管理系統", format_title)

    item = 1
    worksheet1.set_row(1, 20)
    worksheet1.write(item, 2, yyyy_mm+"倉儲費用", format_subtitle)
    worksheet1.write(item, 5, "列印日期："+Date.today.strftime("%Y/%m/%d"), format_string)

    item = 2
    worksheet1.write(item, 5, "列印人員："+user_name)

    item = 3
    worksheet1.write(item, 0, "項次", format_string_center_background)
    worksheet1.write(item, 1, "客戶編號", format_string_background)
    worksheet1.write(item, 2, "客戶名稱", format_string_background)
    worksheet1.write(item, 3, "帳單編號", format_string_background)
    worksheet1.write(item, 4, "帳單金額", format_string_background)
    worksheet1.write(item, 5, "帳單名稱", format_string_background)
    worksheet1.write(item, 6, "其他說明", format_string_background)

    worksheet1.freeze_panes(item+1, 0)    # Freeze the item row

    worksheet1.autofilter( 'A4:G4' )


    acc_total = 0

    Account.joins(:customer).select("accounts.cust_id, cust_name, cust_type, acc_kind, acc_no, acc_cost, acc_note").where(accounts: {acc_date: acc_yyyy_mm,cust_id: custid}).order("cust_id ASC, cust_type ASC").each { |row|

      item = item + 1
      item_count =  item_count + 1
      worksheet1.write(item, 0, item_count, format_string_center)
      worksheet1.write(item, 1, "#{row['cust_id']}", format_string)
      worksheet1.write(item, 2, "#{row['cust_name']}", format_string_shrink)
      worksheet1.write(item, 3, "#{row['acc_kind']}-#{row['acc_no']}", format_string)
      worksheet1.write(item, 4, "#{row['acc_cost']}", format_number)
      worksheet1.write(item, 5, "#{row['cust_type']}", format_string_shrink)
      worksheet1.write(item, 6, "#{row['acc_note']}", format_string_shrink)
      acc_total = acc_total + row['acc_cost'] if !row['acc_cost'].nil?

    }


    worksheet1.write(2, 2, "總金額："+acc_total.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse, format_string)

    worksheet2 = workbook.add_worksheet(yyyy_mm+'倉儲費用小計')

    worksheet1.margin_left = 0.5
    worksheet1.margin_right = 0.5
    worksheet1.margin_top = 0.5
    worksheet1.margin_bottom = 0.5

    worksheet2.repeat_rows(0, 3)

    worksheet2.set_footer('&CPage &P of &N');

    worksheet2.activate

    format_title = workbook.add_format(:num_format => '@', :size => 16, :bold => 1)
    format_subtitle = workbook.add_format(:num_format => '@', :size => 14, :bold => 0)
    format_string_center = workbook.add_format(:num_format => '@', :align => 'center')
    format_string_center_background = workbook.add_format(:num_format => '@', :align => 'center', :bg_color => 'silver')
    format_string = workbook.add_format(:num_format => '@')
    format_string_background = workbook.add_format(:num_format => '@', :bg_color => 'silver')

    format_string_shrink = workbook.add_format()
    format_string_shrink.set_num_format('@')
    format_string_shrink.set_shrink(1)


    format_number = workbook.add_format(:num_format => '#,##0')

    worksheet2.set_column('A:A', 5)    # 項次
    worksheet2.set_column('B:B', 8)    # 客戶編號
    worksheet2.set_column('C:C', 40)   # 客戶名稱
    worksheet2.set_column('D:D', 15)    # 帳單金額

    item_count = 0
    worksheet2.set_row(0, 25)
    worksheet2.write(item, 2, "海灣文件倉儲管理系統", format_title)

    item = 1
    worksheet2.set_row(1, 20)
    worksheet2.write(item, 2, yyyy_mm+"倉儲費用", format_subtitle)
    worksheet2.write(item, 3, "列印日期："+Date.today.strftime("%Y/%m/%d"), format_string)

    item = 2
    worksheet2.write(item, 3, "列印人員："+user_name)

    item = 3
    worksheet2.write(item, 0, "項次", format_string_center_background)
    worksheet2.write(item, 1, "客戶編號", format_string_background)
    worksheet2.write(item, 2, "客戶名稱", format_string_background)
    worksheet2.write(item, 3, "小計金額", format_string_background)

    worksheet2.freeze_panes(item+1, 0)    # Freeze the item row

    worksheet2.autofilter( 'A4:D4' )

    #
    acc_total = 0

    Account.joins(:customer).select("accounts.cust_id, cust_name, sum(acc_cost) as acc_cost").group("accounts.cust_id, cust_name").where(accounts: {acc_date: acc_yyyy_mm,cust_id: custid}).order("cust_id ASC").each { |row|

      item = item + 1
      item_count =  item_count + 1
      worksheet2.write(item, 0, item_count, format_string_center)
      worksheet2.write(item, 1, "#{row['cust_id']}", format_string)
      worksheet2.write(item, 2, "#{row['cust_name']}", format_string_shrink)
      worksheet2.write(item, 3, "#{row['acc_cost']}", format_number)
      acc_total = acc_total + row['acc_cost'] if !row['acc_cost'].nil?

    }


    worksheet2.write(2, 2, "總計金額："+acc_total.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse, format_string)

    worksheet1.activate

    workbook.close
  end
end
  return "#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.xlsx"
  end

   #PDF小計
  def printp1_pdf(yyyy_mm,acc_yyyy_mm,user_name)
  if @group=="3" then
    custid = Customer.select(:cust_id).where(won_staff: user_name)
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
       if custid.size == 0 then
       Account.joins(:customer).select("sum(acc_cost) as acc_cost").where(accounts: {acc_date: acc_yyyy_mm}).each { |row|
         acc_total = acc_total + row['acc_cost'] if !row['acc_cost'].nil?
       }
       else
         Account.joins(:customer).select("sum(acc_cost) as acc_cost").where(accounts: {acc_date: acc_yyyy_mm,cust_id: custid}).each { |row|
           acc_total = acc_total + row['acc_cost'] if !row['acc_cost'].nil?
         }
       end
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
    if custid.size == 0 then
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

     else

       iRowCount = Account.joins(:customer).group("accounts.cust_id").where(accounts: {acc_date: acc_yyyy_mm,cust_id: custid}).count

        font("#{Prawn::DATADIR}/fonts/wt024.ttf") do
          data = [["項次","客戶編號","客戶名稱","小計金額"]]

          Account.joins(:customer).select("accounts.cust_id, cust_name, sum(acc_cost) as acc_cost").group("accounts.cust_id, cust_name").where(accounts: {acc_date: acc_yyyy_mm,cust_id: custid}).order("cust_id ASC").each { |row|

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
 end
  return "#{Rails.root}/public/#{yyyy_mm+"倉儲費用小計"}.pdf"
end

if @group=="1" then
   custid = Customer.select(:cust_id).where(won_staff: @wonstaff)
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
     Account.joins(:customer).select("sum(acc_cost) as acc_cost").where(accounts: {acc_date: acc_yyyy_mm,cust_id:custid}).each { |row|
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
     iRowCount = Account.joins(:customer).group("accounts.cust_id").where(accounts: {acc_date: acc_yyyy_mm,cust_id:custid}).count

     font("#{Prawn::DATADIR}/fonts/wt024.ttf") do
       data = [["項次","客戶編號","客戶名稱","小計金額"]]

       Account.joins(:customer).select("accounts.cust_id, cust_name, sum(acc_cost) as acc_cost").group("accounts.cust_id, cust_name").where(accounts: {acc_date: acc_yyyy_mm,cust_id:custid}).order("cust_id ASC").each { |row|

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
return "#{Rails.root}/public/#{yyyy_mm+"倉儲費用小計"}.pdf"
end



  end

   #PDF
  def printp_pdf(yyyy_mm,acc_yyyy_mm,user_name)

     if @group=="3" then
       custid = Customer.select(:cust_id).where(won_staff: user_name)
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
        if custid.size==0 then
          Account.joins(:customer).select("sum(acc_cost) as acc_cost").where(accounts: {acc_date: acc_yyyy_mm}).each { |row|
            acc_total = acc_total + row['acc_cost'] if !row['acc_cost'].nil?
          }
        else
          Account.joins(:customer).select("sum(acc_cost) as acc_cost").where(accounts: {acc_date: acc_yyyy_mm,cust_id: custid}).each { |row|
            acc_total = acc_total + row['acc_cost'] if !row['acc_cost'].nil?
          }
        end
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
          if custid.size == 0 then
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
      else
        iRowCount = Account.joins(:customer).where(accounts: {acc_date: acc_yyyy_mm,cust_id: custid}).count

        font("#{Prawn::DATADIR}/fonts/wt024.ttf") do
          data = [["項次","客戶編號","客戶名稱","帳單編號","帳單金額","帳單種類","備註"]]

          Account.joins(:customer).select("accounts.cust_id, cust_name, cust_type, acc_kind, acc_no, acc_cost, acc_note").where(accounts: {acc_date: acc_yyyy_mm,cust_id: custid}).order("cust_id ASC, cust_type ASC").each { |row|

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

     end

       return "#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.pdf"
     end
     if @group=="1" then
       custid = Customer.select(:cust_id).where(won_staff: @wonstaff)
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
          Account.joins(:customer).select("sum(acc_cost) as acc_cost").where(accounts: {acc_date: acc_yyyy_mm,cust_id: custid}).each { |row|
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
          iRowCount = Account.joins(:customer).where(accounts: {acc_date: acc_yyyy_mm,cust_id: custid}).count

          font("#{Prawn::DATADIR}/fonts/wt024.ttf") do
            data = [["項次","客戶編號","客戶名稱","帳單編號","帳單金額","帳單種類","備註"]]

            Account.joins(:customer).select("accounts.cust_id, cust_name, cust_type, acc_kind, acc_no, acc_cost, acc_note").where(accounts: {acc_date: acc_yyyy_mm,cust_id: custid}).order("cust_id ASC, cust_type ASC").each { |row|

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

       return "#{Rails.root}/public/#{yyyy_mm+"倉儲費用"}.pdf"
     end

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

end
