public class OpportunityConRoleController {
    @AuraEnabled
    public static Account getAccount(Id accountId) {
        // Perform isAccessible() checks here
        return [SELECT Name, BillingCity, BillingState FROM Account WHERE Id = :accountId];
    }
    
    @AuraEnabled
    public static Opportunity saveOpportunityWithAccount(Opportunity opportunity, Id accountId) {
        // Perform isAccessible() and isUpdateable() checks here
        opportunity.AccountId = accountId;
        insert opportunity;
        return opportunity;
    }
    @AuraEnabled
    public static string getContactName(string ContactRecordID) {
        system.debug('ContactRecordID'+ContactRecordID);
        return Null;
    }
    @AuraEnabled
    public static List<Contact> getContactRole(String searchKey) {
        String contName= searchKey;
        System.debug('Id'+searchKey);
        return [select Id,Name from contact WHERE id =: contName];
    }
     @AuraEnabled
    public static string findAmt(String am) {
        String amt = am;
        System.debug('Id'+am);
        return amt ;
    }
    
    
}