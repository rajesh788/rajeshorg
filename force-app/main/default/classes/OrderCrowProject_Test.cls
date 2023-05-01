@isTest
public class OrderCrowProject_Test {
    @testSetup
    public static void AccountRelationMap_TestSetup(){
        // List <Account> accLst= new List <Account>();
        Account acc = new Account ();
        acc.Name='test';
        insert acc; 
        
        Order orderObj = new Order ();
        orderObj.Status='completed';
        orderObj.AccountId=acc.id;
        orderObj.EffectiveDate=system.today();
        insert orderObj;
        
      
        
    }
    @isTest
    public static void OrderCrowProject_TestMtd(){
        
        
        
        
        
    }
}