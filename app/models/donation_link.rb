class DonationLink

  def self.url(state_code='National')
    gift_id = gift_ids[state_code]
    "https://www.egsnetwork.com/gift2?giftid=#{gift_id}"
  end

  def self.gift_ids
    {
     "al"=>"BD5EE61FBBF9449",
     "ak"=>"B3F7D4948ABC4DA",
     "ar"=>"AF644B0A8FF6456",
     "az"=>"355D44FEF56C4BD",
     "ct"=>"32AAD78A1DB94B2",
     "fl"=>"DA2EDDF62390485",
     "hi"=>"C8B335E4A8724BA",
     "id"=>"E5996E505D3D42B",
     "ia"=>"392BBA658CCE4E6",
     "ky"=>"C750172DBF0649F",
     "la"=>"F5D159C49ED0469",
     "me"=>"77AEC78AE3E4435",
     "ma"=>"2E98042554C3436",
     "mi"=>"D337B2B0AB504E3",
     "ms"=>"3940585D6303480",
     "mt"=>"74188B1E33874B1",
     "ne"=>"BDF1329852654E4",
     "nv"=>"078F99022002486",
     "nh"=>"C5118CE407A0402",
     "nj"=>"F1265FE449F549C",
     "nm"=>"AF7736AE4F4046B",
     "ny"=>"DC91FD025E65483",
     "ok"=>"76D458EF9024439",
     "or"=>"2437AAC91271462",
     "ri"=>"8A55ED2AEDA0451",
     "sd"=>"AF802C6759E3475",
     "tn"=>"D078DD541D6B461",
     "ut"=>"7B8972EAA7E6498",
     "vt"=>"FDD595A02C874DF",
     "wa"=>"7320F0CE78174D3",
     "wi"=>"6C42357F14814F0",
     "ca"=>"97A02EA202D0408",
     "co"=>"FF4D891E52F4401",
     "il"=>"4EA2C0CF3FB24ED",
     "in"=>"152B8D67443D468",
     "ks"=>"385A6F951473421",
     "md"=>"D1C71F3AA2E6488",
     "mn"=>"E99A92D2-AE0B-4F4B-AE25-D0BA82931A4E",
     "mo"=>"E5D166A5E38640E",
     "nc"=>"AD8D37D928A74DB",
     "nd"=>"3C4A9E2F-8816-4225-85C1-0617981451C5",
     "pa"=>"FDE13C458D1147D",
     "sc"=>"E9F1237AED96497",
     "tx"=>"8476BC5FEDD34C6",
     "va"=>"84F1AF6FF6F9484",
     "wv"=>"26E329769283437",
     "wy"=>"22655FFA9A9345F",
     "National"=>"40CA3B1B00824E7",
     "ga"=>"F7FB1AFEA4734CD",
     "oh"=>"3EB2CA03CAF1416",
     "de"=>"C02E20C4-1195-4011-8295-3A3A4C77493E"
    }
  end

end
