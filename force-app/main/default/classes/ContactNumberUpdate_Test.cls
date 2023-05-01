@isTest
public class ContactNumberUpdate_Test {
    @TestSetup
    public static void testSetup(){
        Account acc = new Account(Name='test');
        insert acc;
    }
    @isTest
    public static void ContactNumberUpdate_TestMtd(){
        Account acc = [select id from Account where Name='test'];
        Contact con = new Contact (LastName='test',Phone='123456',AccountId=acc.Id,Email='rahjbjb@gmail.com');
        insert con;
    }
    
}