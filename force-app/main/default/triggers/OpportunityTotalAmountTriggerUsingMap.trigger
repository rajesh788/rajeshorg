trigger OpportunityTotalAmountTriggerUsingMap on Opportunity (After insert,After Update,After Delete) {
    if(trigger.isAfter){
        set<Id>accountIds = new set <Id>();
        Map<Id,List<Opportunity>> mapOfAccIdOpps = New Map <Id,List<Opportunity>>();
        List<Account> accountList = new List <Account>();
        if(trigger.isInsert || trigger.isUpdate){
            for(Opportunity opp : trigger.new){
                if(opp.AccountId!=null && opp.Amount!=null){
                    accountIds.add(opp.AccountId); 
                } 
            }
        }
        else if (trigger.isDelete)
            for(Opportunity opp : trigger.old){
                if(opp.AccountId != null){
                    accountIds.add(opp.AccountId);
                }
            }     
        if(!accountIds.isEmpty()){
            Decimal SumOfOppAmount=0;
            List<Opportunity> opptyList = new List<Opportunity>();
            opptyList=([SELECT Id,AccountId,name,Amount from Opportunity where AccountId In:accountIds]);
            for(Opportunity opp: opptyList){
                if(!mapOfAccIdOpps.containsKey(opp.accountId)){
                    mapOfAccIdOpps.put(opp.AccountId,new List<Opportunity>());
                }
                mapOfAccIdOpps.get(opp.AccountId).add(opp);
            }
            accountList=([select id,Opp_amount_total__c from account where Id In:accountIds]);
            for(Account acc : accountList){
                List<Opportunity> tempOpptyList = new List<Opportunity>();
                tempOpptyList=mapOfAccIdOpps.get(acc.id);
                for(Opportunity oppty : tempOpptyList ){
                    if(oppty.Amount!=null){
                        SumOfOppAmount += oppty.Amount;
                    }
                    acc.Opp_amount_total__c=SumOfOppAmount;
                }
                
            }
            update  accountList;
        }
    }  
}