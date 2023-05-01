@isTest
global class claimSettel_Class {
      @isTest
      static void getWebserviceTest() { 
        Claim_settlement__c csRec = new  Claim_settlement__c ();
        csRec.Name ='Test Name';
        csRec.Local_Currency__c='INR';
        csRec.Local_Amount__c=1000;
        insert csRec;
        
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestURI = '/services/apexRest/ClaimAPI/' + csRec.Id;
        RestContext.request.httpMethod = 'GET';
        claimSettel.claimSettelMtd();
      }
    
    
    @isTest
    static void postWebserviceTest() { 
        Test.startTest();
        String Name = 'Test';
        String Currenci = 'INR';
        Decimal Amt = 1.0;
        Decimal exchangeRate =1.0;
        Decimal convertedAmt = 1.1;
        
        Test.setMock(HttpCalloutMock.class,new HMC_HttpCalloutMockClass());
        claimSettel.recordInsert(Name,Currenci,Amt,exchangeRate,convertedAmt);
        Test.stopTest();
        
    }
}