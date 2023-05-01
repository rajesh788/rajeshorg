trigger DomainCheck on Contact (After insert) {
    if(trigger.isAfter) {
        if(trigger.isInsert){
            set<id> accIds=new set<id>();
            for(Contact con:trigger.new){
                if(con.AccountId!=null){
                    accIds.add(con.AccountId);
                }  
            }
            Map<Id,Domain__c> DomainDetail = New Map<Id,Domain__c>();   
            Map<Id,Account> accMap= new Map<Id,Account>([SELECT id,Name,(select id,name,Account_Related__c,Is_valid__c from Domains__r WHERE Is_valid__c = true ) from Account Where Id IN : accIds]);
            
            for(contact con : trigger.new){
                if(accMap.containsKey(con.AccountId)){
                    Account acc = accMap.get(con.AccountId);
                    if(acc.Domains__r != null){
                        Boolean isValidEmail = false;
                        for(Domain__c domain : acc.Domains__r){
                            String conEmail = con.Email.split('@')[1];
                            if(conEmail == domain.name){
                                isValidEmail = true;
                            }
                        }
                        if(!isValidEmail){
                            con.addError('Invalid Email domain');
                        }
                    }
                }
            }
        }
    }
}