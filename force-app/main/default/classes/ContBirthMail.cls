global class ContBirthMail implements Database.Batchable <SObject>,Database.Stateful {
    Date dt = System.today(); //current date
    Integer day = dt.Day(); //get day
    Integer month = dt.Month(); //get month
    Integer year = dt.Year(); //get year
    global Database.QueryLocator start(Database.BatchableContext bc){
        String Query='Select Id,lastname,email,birthdate from contact where birthdate = today';
        return Database.getQueryLocator(Query);
        
    }
    //EXECUTE METHOD
    global void execute(Database.BatchableContext bc, List<Contact> scopeList){
        List <String> conEmailLst = new List <String>();
        for(Contact con : scopeList){
            Date bdate = con.Birthdate;
            conEmailLst.add(con.Email);
            List <Messaging.SingleEmailMessage > emails = new List < Messaging.SingleEmailMessage > ();
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
            mail.toAddresses = conEmailLst;
            mail.setSaveAsActivity(false);
            mail.setSubject('Birthday Wishes');
            mail.setPlainTextBody('Hi Dear,Happy Birthday :-'+bdate);
            emails.add(mail);
            Messaging.sendEmail(emails);
            
        }
    }
    
    //FINISH METHOD
    global void finish(Database.BatchableContext bc){
        
        
    }
}