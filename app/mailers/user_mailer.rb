class UserMailer < ApplicationMailer
  p "UserMailer"
  #業務人員的mail address
  @mails = Account.find_by_sql("EXEC sp_executesql N'SELECT * from user_groups where[group]<> @0', N'@0 nvarchar(4000)', @0 = N'3'")
  default from: 'storage_report@crownvan.com'
  staff_email= @mails[0].email+','+@mails[1].email+','+@mails[2].email+','+@mails[3].email+','+@mails[4].email+','+@mails[5].email+','+@mails[6].email
  it_email= "IT_Department@crownvan.com"

  #mail_send_date=Time.now.to_s[0,4]+Time.now.to_s[5,2]
  def welcome_email()
     printtime=Time.now.strftime("%F-%H:%M")
     @printtime=printtime.to_s
    #寄信系統月份
    date=Time.now.to_s[0,4]+Time.now.to_s[5,2]
      if date[4,5]=="01"
          date= "20"+((date[2,2].to_i) - 1).to_s + "12"
          @mail_send_date=date.to_s
      else
        date= date[0,4].to_s + (date[4,2].to_i - 1).to_s
          if date.size() == 5
                date=date[0,4]+"0"+date[4,1]
          end
        @mail_send_date=date.to_s
      end
        p @mail_send_date
#撈出未出帳明細
    @account_mail= Account.find_by_sql("EXEC sp_executesql N'SELECT [accounts].*,[customers].[paymonth01],[customers].[paymonth02],
                         [customers].[paymonth03],[customers].[paymonth04],[customers].[paymonth05]
                        ,[customers].[paymonth06],[customers].[paymonth07],[customers].[paymonth08],[customers].[paymonth09]
                        ,[customers].[paymonth10],[customers].[paymonth11],[customers].[paymonth12]
                        ,[customers].[won_staff]
                        FROM [accounts] INNER JOIN [customers] ON [customers].[cust_id] =
                       [accounts].[cust_id] WHERE [accounts].[acc_date] = @0 AND [customers].[cust_id] IN
                        (SELECT [customers].[cust_id] FROM [customers] WHERE 1 = @1)',
                        N'@0 nvarchar(4000), @1 nvarchar(4000)', @0 = N'"+@mail_send_date+"', @1 =1")
#change paymark if 1 then Y else N
      @account_mail.each do |p|
      if  p.acc_date[4,5]=='01'
         if p.paymonth01 =="1"
              p.paymark="Y"
         elsif p.paymonth01 =="0"
              p.paymark="N"
         end

      end
      if  p.acc_date[4,5]=='02'
         if p.paymonth02 =="1"
              p.paymark="Y"
         elsif p.paymonth02 =="0"
               p.paymark="N"
         end
      end
      if  p.acc_date[4,5]=='03'
         if p.paymonth03 =="1"
              p.paymark="Y"
        elsif p.paymonth03 =="0"
             p.paymark="N"
         end
      end
      if  p.acc_date[4,5]=='04'
         if p.paymonth04 =="1"
              p.paymark="Y"
         elsif p.paymonth04 =="0"
               p.paymark="N"
         end
      end
      if  p.acc_date[4,5]=='05'
         if p.paymonth05 =="1"
              p.paymark="Y"
         elsif p.paymonth05 =="0"
               p.paymark="N"
         end
      end
      if  p.acc_date[4,5]=='06'
         if p.paymonth06 =="1"
              p.paymark="Y"
         elsif p.paymonth06 =="0"
               p.paymark="N"
         end
      end
      if  p.acc_date[4,5]=='07'
         if p.paymonth07 =="1"
              p.paymark="Y"
          elsif p.paymonth07 =="0"
                p.paymark="N"
         end
      end
       if  p.acc_date[4,5]=='08'
          if p.paymonth08 =="1"
               p.paymark="Y"
          elsif p.paymonth08 =="0"
                p.paymark="N"
          end
       end
       if  p.acc_date[4,5]=='09'
          if p.paymonth09 =="1"
               p.paymark="Y"
          elsif p.paymonth09 =="0"
                p.paymark="N"
          end
       end
       if  p.acc_date[4,5]=='10'
          if p.paymonth10 =="1"
               p.paymark="Y"
          elsif p.paymonth10 =="0"
                p.paymark="N"
          end
       end
       if  p.acc_date[4,5]=='11'
          if p.paymonth11 =="1"
               p.paymark="Y"
          elsif p.paymonth11 =="0"
                p.paymark="N"
          end
       end
       if  p.acc_date[4,5]=='12'
          if p.paymonth12 =="1"
               p.paymark="Y"
          elsif p.paymonth12 =="0"
                  p.paymark="N"
          end
       end
       if p.clo_mark.blank?
          p.clo_mark="Y"
       end
       if p.paymark.blank?
          p.paymark="N"
       end
        p.mail_show_mark=p.paymark+p.clo_mark
    end
    @account_mail.delete_if do |x|
      x.mail_show_mark !='YN'
    end
    @mail = "Benson@crownvan.com"
    mail(to: @mail, subject: 'TEST TEST倉儲月報表之未出帳明細表 請勿回覆')
  end

end
