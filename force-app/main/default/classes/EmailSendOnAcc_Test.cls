@isTest
public class EmailSendOnAcc_Test {
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
        AccountModified_Batch accModObj = new AccountModified_Batch();
        Id batchId = Database.executeBatch(accModObj);
        Test.stopTest();
    }
}