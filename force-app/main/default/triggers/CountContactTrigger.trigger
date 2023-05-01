trigger CountContactTrigger on Contact (after insert,after Update) {
    if(trigger.isInsert || trigger.isUpdate) {
        Set<id> accIds= New Set <id>();
        List<Contact> Conlist = New List <Contact>();
        List<Account> acclist = New List <Account>();
        for(Contact conObj : trigger.new) {
            if(conObj.AccountId!=null){
                accIds.add(conObj.AccountId);  
            } 
        }
        conList = [SELECT Id, AccountId FROM Contact WHERE AccountId IN : accIds];
        integer countCon = conList.size();
        acclist=[Select id,Number_Of_Contact__c From Account WHERE Id IN : accIds];
        for(Account acc :acclist){
            acc.Number_Of_Contact__c = countCon;
        }
        update accList;  
    }
}