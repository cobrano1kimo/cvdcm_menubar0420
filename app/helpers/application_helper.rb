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
      stats ="合約中"
    elsif stats =="Y"
      stats ="己解約"
    elsif stats =="P"
      stats ="己結算"
    end
  end






 end
