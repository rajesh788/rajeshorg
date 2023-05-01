trigger OppAssetsCountTrgger on Opportunity (before Update) {
    if(Trigger.isbefore){
        if(Trigger.isUpdate){
            Set<Id> OppSet = New Set<Id>();
            for(Opportunity oppObj : trigger.new){
                if(oppObj.StageName!='Closed Won'){
                    OppSet.add(oppObj.Id);
                    system.debug('@#@@#@ '+OppSet);
                }
            }
            Map<Id,string> caseAssetsMap = new Map<Id,string> ();
            List <Case> caseLst = [SELECT Id,Opportunity_case__c,Opportunity_case__r.name,Asset_Id__c,Opportunity_case__r.Total_Assets_Count__c,Asset_Id__r.name From Case where Opportunity_case__c In : OppSet ];
            system.debug('@@@ '+caseLst);
            for(Case caseObj : caseLst ){
                if(caseObj.Asset_Id__c!=null){
                    caseAssetsMap.put(caseObj.Opportunity_Case__c,caseObj.Asset_Id__c);
                }
            }
            system.debug('caseAssetsMap '+caseAssetsMap);
            integer count = caseAssetsMap.size();
            system.debug('@@@'+count);
            
            List <Opportunity> oppLst = ([SELECT Id,name,Total_Assets_Count__c,(select asset_Id__c from cases__r) FROM Opportunity where Id in : caseAssetsMap.keySet()]);
            system.debug('$$$ '+oppLst);
            for(Opportunity oppObj : oppLst){
                oppObj.Total_Assets_Count__c = count;
                system.debug('#@#CCC '+oppObj.Total_Assets_Count__c);
            }
        }
    }
}

                
            
            
            
           /* List <Case> caseLst = [SELECT Id,Opportunity_case__c,Opportunity_case__r.name,Asset_Id__c,Opportunity_case__r.Total_Assets_Count__c,Asset_Id__r.name From Case where Opportunity_case__c !=null ];
            Map <Id,List<string>> oppAssetMap = New Map <Id,List<string>>();
            
            List <String> caseList = new List <String>();  
            
            List <String> assetslst = new List <String>();
            system.debug('caseLst'+caseLst);
            for(Case caseObj : caseLst ){
                if(caseObj.Asset_Id__c!=null){
                    List<string> asstlst = new List <string>();
                    asstlst.add(caseObj.Asset_Id__c);
                    oppAssetMap.put(caseObj.Opportunity_Case__c,asstlst) ;
                }
            }
            system.debug('### '+oppAssetMap);
            //system.debug('caseList '+caseList);
            //system.debug('caseList '+assetslst);
            
            //caseList.add(caseObj.Opportunity_Case__c);
             assetslst.add(caseObj.Asset_Id__c);*/