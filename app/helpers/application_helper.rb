module ApplicationHelper
  #next month

#將年月YYYYMM改成MMYY
  def rocTime(date)
    if date.nil?
      date=date
    else
     date=  date[4,5]+'/'+date[2,2]
    end
  end
  def timeRoc(date)
    if date.nil?
      date=date
    else
     date= "20"+date[3,2]+date[0,2]
    end
  end
  #show cust_stat
  def statShow(stats)
    if stats.nil? || stats.empty?
      stats ="無"
    elsif stats =="Y"
      stats ="合約中"
    elsif stats =="N"
      stats ="己解約"
    end
  end  
    #show cust_payment
    def paymentShow(payment)
      if payment.nil? || payment.empty?
        stats ="無"
      elsif payment =="1"
        stats ="月結"
      elsif payment =="2"
        stats ="雙月結"
      elsif payment =="3"
        stats ="季結"
      elsif payment =="4"
        stats ="半年結"
      elsif payment =="5"
        stats ="年結"
      elsif payment =="6"
        stats ="己結清"
      elsif payment =="7"
        stats ="倒店"
      elsif payment =="8"
        stats ="4個月結"
      end
    end






 end
