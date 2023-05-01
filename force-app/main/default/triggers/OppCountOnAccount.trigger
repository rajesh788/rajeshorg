trigger OppCountOnAccount on Opportunity (After insert,After Update) {
    if(trigger.isAfter){
        if(trigger.isInsert || trigger.isUpdate){
            set<Id>oppIds= new set <Id>();
            for(Opportunity opp : trigger.new){
                if(opp.AccountId!=null){
                    oppIds.add(opp.AccountId);
                }  
            }
            List<Account> accountList=new List <Account>([select id,name,Number_Of_Opportunity__c,(select id from opportunities) from account where Id in:oppIds]);
            if(!accountList.isEmpty()){
                for(Account acc : accountList){
                    acc.Number_Of_Opportunity__c=acc.opportunities.size();
                }
            }
            update accountList;
        }
    }
    
}