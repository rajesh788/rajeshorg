@isTest
public class AccountTriggerTest {
    @TestSetup
    public static void testSetup(){
        
        
        
    }
    @istest
    public static void testSetupMtd(){
        List<Account>  accountList = new  List<Account>();
        Account testAccount = new Account();
        testAccount.Name='Test Account';
        testAccount.Phone = '9414171490';
        testAccount.Website = 'www.google.com';
        testAccount.BillingPostalCode ='123456';
        insert testAccount;
        
        Contact cont = new Contact();
        cont.Accountid= testAccount.id;
        cont.FirstName='F';
        cont.LastName='Last';
        cont.Profile__c = 'www.google.com F Last';
        insert cont;
        
        accountList.add(testAccount);
       
        AccountTriggerHelper.AfterUpdateMtd(accountList);
        
        
    }
}