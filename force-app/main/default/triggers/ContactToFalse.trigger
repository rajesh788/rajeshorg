trigger ContactToFalse on Contact (after insert) {
    if(trigger.isAfter){
        if(trigger.isInsert){   
        }
    }
    set <Id> accIds = New Set <Id> ();
    for (Contact conObj : trigger.new){
        if(conObj.AccountId!=null){
            accIds.add(conObj.AccountId);
        }
    }
    List<Account> listOfAcc=[select Name , (Select Id,LastName from contacts) from Account where id IN: accIds];
    for(Account acct : listOfAcc){
        system.debug('####'+acct.contacts.size());
       
    }
}