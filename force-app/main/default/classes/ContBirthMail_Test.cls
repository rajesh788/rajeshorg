@isTest
public class ContBirthMail_Test {
    @testSetup
    static void setup() {
        List<contact> conLst = new List<contact>();
        contact con = new contact();
        con.lastname= 'test';
        con.Birthdate = system.today();
        con.Email= 'abc@gmail.com';
        conLst.add(con);
        insert conLst;
    }
     @isTest
    static void test() {
        Test.startTest();
        ContBirthMail conObj = new ContBirthMail();
        Id batchId = Database.executeBatch(conObj);
        Test.stopTest();
    }
}