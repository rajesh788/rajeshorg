@isTest
global class HMC_HttpCalloutMockClass implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HTTPResponse res = new HTTPResponse();
        res.setBody('{ "attributes": { "type": "Claim_settlement__c", "url": "/services/data/v55.0/sobjects/Claim_settlement__c/a0U5j000000Pc0yEAC" }, "Name": "Test RR", "Local_Currency__c": "AUD", "Local_Amount__c": 5000, "Exchange_Rate__c": 1.4355, "Converted_Amount_USD__c": 3483.10693138279345175896900034831, "Claim_Event__c": "2022-08-05", "Id": "a0U5j000000Pc0yEAC", "conversion_rates": { "USD": 1, "AED": 3.6725, "AFN": 89.8963, "ALL": 113.9985, "AMD": 405.6495, "ANG": 1.7900, "AOA": 426.5417, "ARS": 132.4659, "AUD": 1.4468, "AWG": 1.7900, "AZN": 1.6977, "BAM": 1.9225, "BBD": 2.0000, "BDT": 93.7199, "BGN": 1.9223, "BHD": 0.3760, "BIF": 2033.7736, "BMD": 1.0000, "BND": 1.3800, "BOB": 6.8672, "BRL": 5.2122, "BSD": 1.0000, "BTN": 79.4552, "BWP": 12.6303, "BYN": 2.6103, "BZD": 2.0000, "CAD": 1.2931, "CDF": 1992.3409, "CHF": 0.9618, "CLP": 901.9651, "CNY": 6.7688, "COP": 4294.2031, "CRC": 666.2856, "CUP": 24.0000, "CVE": 108.3883, "CZK": 24.0875, "DJF": 177.7210, "DKK": 7.3334, "DOP": 54.2458, "DZD": 144.5337, "EGP": 19.1026, "ERN": 15.0000, "ETB": 52.2833, "EUR": 0.9830, "FJD": 2.1878, "FKP": 0.8296, "FOK": 7.3334, "GBP": 0.8295, "GEL": 2.7157, "GGP": 0.8296, "GHS": 8.9196, "GIP": 0.8296, "GMD": 54.5023, "GNF": 8634.6369, "GTQ": 7.7109, "GYD": 208.8552, "HKD": 7.8552, "HNL": 24.4878, "HRK": 7.4063, "HTG": 122.5648, "HUF": 386.2440, "IDR": 14872.1244, "ILS": 3.3668, "IMP": 0.8296, "INR": 79.3556, "IQD": 1456.3791, "IRR": 41931.8944, "ISK": 135.6768, "JEP": 0.8296, "JMD": 152.6199, "JOD": 0.7090, "JPY": 135.0191, "KES": 119.1372, "KGS": 82.8624, "KHR": 4091.3009, "KID": 1.4466, "KMF": 483.5946, "KRW": 1301.1480, "KWD": 0.2996, "KYD": 0.8333, "KZT": 476.8264, "LAK": 17071.7038, "LBP": 1507.5000, "LKR": 355.4280, "LRD": 153.5774, "LSL": 16.7573, "LYD": 4.8403, "MAD": 10.3186, "MDL": 19.2564, "MGA": 4109.6129, "MKD": 60.1418, "MMK": 1832.5843, "MNT": 3184.3205, "MOP": 8.0911, "MRU": 37.6093, "MUR": 44.5989, "MVR": 15.3855, "MWK": 1031.5616, "MXN": 20.4495, "MYR": 4.4279, "MZN": 64.8191, "NAD": 16.7573, "NGN": 417.0071, "NIO": 35.7380, "NOK": 9.8163, "NPR": 127.1283, "NZD": 1.6028, "OMR": 0.3845, "PAB": 1.0000, "PEN": 3.8952, "PGK": 3.5172, "PHP": 55.3170, "PKR": 224.2870, "PLN": 4.6093, "PYG": 6849.5287, "QAR": 3.6400, "RON": 4.8170, "RSD": 114.9101, "RUB": 60.3046, "RWF": 1054.6197, "SAR": 3.7500, "SBD": 8.0164, "SCR": 12.8176, "SDG": 565.3422, "SEK": 10.2022, "SGD": 1.3802, "SHP": 0.8296, "SLE": 13.9344, "SLL": 13934.4096, "SOS": 567.2157, "SRD": 24.3191, "SSP": 660.6686, "STN": 24.0830, "SYP": 2516.2732, "SZL": 16.7573, "THB": 35.8482, "TJS": 10.2566, "TMT": 3.4978, "TND": 3.0851, "TOP": 2.3168, "TRY": 17.9414, "TTD": 6.7758, "TVD": 1.4466, "TWD": 29.8696, "TZS": 2331.3194, "UAH": 36.8259, "UGX": 3878.3884, "UYU": 40.8061, "UZS": 10958.3565, "VES": 5.8662, "VND": 23358.9140, "VUV": 116.7406, "WST": 2.6287, "XAF": 644.7928, "XCD": 2.7000, "XDR": 0.7553, "XOF": 644.7928, "XPF": 117.3010, "YER": 250.0735, "ZAR": 16.7592, "ZMW": 16.0650, "ZWL": 434.3692 } }');
        res.setStatusCode(200);
        return res; 
    }
}