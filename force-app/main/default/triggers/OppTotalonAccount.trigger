trigger OppTotalonAccount on Opportunity (After insert,After Delete,After Update) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            set <Id> oppActIds = new Set <Id>();
            for(Opportunity opp : trigger.new){
                if(opp.AccountId!=null){
                    oppActIds.add(opp.AccountId);
                }
            }
            List <Account> accLst = [SELECT Id,name,Number_Of_Opportunity__c,(Select id from Opportunities) FROM Account where Id In : oppActIds];
            for(Account accObj : accLst){
                accObj.Number_Of_Opportunity__c = accObj.Opportunities.size();
                system.debug('###'+accObj.Opportunities.size()); 
            }
            update accLst;
        }
        if(trigger.isDelete){
            set <Id> oppAccIdSet = new Set <Id>();
            for(Opportunity opp : trigger.old){
                oppAccIdSet.add(opp.AccountId);
            }
            List <Account> accLst2 = [SELECT Id,name,Number_Of_Opportunity__c,(Select id from Opportunities) FROM Account where Id In : oppAccIdSet];
            for(Account acc :accLst2){
                acc.Number_Of_Opportunity__c = acc.Opportunities.size();
            }
            update accLst2;
        }
        if(trigger.isUpdate){
            set <Id> oppAccId = new Set <Id>();
            for(Opportunity opp : Trigger.new){
                oppAccId.add(opp.AccountId);
                Opportunity oppOld = trigger.oldMap.get(opp.AccountId); 
                oppAccId.add(oppOld.AccountId);
            }
            List <Account> accLst3 = [SELECT Id,name,Number_Of_Opportunity__c,(Select id from Opportunities) FROM Account where Id In : oppAccId];
            for(Account acc :accLst3){
                acc.Number_Of_Opportunity__c = acc.Opportunities.size();
            }
            update accLst3;
        }
    }
}