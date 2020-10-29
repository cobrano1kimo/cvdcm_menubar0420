module CustomersHelper
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
