class CustomerTmp < ApplicationRecord
  def self.sp_UpdateCustTmps
    self.connection.execute("exec sp_UpdateCustTmps")
  end
end
