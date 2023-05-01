trigger OppTotalAmount on Opportunity (After insert,After Update,After Delete) {
    if(trigger.isAfter){
        set<Id>accountIds= new set <Id>();
        if(trigger.isInsert || trigger.isUpdate ){ 
            for(Opportunity opp : trigger.new){
                if(opp.AccountId!=null){
                    if(opp.Amount!=null){
                        accountIds.add(opp.AccountId);
                    }
                }
            }
        }else if(trigger.isdelete){
            for(opportunity opp : trigger.old){
                if(opp.AccountId!=null && opp.Amount!=null ){
                    accountIds.add(opp.AccountId);  
                }
            }
        }
        if(!accountIds.isEmpty()){
            List <opportunity> oppAmountList = new List <opportunity> ([SELECT id,AccountId, name,Amount from Opportunity where AccountId In : accountIds]);
            Decimal oppSum=0;
            for(opportunity opp : oppAmountList){
                if(opp.Amount!=null){
                    oppSum += opp.Amount;
                    system.debug('oppSum'+oppSum);
                }
            }
            List<Account> accountList = new List<Account>();
            accountList = [SELECT id,Opp_amount_total__c FROM Account WHERE Id IN: accountIds];
            for(Account acc : accountList){
                acc.Opp_amount_total__c = oppSum;
            }
            update accountList;
        }
    }
}