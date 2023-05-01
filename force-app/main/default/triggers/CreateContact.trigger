trigger CreateContact on Account (After insert) {
    If(trigger.isAfter){
        If(trigger.isInsert){   
        }
    }
    List<Contact> ListOfContact=New List <Contact>();
    List<Account> ListOfAcc = New List <Account>();
    for(Account accObj:trigger.new){
        if(accObj.Only_Default_Contact__c==false) {
            contact conObj = new contact();
            conObj.AccountId = accObj.Id;
            conObj.FirstName='info';
            conObj.LastName='Default';
            conObj.Email='info@websitedomain.ltd'; 
            ListOfContact.add(conObj);
            ListOfAcc.add(new Account(Id = accObj.Id,Only_Default_Contact__c = true));
        }
    }
    if(ListOfContact.size()>0) {
        insert ListOfContact;  
    }
    if(ListOfAcc.size()>0) {
        update ListOfAcc;
    } 
}