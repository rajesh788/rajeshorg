trigger CountOppTrigger on Opportunity (after Insert,after Update) {
    if(trigger.isInsert||trigger.isUpdate){
        Set<Id> accIds= New Set <Id>();
        List<Opportunity> oppList = New List <Opportunity>();
        List<Account>accList=New List <Account>();
        
        for(Opportunity oppObj : trigger.new){
            if(oppObj.AccountId!=null){
                accIds.add(oppObj.AccountId);
            }
        }
        oppList=[Select id,name,AccountId from Opportunity Where Id IN : accIds];
        integer oppCount = oppList.size();
        accList=[Select id,name,Number_Of_Opportunity__c from Account Where Id IN : accIds];
        for(Account accObj:accList){
            accObj.Number_Of_Opportunity__c=oppCount;
        }
        update accList;        
    }
    
}