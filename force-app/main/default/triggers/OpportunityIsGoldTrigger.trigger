trigger OpportunityIsGoldTrigger on Opportunity (After insert,After Update) {
    if(trigger.isAfter){
        if(trigger.isInsert || trigger.isUpdate){
            
            set<Id> oppAccIds = new set <Id> ();
            for (Opportunity opp : trigger.new){
                Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
                if(opp.AccountId!=null){
                    if(opp.Amount>= 20000 || opp.Amount != oldOpp.Amount){
                        oppAccIds.add(opp.AccountId); 
                    }
                }
            }
            // Way 1
            if(!oppAccIds.isEmpty()){
                List <Account> accList = new List <Account> ();
                for(Id accObj : oppAccIds){
                    Account acc = new Account ();
                    acc.Id = accObj;
                    acc.is_gold__c = true;
                    accList.add(acc);
                }
                Update accList;
            }
            // Way 2
          /*  if(!oppAccIds.isEmpty()){
                List <Account> accList = [select id,is_gold__c from account where Id In:oppAccIds];
                for(Account accObj : accList ){
                    accObj.is_gold__c = true;
                }
                if(!accList.isEmpty()){
                    update accList;
                }
            } */
        }
    }
}