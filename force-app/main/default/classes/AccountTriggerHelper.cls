/*Trigger- When an Account is updated and the Website is filled in, update all the Profile field on all Contacts to:
Profile = Website + ‘/’ + First Letter of First Name + Last Name*/

public class AccountTriggerHelper {
    public static void AfterUpdateMtd(List <Account> accountList ){
        Map <Id,String> accMap = new Map <Id,String> ();
        for(Account acc : accountList){
            if(acc.Website != null){
                accMap.put(acc.Id,acc.Website);
            }
        }
        if(!accMap.isEmpty()){
            List <Contact> conList = [select id,FirstName,LastName,Profile__c,AccountId from contact where AccountId In : accMap.keySet()];
            for(Contact con : conList){
                string fName = con.FirstName.subString(0,1);
                string lName = con.LastName;
                if(accMap.containskey(con.AccountId)){
                    system.debug('acc Id '+con.AccountId);
                    String websiteValue = accMap.get(con.AccountId);
                    con.Profile__c = websiteValue +' '+fName+' '+lName ;
                    system.debug('websiteValue '+websiteValue);
                    
                    
                    
                }
            }
            if(!conList.isEmpty()){
                update conList;
            }
        } 
    }
    /* Trigger - When a Billing Address is modified, get the new Postal Code. Then check which Contacts on the Account are outside that Postal Code.
    If 1 or more Contacts are outside of the Postal Code, mark Out_of_Zip as TRUE.*/

    public static void AfterUpdateZipMtd(List <Account> acctList,Map <Id,Account> oldMap ){
        Boolean isZipCode = false;
        Map <Id,String> accMap = new Map <Id,String> ();
        for(Account acc : acctList){
            Account oldAccount = oldMap.get(acc.Id);
            if(acc.BillingPostalCode != oldAccount.BillingPostalCode) {
                accMap.put(acc.Id,acc.BillingPostalCode);
            }
        }
        if(!accMap.isEmpty()){
            List <Contact> conList = [select id,MailingPostalCode,AccountId from contact where AccountId In: accMap.KeySet()];
            for(Contact con : conList){
                if(accMap.containskey(con.AccountId)){
                    string zipCode = accMap.get(con.AccountId);
                    system.debug('zipCode '+zipCode);
                    if(con.MailingPostalCode != zipCode){
                        isZipCode = true;
                    }
                    else{
                        isZipCode = false;
                    }
                }
            }
        }
        //mark Out_of_Zip as TRUE
        if(isZipCode = true){
            List <Account> accList = [select Id,Out_of_Zip__c from account where Id In: accMap.KeySet()];
            for(Account accObj : accList){
                accObj.Out_of_Zip__c = true;
            }
            update accList;
        }
    }
    public static void conEmailUpdate(List<Account>accNewLst,Map<Id,Account>oldMap){
        Map<Id,String>accMap = new Map<Id,String>();
        for(Account acc : accNewLst){
            if((acc.Email__c!=null)&&(acc.Email__c!=oldMap.get(acc.Id).Email__c)){
                accMap.put(acc.Id,acc.Email__c);
            }
            if(!accMap.isEmpty()){
                List<Contact> conLst =[Select id,Email,AccountId from Contact where AccountId in : accMap.KeySet()];
                for(Contact con : conLst){
                    if(accMap.containsKey(con.AccountId)){
                        con.Email = accMap.get(con.AccountId);
                    }
                }
                update conLst;
            }
        }
    }
}