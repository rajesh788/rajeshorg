@isTest
public class AccountRelationMap_Test {
    @TestSetup
    public static void AccountRelationMap_TestSetup(){
        Account acc = new Account (Name='Ajmer');
        insert acc;
        contact con = new contact(LastName='Test',AccountId=acc.Id);
        insert con;
        Account acc2 = new Account (Name='jaipur');
        insert acc2;
        contact con1 = new contact(LastName='Test22',AccountId=acc2.Id);
        insert con1;
    }
    @isTest
    public static void AccountRelationMap_TestMtd(){
        Account acc = [select id from Account where Name='Ajmer'];
        Account acc2 = [select id from Account where Name='jaipur'];
        Accounts_Relationship_Map__c accRelmap = New Accounts_Relationship_Map__c (Name='testMap',From_Account__c=acc.Id,To_Account__c=acc2.Id);
        insert accRelmap; 
        
        Accounts_Relationship_Map__c accRelmap2 = New Accounts_Relationship_Map__c (Name='testMap12',From_Account__c=acc.Id,To_Account__c=acc2.Id);
        insert accRelmap2;
        Delete accRelmap2;
        
    }
}