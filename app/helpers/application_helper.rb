module ApplicationHelper
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


  def subdate(id)
      if id.nil?
        id=id
      else
       id=id[5,6]
      end
  end
  def subcustid(id)
  if id.nil?
    id=id
  else
      id=id[0,5]
    end
  end
end
