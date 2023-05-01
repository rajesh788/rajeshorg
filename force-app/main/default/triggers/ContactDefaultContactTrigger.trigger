trigger ContactDefaultContactTrigger on Contact (After insert,After Update) {
    if(Trigger.isAfter){
        if(trigger.isInsert || trigger.isUpdate){
            Set <Id> conAccIdSet = new Set <Id> ();
            Set <Id> conSizeAccIds = New Set <Id>();
            for(Contact con : trigger.new){
                if(con.AccountId!=null){
                    conAccIdSet.add(con.AccountId);
                }
            }
            if(!conAccIdSet.isEmpty()){
                Map <Id,List<Contact>> accConMap = new Map <Id,List<Contact>> ();
                List <Account> accList = [select id,Name,(select Id from Contacts) from Account where Id In : conAccIdSet];
                for(Account acc : accList){
                    accConMap.put(acc.Id,acc.Contacts);
                    List<Contact> conLst = accConMap.get(acc.Id);
                    Integer conCount = conLst.size();
                    system.debug('conCount '+conCount);
                    if(conCount>=1){
                        conSizeAccIds.add(acc.Id);
                    }
                }
            }
            if(!conSizeAccIds.isEmpty()){
                List <Account> accLstDefault = New List <Account> (); // if more than 1 contact on Acc=> Default- False
                for(Id accId : conSizeAccIds){
                    Account acct = new Account ();
                    acct.Id = accId;
                    acct.Only_Default_Contact__c = false;
                    accLstDefault.add(acct);
                }
                system.debug('### '+accLstDefault);
                update accLstDefault;
            }
        }
    }
}