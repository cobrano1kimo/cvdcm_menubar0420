module HistoriesHelper
  def statMark(stats)
    if stats == "D"
      stats ="刪除"
    elsif stats =="E"
      stats ="修改"
    elsif stats =="C"
      stats ="新增"
    end
  end

end
