@isTest
public class AccountModified_Batch_Test {
@testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        Account acc = new Account();
        acc.Name= 'test';
        acc.Email_Address__c= 'ab@gmail.com';
        accounts.add(acc);
        insert accounts;
}
     @isTest
    static void test() {
        Test.startTest();
        AccountMark accObj = new AccountMark(system.today(),system.today());
        Id batchId = Database.executeBatch(accObj);
        Test.stopTest();
    }
}