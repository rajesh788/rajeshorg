trigger TriggerAccountPostalCode on Account (After Update) {
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            Boolean isZipCode = false;
            Map <Id,String> accMap = new Map <Id,String> ();
            for(Account acc : trigger.new){
                Account oldAccount = Trigger.oldMap.get(acc.Id);
                if(acc.BillingPostalCode != oldAccount.BillingPostalCode) {
                    accMap.put(acc.Id,acc.BillingPostalCode);
                }
            }
            Set<Id> outOfZipAccIds = new Set<Id>();
                
            if(!accMap.isEmpty()){
                List <Contact> conList = [select id,MailingPostalCode,AccountId from contact where AccountId In: accMap.KeySet()];
                for(Contact con : conList){
                    if(accMap.containskey(con.AccountId)){
                        string zipCode = accMap.get(con.AccountId);
                        system.debug('zipCode '+zipCode);
                        if(con.MailingPostalCode != zipCode){
                            outOfZipAccIds.add(con.accountId);
                        }
                    }
                }
            }
            //mark Out_of_Zip as TRUE
            if(!outOfZipAccIds.isEmpty()){
                
                /*List <Account> accList = [select Id,Out_of_Zip__c from account where Id In: accMap.KeySet()];
                for(Account accObj : accList){
                    accObj.Out_of_Zip__c = true;
                }
                update accList;*/
                // Way 1
                List<Account> updateAccLst = new List<Account>();
                for(Id recID : outOfZipAccIds){
                    Account acc = new Account(Id = recId);
                    acc.Out_of_Zip__c = true;
                    updateAccLst.add(acc);
                }
                if(!updateAccLst.isEmpty()){
                    update updateAccLst;
                }
                 
                /*
                    List<Account> updateAccLst = [select id,Out_of_Zip__c from Account where id in : outOfZipAccIds];
                    for(Account acc : updateAccLst){ 
                        acc.Out_of_Zip__c = true;
                        updateAccLst.add(acc);
                    }
                    if(!updateAccLst.isEmpty()){
                        update updateAccLst;
                    }

                */
                
            }
        }
    }
}