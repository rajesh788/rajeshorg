@RestResource(urlMapping='/ClaimAPIII/*')
global class csettel {
    @HttpGet
    global static Claim_settlement__c claimSettelMtd(){
        RestRequest request = RestContext.request;
        
        String claimRec = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        
        Claim_settlement__c result = [Select Id,Name,Exchange_Rate__c,Local_Amount__c,Local_Currency__c,	Claim_Event__c from Claim_settlement__c Limit 1];
        return result;
    }
    
}