@RestResource(urlMapping='/ClaimAPI/*')
global class claimSettel {
    @HttpGet
    global static Claim_settlement__c claimSettelMtd(){
        RestRequest request = RestContext.request;
        
        String claimRec = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        system.debug('Record'+claimRec);
        Claim_settlement__c result = [Select Id,Name,Exchange_Rate__c,Local_Amount__c,Local_Currency__c,Claim_Event__c from Claim_settlement__c where id =:claimRec Limit 1];
        return result;	
    }
    @HttpPost
    global static Claim_settlement__c recordInsert(String Name,String currencyType,Decimal amt,Decimal exchangeRate,Decimal convertedAmt) 
    {
        system.debug('Claim_settlement__c'+Name);
        system.debug('Claim_settlement__c'+currencyType);
        system.debug('Claim_settlement__c'+amt);
        system.debug('Claim_settlement__c'+exchangeRate);
        system.debug('Claim_settlement__c'+convertedAmt);
        
        
        string rate;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint('https://v6.exchangerate-api.com/v6/5cf8535b087045f4f75d57af/latest/USD');
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        System.debug('response.getBody()'+response.getBody());
        
        Map<String,Object> results = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
        system.debug(results);
        Map<String,Object> dataMap = (Map<String, Object>) results.get('conversion_rates');
        system.debug(dataMap);
        
        for(String str: dataMap.keyset()) {
            system.debug('###'+str); 
            String Value = '' + dataMap.get(str);
            system.debug('###'+Value);
        }
        Claim_settlement__c claimObj = new Claim_settlement__c ();
        claimObj.Name = Name;
        claimObj.Local_Currency__c = currencyType;
        claimObj.Local_Amount__c = amt;
        Decimal exchange = Decimal.valueOf(dataMap.get(currencyType)+'');
        claimObj.Exchange_Rate__c = exchange;
        system.debug(claimObj.Exchange_Rate__c);
        claimObj.Converted_Amount_USD__c = amt/exchange;
        claimObj.Claim_Event__c = System.today();
        insert claimObj;
        
        if(response.getStatusCode() == 200) {
            system.debug(response.getStatusCode());
        }
        return claimObj;
    }
    
}