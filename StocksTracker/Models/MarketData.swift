//
//  MarketData.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 16/09/23.
//

import Foundation

//JSON Data
/* https://api.coingecko.com/api/v3/
    
 JSON Respnse :
 
 {
   "data": {
     "active_cryptocurrencies": 10034,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 861,
     "total_market_cap": {
       "btc": 41429193.90446202,
       "eth": 672059861.5466748,
       "ltc": 16953919224.283146,
       "bch": 5084878459.632744,
       "bnb": 5128890507.625664,
       "eos": 1912168060716.7554,
       "xrp": 2193964017968.049,
       "xlm": 9243559802190.227,
       "link": 176555846540.85828,
       "dot": 265003155698.2541,
       "yfi": 199530724.02966443,
       "usd": 1100854964462.0789,
       "aed": 4043412763095.0986,
       "ars": 385150622141524.9,
       "aud": 1712060649281.0674,
       "bdt": 120621168336569.19,
       "bhd": 414988195098.3047,
       "bmd": 1100854964462.0789,
       "brl": 5357861112036.941,
       "cad": 1490172322644.0928,
       "chf": 987889631428.8383,
       "clp": 973783275914221.4,
       "cny": 8007949267986.485,
       "czk": 25369422827021.46,
       "dkk": 7703122528326.936,
       "eur": 1031673935930.386,
       "gbp": 888789566672.9987,
       "hkd": 8617162405319.8,
       "huf": 395988539266653.94,
       "idr": 16916838238888768,
       "ils": 4190459464973.121,
       "inr": 91485506009404.66,
       "jpy": 162678842373383.47,
       "krw": 1463487598305530.5,
       "kwd": 340186201118.0712,
       "lkr": 355210879936348.06,
       "mmk": 2308046566168400,
       "mxn": 18801832194537.188,
       "myr": 5156404653540.367,
       "ngn": 862243099810277.4,
       "nok": 11872259533493.387,
       "nzd": 1865539646716.443,
       "php": 62434994813741.484,
       "pkr": 326315676258216.1,
       "pln": 4796791664864.45,
       "rub": 106568728294691.45,
       "sar": 4129348804185.9033,
       "sek": 12294898670594.732,
       "sgd": 1501015744044.0437,
       "thb": 39387783701764.195,
       "try": 29715376954869.91,
       "twd": 35105715490068.39,
       "uah": 40590487565828.4,
       "vef": 110228607591.58804,
       "vnd": 26710792559900424,
       "zar": 20882062778132.92,
       "xdr": 831713539330.5326,
       "xag": 47786385665.00475,
       "xau": 572235419.0770335,
       "bits": 41429193904462.016,
       "sats": 4142919390446201.5
     },
     "total_volume": {
       "btc": 1124692.1041527977,
       "eth": 18244632.55410238,
       "ltc": 460253683.18696445,
       "bch": 138040886.51383698,
       "bnb": 139235696.21685416,
       "eos": 51910262233.45557,
       "xrp": 59560270795.86148,
       "xlm": 250937991884.6998,
       "link": 4793020279.478086,
       "dot": 7194128794.219685,
       "yfi": 5416726.9189344505,
       "usd": 29885275808.240143,
       "aed": 109767870911.7707,
       "ars": 10455812020649.93,
       "aud": 46477879789.7331,
       "bdt": 3274542969256.6084,
       "bhd": 11265822536.15646,
       "bmd": 29885275808.240143,
       "brl": 145451637358.7049,
       "cad": 40454203597.824265,
       "chf": 26818568345.901775,
       "clp": 26435618421694.992,
       "cny": 217394461811.8809,
       "czk": 688712158056.0548,
       "dkk": 209119228940.5792,
       "eur": 28007195420.622845,
       "gbp": 24128265932.368225,
       "hkd": 233932973444.16098,
       "huf": 10750032560982.05,
       "idr": 459247033345226.4,
       "ils": 113759796627.85638,
       "inr": 2483587455031.775,
       "jpy": 4416296632562.681,
       "krw": 39729784512232.484,
       "kwd": 9235147930.26236,
       "lkr": 9643027882580.904,
       "mmk": 62657307669869.95,
       "mxn": 510419591111.676,
       "myr": 139982631885.79657,
       "ngn": 23407600168450.453,
       "nok": 322300177661.30566,
       "nzd": 50644425172.36636,
       "php": 1694943566890.715,
       "pkr": 8858600179265.594,
       "pln": 130220098493.34665,
       "rub": 2893056706317.799,
       "sar": 112100805197.18939,
       "sek": 333773702864.3302,
       "sgd": 40748573564.535416,
       "thb": 1069273262511.6641,
       "try": 806693220006.5499,
       "twd": 953026532772.1489,
       "uah": 1101923464267.1313,
       "vef": 2992412666.679088,
       "vnd": 725126768265403.6,
       "zar": 566892302542.7161,
       "xdr": 22578804037.538376,
       "xag": 1297272902.952689,
       "xau": 15534665.217881318,
       "bits": 1124692104152.7976,
       "sats": 112469210415279.77
     },
     "market_cap_percentage": {
       "btc": 47.038129728842584,
       "eth": 17.90607890000264,
       "usdt": 7.555665131133299,
       "bnb": 2.9998730808457315,
       "xrp": 2.4272456618813947,
       "usdc": 2.377071485730909,
       "steth": 1.2876416883709205,
       "doge": 0.7972852545348864,
       "ada": 0.7957696514605608,
       "sol": 0.711487102822079
     },
     "market_cap_change_percentage_24h_usd": 1.0801110537307814,
     "updated_at": 1694886030
   }
 }
 
 */

struct GlobalData: Codable {
    let data: MarketData?
}

struct MarketData: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        
//        if let item = totalMarketCap.first(where: { (key, value) -> Bool in
//            return key == "inr"
//        }) {
//            return "\(item.value)"
//        }
        
        // Total Market Cap is a dictoinary. So we are getting the total market cap in terms of INR, by using the .first functoin and mapping it to the inr.
        if let item = totalMarketCap.first(where: {$0.key == "inr"}) {
            return "\(item.value)"
        }
        
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: {$0.key == "inr"}){
            return "\(item.value)"
        }
        
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}) {
            return item.value.asPercentString()
        }
        
        return ""
    }
    
}
