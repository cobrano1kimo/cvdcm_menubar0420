module CustomersHelper
  #show cust_payment
  def paymentShow(payment)
    if payment.nil? || payment.empty?
      stats ="請改葉子"
    elsif payment.strip =="1"
      stats ="月結"
    elsif payment.strip =="2"
      stats ="雙月結"
    elsif payment.strip =="3"
      stats ="季結"
    elsif payment.strip =="4"
      stats ="半年結"
    elsif payment.strip =="5"
      stats ="年結"
    elsif payment.strip =="6"
      stats ="己結清"
    elsif payment.strip =="7"
      stats ="倒店"
    elsif payment.strip =="8"
      stats ="4個月結"
    end
  end

end
