global class AccountMark implements Database.Batchable <SObject>,Database.Stateful {
    DateTime startDate;
    DateTime EndDate;
    Public AccountMark (DateTime startDate,Datetime EndDate){
        this.startDate = startDate;
        this.EndDate = EndDate;
       system.debug('startDate'+startDate);
        system.debug('EndDate'+EndDate);
    }
        global Database.QueryLocator start(Database.BatchableContext bc){
            String Query='select id,name,mark__c from Account where CreatedDate >: startDate and CreatedDate <: EndDate ';
            return Database.getQueryLocator(Query);
        
    }
    //EXECUTE METHOD
    global void execute(Database.BatchableContext bc, List<Account> scopeList){
        system.debug('List'+scopeList);
        List <Account> accLst = new List <Account> ();
        for(Account acc : scopeList) {
            acc.Mark__c =true;
            accLst.add(acc);
        }
        update accLst; 
    }
    //FINISH METHOD
    global void finish(Database.BatchableContext bc){
        
        
    }
    
}
//AccountMark accObj = new AccountMark (system.today().addDays(-99), system.today());
//Id batchId = Database.executeBatch(accObj);
//select id,name from Account where CreatedDate > 2022-03-25T00:00:00.000+02:00 and CreatedDate < 2022-07-27T23:59:59.999+02:00