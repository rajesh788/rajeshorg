global class OpportunityCaseBatch implements Database.Batchable <SObject> {
    //START METHOD
    global Database.QueryLocator start(Database.BatchableContext bc){
        String Query='select id,Name,createdDate,Number_Of_Case__c,(select id from cases__r) from Opportunity order by createdDate DESC Limit 1';
        //Integer size = cases__r.size();
        return Database.getQueryLocator(Query);
    }
    //EXECUTE METHOD
    global void execute(Database.BatchableContext bc, List<Opportunity> scopeList){
        System.debug('scope : ' + scopeList);
        Integer count = 0;
        Id oppIds;
        List<Case> CaseList = new List <Case>();
			
        List <Case> delcaseLst = new List <Case>();
		for(Opportunity opp : scopeList){
			count = opp.cases__r.size();
            system.debug('###'+count);
			
			
			Integer num;
			if(count < 5){
				for(num = count; num < 5 ; num++){
					Case caseObj = new Case();
					caseObj.Status = 'New';
					caseObj.Origin = 'Web';
					caseObj.Opportunity_Case__c = opp.Id;
					CaseList.add(caseObj);
				}
			}else{
				for(num = 5; num < count  ; num++){
					delcaseLst.add(opp.cases__r[num]); 
				}
			}
		}
		if(!CaseList.isEmpty()){
			insert CaseList;
            system.debug('###'+CaseList);
		}
		if(!delcaseLst.isEmpty()){
			delete delcaseLst;
            system.debug('###'+delcaseLst);
		}
		
    }
	//FINISH METHOD
	global void finish(Database.BatchableContext bc){
		
	}
}