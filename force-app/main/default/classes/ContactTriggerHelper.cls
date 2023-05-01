public class ContactTriggerHelper{
    public static void afterInsert(List<Contact>conNewLst){
        Set<Id>conAccIdSet = new Set<Id>();
        for(Contact con : conNewLst){
            if(con.AccountId!=null){
                conAccIdSet.add(con.AccountId);
            }
        }
        if(!conAccIdSet.isEmpty()){
            accFieldUpdateMtd(conAccIdSet);
        }
    }
    public static void afterUpdate(List<Contact>conNewLst,Map<Id,Contact>oldmap){
        Set<Id>conAccIdSet = new Set<Id>();
        for(Contact con : conNewLst){
            if((con.AccountId!=null)&&(oldmap.get(con.Id).AccountId)==null){
                conAccIdSet.add(con.AccountId);
            }
            else if((con.AccountId==null)&&(oldmap.get(con.Id).AccountId)!=null){
                conAccIdSet.add(oldmap.get(con.Id).AccountId);
            }
            else if((con.AccountId!=null)&&((oldmap.get(con.Id).AccountId)!=null)&&(con.AccountId!=(oldmap.get(con.Id).AccountId))){
                conAccIdSet.add(con.AccountId);
                conAccIdSet.add(oldmap.get(con.Id).AccountId);
            }
        }
        if(!conAccIdSet.isEmpty()){
            accFieldUpdateMtd(conAccIdSet);
        }
    }
    public static void accFieldUpdateMtd(Set<Id>accIdSet){
        List <Account> accLst = [Select Id,Number_Of_Contact__c,(Select id,LastName from Contacts) from Account where Id in :accIdSet];
        for(Account acc : accLst){
            List<Contact> conLst = acc.Contacts;
            acc.Number_Of_Contact__c = conLst.Size();
        }
        Update accLst;
    }
    public static void emailDuplicateError(List<Contact>conLst,Map<Id,Contact>oldMap){
        Set<String> emailSet = new Set <String>();
        for(contact con : conLst){
            if(con.Email!=null){
                if(oldMap == null || con.Email!=oldMap.get(con.Id).Email){
                    emailSet.add(con.Email);
                }
            }
        }
        if(!emailSet.isEmpty()){
            Set<String> emailIdSet = new Set <String>();
            List<Contact>contactLst = [select id,Email from Contact where Email In : emailSet];
            for(Contact con : contactLst){
                if(con.Email!=null){
                    emailIdSet.add(con.Email);
                }
            }
            if(!emailIdSet.isEmpty()){
                for(Contact con : conLst){
                    if(emailIdSet.contains(con.Email)){
                        con.addError('Email Id already Exist');
                    }
                }
            }
        }
    }
    public static void conPrimary(List<Contact>conNewLst){
        Map<Id,String> conMap = new Map <Id,String>();
        for(Contact con : conNewLst){
            if(con.Status__c=='Primary' && con.AccountId!=null && con.Email!=null){
                conMap.put(con.AccountId,con.Email);
            }
        }
        if(!conMap.isEmpty()){
            List<Account> accLst = [Select Id,Email__c from Account where Id in : conMap.KeySet()];
            for(Account acc : accLst){
                if(conMap.ContainsKey(acc.Id)){
                    acc.Email__c = conMap.get(acc.Id);
                }
            }
            update accLst;
        }
        
    }
}