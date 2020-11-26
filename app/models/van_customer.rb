 class VanCustomer < ActiveRecord::Base
   self.table_name="cm"
   establish_connection CRW01
 end
