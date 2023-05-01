@isTest
public class AccountMark_Test {
    @testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        Account acc = new Account();
        acc.Name= 'test';
        insert acc;
        Test.setCreatedDate(acc.Id,  system.today().addDays(180));
     
        Account acc1 = new Account();
        acc1.Name= 'test2';
        insert acc1;
        Test.setCreatedDate(acc1.Id, system.today().addDays(-90));
      
    }
    @isTest
    static void test() {
        Test.startTest();
        List <Account> accLst = [select id,CreatedDate from Account];
        system.debug('@#@#'+accLst.size());
        AccountMark accObj = new AccountMark(accLst[0].CreatedDate,accLst[1].CreatedDate);
        Id batchId = Database.executeBatch(accObj);
        Test.stopTest();
    }
}