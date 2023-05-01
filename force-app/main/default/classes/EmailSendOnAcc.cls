global class EmailSendOnAcc implements Database.Batchable <SObject> {
    //START METHOD
    global Database.QueryLocator start(Database.BatchableContext bc){
        String Query='Select id,Email_Address__c,OwnerId from Account where Email_Address__c !=null';
        return Database.getQueryLocator(Query);
    }
    //EXECUTE METHOD
    global void execute(Database.BatchableContext bc, List<Account> scope){
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        EmailTemplate emailTemplate = [select Id,subject from EmailTemplate where DeveloperName  = 'Welcome'];
        
        List<String> EmailList = new List <String>();
        
        for(Account acc: scope){
            EmailList.add(acc.Email_Address__c);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.toAddresses = EmailList;
            mail.setSaveAsActivity(false);
            mail.setTemplateId(emailTemplate.Id);
            mail.setTargetObjectId(acc.OwnerId);
           // mail.setSubject('Test Subject');
           // mail.setPlainTextBody('this is a test mail');
           // mail.subject = 'Hi';
            mails.add(mail);
        }
        Messaging.SingleEmailMessage[] messages =  mails;
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
    }
    //FINISH METHOD
    global void finish(Database.BatchableContext bc){
       
    }
}