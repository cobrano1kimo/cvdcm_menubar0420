class SycCrw01CmToGrossCust < ActiveJob::Base
  queue_as :low_priority
  def perform
        scheduler = Rufus::Scheduler.new
        scheduler.cron '*/15 * * * *' do |x|
         VancustomerFromCm.delete_all
         @Vans = VanCustomer.find_by_sql("select * from cm")
            @Vans.each do |v|
                        VancustomerFromCm.create(CM00: v.CM00,CM01: v.CM01,CM02: v.CM02,
                        CM03: v.CM03,CM04: v.CM04,CM05: v.CM05,CM06: v.CM06,CM07: v.CM07,
                      CM08: v.CM08,CM09: v.CM09,CM10: v.CM10,CM11: v.CM11,CM12: v.CM12,
                    CM13: v.CM13,CM14: v.CM14,CM15: v.CM15,CM16: v.CM16,CM17: v.CM17,
                  CM18: v.CM18,CM19: v.CM19,CM20: v.CM20,CM21: v.CM21,CM22: v.CM22,
                CM23: v.CM23,CM24: v.CM24,CM25: v.CM25,CM26: v.CM26,CM27: v.CM27,
              CM28: v.CM28,CM29: v.CM29,CM30: v.CM30,CM31: v.CM31,CM32: v.CM32,
            CM33: v.CM33,CM34: v.CM34,CRE_DTIME: v.CRE_DTIME,UPD_USERID: v.UPD_USERID,
          CRE_USERID: v.CRE_USERID,UPD_DTIME: v.UPD_DTIME,CM35: v.CM35,CM36: v.CM36,CM37: v.CM37)
          end
          #將CM之customer_tmp同步資料更換成CUSTOMER資料邏輯
        CustomerTmp.sp_UpdateCustTmps
        customer_tmp= CustomerTmp.all
        customer_tmp.each do |c|
              if Customer.exists?(cust_id: c.cust_id)
                p c.cust_id+"-"+ "exists"
                Customer.where(cust_id: c.cust_id).update(cust_name: c.cust_name,cust_stat: c.cust_stat,
                won_staff: c.won_staff,cust_payment: c.cust_payment,cust_note: c.cust_note)
              else
                #如果是葉子新客戶依付款條件塞出帳註記
              if c.cust_payment.nil? || c.cust_payment.empty?
                  c.paymonth01="1"
                  c.paymonth02="1"
                  c.paymonth03="1"
                  c.paymonth04="1"
                  c.paymonth05="1"
                  c.paymonth06="1"
                  c.paymonth07="1"
                  c.paymonth08="1"
                  c.paymonth09="1"
                  c.paymonth10="1"
                  c.paymonth11="1"
                  c.paymonth12="1"
              else
                case c.cust_payment.strip
                when "1"
                   c.paymonth01="1"
                   c.paymonth02="1"
                   c.paymonth03="1"
                   c.paymonth04="1"
                   c.paymonth05="1"
                   c.paymonth06="1"
                   c.paymonth07="1"
                   c.paymonth08="1"
                   c.paymonth09="1"
                   c.paymonth10="1"
                   c.paymonth11="1"
                   c.paymonth12="1"
                 when "2"
                   c.paymonth01="0"
                   c.paymonth02="1"
                   c.paymonth03="0"
                   c.paymonth04="1"
                   c.paymonth05="0"
                   c.paymonth06="1"
                   c.paymonth07="0"
                   c.paymonth08="1"
                   c.paymonth09="0"
                   c.paymonth10="1"
                   c.paymonth11="0"
                   c.paymonth12="1"
                 when "3"
                   c.paymonth01="0"
                   c.paymonth02="0"
                   c.paymonth03="1"
                   c.paymonth04="0"
                   c.paymonth05="0"
                   c.paymonth06="1"
                   c.paymonth07="0"
                   c.paymonth08="0"
                   c.paymonth09="1"
                   c.paymonth10="0"
                   c.paymonth11="0"
                   c.paymonth12="1"
                 when "4"
                   c.paymonth01="0"
                   c.paymonth02="0"
                   c.paymonth03="0"
                   c.paymonth04="0"
                   c.paymonth05="0"
                   c.paymonth06="1"
                   c.paymonth07="0"
                   c.paymonth08="0"
                   c.paymonth09="0"
                   c.paymonth10="0"
                   c.paymonth11="0"
                   c.paymonth12="1"
                 when "5"
                   c.paymonth01="0"
                   c.paymonth02="0"
                   c.paymonth03="0"
                   c.paymonth04="0"
                   c.paymonth05="0"
                   c.paymonth06="0"
                   c.paymonth07="0"
                   c.paymonth08="0"
                   c.paymonth09="0"
                   c.paymonth10="0"
                   c.paymonth11="0"
                   c.paymonth12="1"
                 when "8"
                   c.paymonth01="0"
                   c.paymonth02="0"
                   c.paymonth03="0"
                   c.paymonth04="1"
                   c.paymonth05="0"
                   c.paymonth06="0"
                   c.paymonth07="0"
                   c.paymonth08="1"
                   c.paymonth09="0"
                   c.paymonth10="0"
                   c.paymonth11="0"
                   c.paymonth12="1"
                 when "6","7"
                   c.paymonth01="0"
                   c.paymonth02="0"
                   c.paymonth03="0"
                   c.paymonth04="0"
                   c.paymonth05="0"
                   c.paymonth06="0"
                   c.paymonth07="0"
                   c.paymonth08="0"
                   c.paymonth09="0"
                   c.paymonth10="0"
                   c.paymonth11="0"
                   c.paymonth12="0"
                 else
                   c.paymonth01="1"
                   c.paymonth02="1"
                   c.paymonth03="1"
                   c.paymonth04="1"
                   c.paymonth05="1"
                   c.paymonth06="1"
                   c.paymonth07="1"
                   c.paymonth08="1"
                   c.paymonth09="1"
                   c.paymonth10="1"
                   c.paymonth11="1"
                   c.paymonth12="1"
                end
              end
                Customer.create(cust_id: c.cust_id,cust_name: c.cust_name,cust_stat: c.cust_stat,
                won_staff: c.won_staff,cust_payment: c.cust_payment,cust_note: c.cust_note,
                paymonth01: c.paymonth01,paymonth02: c.paymonth02, paymonth03: c.paymonth03,
                paymonth04: c.paymonth04,paymonth05: c.paymonth05,paymonth06: c.paymonth06,
                paymonth07: c.paymonth07,paymonth08: c.paymonth08,paymonth09: c.paymonth09,
                paymonth10: c.paymonth10,paymonth11: c.paymonth11,paymonth12: c.paymonth12)
                p c.cust_id+"-"+ "is not exists"
           end
        end
        end
  end
end
