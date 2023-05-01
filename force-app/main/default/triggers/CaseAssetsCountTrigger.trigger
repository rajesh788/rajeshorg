trigger CaseAssetsCountTrigger on Case (After Update) {
    if(Trigger.isInsert){
        if(Trigger.isUpdate){
           Map<Id,string> caseAssetsMap = new Map<Id,string> ();
            List <Case> caseLst = [SELECT Id,Opportunity_case__c,Opportunity_case__r.name,Asset_Id__c,Opportunity_case__r.Total_Assets_Count__c,Asset_Id__r.name From Case where Opportunity_case__c !=null ];
            system.debug('@@@ '+caseLst);
            for(Case caseObj : caseLst ){
                if(caseObj.Asset_Id__c!=null){
                    caseAssetsMap.put(caseObj.Opportunity_Case__c,caseObj.Asset_Id__c);
                }
            }
            system.debug('caseAssetsMap '+caseAssetsMap);
            integer count = caseAssetsMap.size();
            system.debug('@@@'+count);
            
            List <Opportunity> oppLst = New List<Opportunity> ([SELECT Id,name,Total_Assets_Count__c,(select asset_Id__c from cases__r) FROM Opportunity where Id in : caseAssetsMap.keySet()]);
            system.debug('$$$ '+oppLst);
            for(Opportunity oppObj : oppLst){
                oppObj.Total_Assets_Count__c = count;
                system.debug('#@#CCC '+oppObj.Total_Assets_Count__c);
            }
            update oppLst;
            
            
            
        }
    }
}