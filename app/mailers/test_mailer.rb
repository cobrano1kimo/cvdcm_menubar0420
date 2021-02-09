class TestMailer < ApplicationMailer
  def test_email()
    p "testmail"
       mail(to: 'Benson@crownvan.com', subject: 'TEST TESTTEST倉儲月報表之未出帳明細表 請勿回覆')
  end
end
