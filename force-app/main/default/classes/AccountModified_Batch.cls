global class AccountModified_Batch implements Database.Batchable <SObject> {
    //START METHOD
    global Database.QueryLocator start(Database.BatchableContext bc){
        String Query='Select Id,name from Account where LastmodifiedDate = today';
        return Database.getQueryLocator(Query);
    }
    //EXECUTE METHOD
    global void execute(Database.BatchableContext bc, List<Account> scopeList){
        system.debug('@@@'+scopeList);
        system.debug('update Acc Record'+scopeList.size());
        integer count = scopeList.size();
       
        List <Messaging.SingleEmailMessage > emails = new List < Messaging.SingleEmailMessage > ();
       
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] {'rajesh.kumar@crmlanding.in'});
        email.setSubject('Account modified in last 24 Hours');
        email.setPlainTextBody('Dear Team,The Total Record update in Last 24 hours:- '+count);
        emails.add(email);
        Messaging.sendEmail(emails);
    }
    //FINISH METHOD
    global void finish(Database.BatchableContext bc){
        
        
    }
    
}