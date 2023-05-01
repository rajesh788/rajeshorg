public class AccountHelper {
    public static void afterInsertMtd (List<Account> ListofAcc){
        
        List<Opportunity>oppList =new List<Opportunity>();
        Set<Id> accIds = new Set<Id>();
        for (Account acc : ListofAcc){
            if(acc.Opportunity__c==false){
                Opportunity opp = new Opportunity();
                opp.Name = acc.name;
                opp.CloseDate =system.today(); 
                opp.StageName='Prospecting';
                oppList.add(opp);
            }
            accIds.add(acc.Id);
        }  
        if (!oppList.isEmpty()) {
            insert oppList;
        }
        List<Account> accList = [SELECT Id,Opportunity__c FROM Account where Id IN:accIds];
        for(Account acc : accList){
            acc.Opportunity__c = true;
        }
        if (!accList.isEmpty()) {
            update accList;
        }
    }
}