public class AccountsContController {
    @AuraEnabled(cacheable=true)    
    public static List<Contact> getContactOfAcc(Id AccIds){
        system.debug('getContactOfAcc');
        List<Contact> contLst = new List <Contact>();
        List <Contact> accLst = [select Id,Name,phone,AccountId from contact where AccountId =: AccIds];
            for(contact con : accLst){
                contLst.add(con);
            }
        system.debug('contLst'+contLst);
        return contLst;
    }
}