@isTest
public class EmailRequired_Test {
    @testSetup
    public static void testSetup(){
        
    }
    @isTest
    public static void EmailRequired_TestMtd(){
        
        Contact cont = new Contact (LastName='test2',Email='');
        insert cont;
    }
}