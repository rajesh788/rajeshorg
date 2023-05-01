public class AccountRelationMapHelper {
    public static void AfterInsertMtd(List <Accounts_Relationship_Map__c> accRelList ){
        
        set <Id> accountIds = new set <Id>();
        for(Accounts_Relationship_Map__c accRelation : accRelList){
            if(accRelation.To_Account__c!=null && accRelation.From_Account__c!=null){
                accountIds.add(accRelation.From_Account__c);
                accountIds.add(accRelation.To_Account__c);
            }
        }
        List<Contact> contactCloneList = New List<Contact>();   
        
        Map<Id,List<Contact>>accConMap = new Map <Id,List<Contact>>();
        List<Account> accContactList = ([select Id,name,(Select Id,lastname from Contacts) from Account where Id IN: accountIds]);  
        
        for(Account acc :accContactList){
            accConMap.put(acc.Id,acc.contacts);
            system.debug(accConMap);
        }
        for(Accounts_Relationship_Map__c accRelationRec: accRelList){
            if(accRelationRec.From_Account__c!=null ){
                if(accConMap.containsKey(accRelationRec.From_Account__c)){
                    for(Contact con : accConMap.get(accRelationRec.From_Account__c)){
                        system.debug('@#@#@#@Con'+con);
                        Contact conObj = con.clone(false,true,false,false);
                        system.debug('@#@#@#@'+conObj);
                        conObj.Parent_Contact__c=con.Id;
                        conObj.AccountId=accRelationRec.To_Account__c;
                        contactCloneList.add(conObj);
                    } 
                }
            }
        }
        if(!contactCloneList.isEmpty()){
            insert contactCloneList;
        }
    }
    public static void AfterDeleteMtd(List <Accounts_Relationship_Map__c> accRelationList){
        set <Id> accIds = new set <Id>();
        for(Accounts_Relationship_Map__c accRelation : accRelationList){
            if(accRelation.To_Account__c!=null){
                accIds.add(accRelation.From_Account__c);
                accIds.add(accRelation.To_Account__c);
            }
        }
        List<Contact> conListAfterDel = New List<Contact>();   
        
        Map<Id,List<Contact>>accConMap = new Map <Id,List<Contact>>();
        List<Account> accConList = ([select Id,name,(Select Id,lastname,Parent_Contact__c from Contacts) from Account where Id IN: accIds]);  
        for(Account acc :accConList){
            accConMap.put(acc.Id,acc.contacts);
            system.debug('@#@#@Delete'+accConMap);
        }
        for(Accounts_Relationship_Map__c accRelMap :accRelationList){
            if(accConMap.containsKey(accRelMap.From_Account__c)){
                List<contact>contactFrom = accConMap.get(accRelMap.From_Account__c);
                
                if(accConMap.containsKey(accRelMap.To_Account__c)){
                    List<contact>contactTo = accConMap.get(accRelMap.To_Account__c);
                    
                    for(contact conFrom : contactFrom){
                        for(contact conTo : contactTo){
                            if(conFrom.Id==conTo.Parent_Contact__c){
                                conListAfterDel.add(conTo);
                            }  
                        }
                    }
                }
            }
        }
        if(!conListAfterDel.isEmpty()){
            delete conListAfterDel;
            system.debug('@#@#Final'+conListAfterDel);
        }
    }
}