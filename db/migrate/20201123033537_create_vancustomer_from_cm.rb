class CreateVancustomerFromCm < ActiveRecord::Migration[5.1]
  def change
    create_table :vancustomer_from_cms,id: false do |t|
t.string :CM00, primary_key: true, limit: 5, default: ''	#客戶編號
t.string:CM01  #客戶簡稱
t.string:CM02		#客戶名稱
t.string:CM03		#發票名稱
t.string:CM04		#業務人員
t.string:CM05		#客戶類別
t.string:CM06		#統一編號
t.string:CM07		#負責人
t.string:CM08		#合約起日
t.string:CM09		#合約止日
t.string:CM10		#發票種類
t.string:CM11		#發票聯式
t.string:CM12		#報價含稅
t.string:CM13		#聯絡人
t.string:CM14		#聯絡電話
t.string:CM15		#行動電話
t.string:CM16		#傳真號碼
t.string:CM17		#EMAIL
t.string:CM18		#網路密碼(Reserved)
t.string:CM19		#公司地址
t.string:CM20		#帳單地址
t.string:CM21		#公司郵遞區號
t.string:CM22		#帳單郵遞區號
t.string:CM23		#收款客戶編號
t.string:CM24		#付款條件
t.integer :CM25	#固定折讓
t.string:CM26		#箱號編碼(Reserved)
t.integer :CM27 #借出天數限制
t.string:CM28		#備註
t.string:CM29	#預設倉庫(Reserved)
t.string:CM30	#分機
t.string:CM31		#是否解約
t.string:CM32		#箱號唯一(Reserved)
t.string:CM33		#件號唯一(Reserved)
t.string:CM34		#自動回信主管
t.string:CRE_USERID		#建檔人員
t.string:CRE_DTIME		#建檔日期
t.string:UPD_USERID		#修改人員
t.string:UPD_DTIME		#修改日期
t.string:CM35		#計算方式
t.string:CM36	#是否停用
t.string:CM37	#停用日期

    end
  end
end
