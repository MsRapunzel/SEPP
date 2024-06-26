//
//  MarketDataModel.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 24.04.2024.
//

import Foundation

// JSON data:
/*
 
 URL: https://api.coingecko.com/api/v3/global
 
 JSON Response:
 {
    "data":{
       "active_cryptocurrencies":14069,
       "upcoming_icos":0,
       "ongoing_icos":49,
       "ended_icos":3376,
       "markets":1063,
       "total_market_cap":{
          "btc":38919345.174760036,
          "eth":790109782.4869267,
          "ltc":29645280418.358883,
          "bch":5170401783.44334,
          "bnb":4237806130.4803133,
          "eos":2978365473293.98,
          "xrp":4759709676195.441,
          "xlm":21621948721413.062,
          "link":168616433636.78775,
          "dot":352805292883.99146,
          "yfi":352978605.84823656,
          "usd":2568059196099.1694,
          "aed":9432224621352.658,
          "ars":2.242539459773308e+15,
          "aud":3947718182493.0776,
          "bdt":281884789620670.6,
          "bhd":968109523804.6631,
          "bmd":2568059196099.1694,
          "brl":13246049333479.504,
          "cad":3519445518418.8335,
          "chf":2342396130360.349,
          "clp":2.456733829948272e+15,
          "cny":18607900129014.965,
          "czk":60600290491789.266,
          "dkk":17901427044168.1,
          "eur":2400390611185.856,
          "gbp":2062128421934.8708,
          "gel":6869558349565.267,
          "hkd":20114708862326.164,
          "huf":944593841698810.5,
          "idr":4.1571592579418856e+16,
          "ils":9722325428439.979,
          "inr":214008797081334.5,
          "jpy":397792369475760.1,
          "krw":3.528883703505582e+15,
          "kwd":790887758681.8579,
          "lkr":766690102775889.4,
          "mmk":5.394057863409635e+15,
          "mxn":43803755508387.92,
          "myr":12268902809363.791,
          "ngn":3314054711974019.5,
          "nok":28171568292260.773,
          "nzd":4325515643068.0186,
          "php":148108322599485.84,
          "pkr":715080271658361.4,
          "pln":10378040823275.982,
          "rub":237563292833875.88,
          "sar":9630971858657.137,
          "sek":27900070505989.957,
          "sgd":3494440326026.416,
          "thb":95145625057157.45,
          "try":83504042612098.14,
          "twd":83676356816097.3,
          "uah":101549406806148.47,
          "vef":257139767305.40985,
          "vnd":6.527859328489812e+16,
          "zar":49329178834418.78,
          "xdr":1953977176950.3477,
          "xag":94174711212.7106,
          "xau":1105600845.1046166,
          "bits":38919345174760.04,
          "sats":3891934517476003.5
       },
       "total_volume":{
          "btc":1296202.9715942398,
          "eth":26314488.163829885,
          "ltc":987331631.5954238,
          "bch":172199458.28846377,
          "bnb":141139499.51375917,
          "eos":99194016745.19937,
          "xrp":158521419065.6903,
          "xlm":720115769124.7483,
          "link":5615745109.744766,
          "dot":11750127525.96307,
          "yfi":11755899.688322471,
          "usd":85528827534.65242,
          "aed":314138830652.0255,
          "ars":74687441389959.75,
          "aud":131478163781.71344,
          "bdt":9388130769232.123,
          "bhd":32242742932.840874,
          "bmd":85528827534.65242,
          "brl":441157692423.7368,
          "cad":117214606742.58759,
          "chf":78013152872.69998,
          "clp":81821152861025.28,
          "cny":619733331433.3378,
          "czk":2018283613514.4639,
          "dkk":596204350978.5554,
          "eur":79944650384.91501,
          "gbp":68678878750.878174,
          "gel":228789613655.19485,
          "hkd":669917370989.2954,
          "huf":31459556656509.605,
          "idr":1384535674826651.5,
          "ils":323800594654.4768,
          "inr":7127530986930.198,
          "jpy":13248415385117.62,
          "krw":117528944085648.38,
          "kwd":26340398544.67446,
          "lkr":25534499232903.094,
          "mmk":179648290589358.66,
          "mxn":1458877527409.7363,
          "myr":408613973546.8023,
          "ngn":110374096645193.69,
          "nok":938249869593.8972,
          "nzd":144060651715.64655,
          "php":4932725538141.728,
          "pkr":23815641524541.637,
          "pln":345639097833.038,
          "rub":7912009945960.79,
          "sar":320758077672.5864,
          "sek":929207676418.1058,
          "sgd":116381812548.8827,
          "thb":3168810815790.897,
          "try":2781089653176.5967,
          "twd":2786828551975.3477,
          "uah":3382087809409.6436,
          "vef":8564001501.044748,
          "vnd":2.174093788511395e+15,
          "zar":1642900925089.1526,
          "xdr":65076917708.083725,
          "xag":3136474675.378387,
          "xau":36821870.830218635,
          "bits":1296202971594.2397,
          "sats":129620297159423.98
       },
       "market_cap_percentage":{
          "btc":50.590697021205465,
          "eth":15.437959097398554,
          "usdt":4.296887096070901,
          "bnb":3.6309192251601923,
          "sol":2.723048572320621,
          "usdc":1.3091791398525554,
          "steth":1.1792234669893673,
          "xrp":1.1565065398372252,
          "doge":0.8963038804594586,
          "ton":0.7659953454490049
       },
       "market_cap_change_percentage_24h_usd":0.4745725078427906,
       "updated_at":1713965918
    }
 }
 
 
 */

/// Model that represents global market data.
struct GlobalData: Codable {
    let data: MarketDataModel?
}

/// Model that represents market data details.
struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    /// Coding keys to map JSON keys to Swift properties.
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    /// Retrieves the market cap formatted as a string.
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    /// Retrieves the volume formatted as a string.
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    /// Retrieves the Bitcoin dominance formatted as a percentage string.
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return item.value.asPercentString()
        }
        return ""
    }
    
}
