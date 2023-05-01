trigger ContactCountOnAccount on Contact (After insert,After Update,After Delete) {
    if(trigger.isAfter){
        if(trigger.isInsert || trigger.isUpdate){
            set<Id>accountIds = New set <Id>();
            for(contact con : trigger.new){
                if(con.AccountId!=null){
                    accountIds.add(con.AccountId);
                }
            }
            List<Account>accountList=new List<Account>([Select id,name,Number_Of_Contact__c,(Select id,name from contacts) from account where Id IN:accountIds]);   
            if(!accountList.isEmpty()){
                for(Account acc : accountList ){
                    acc.Number_Of_Contact__c = acc.contacts.size();
                } 
            }
            update accountList;
        }
    }
}