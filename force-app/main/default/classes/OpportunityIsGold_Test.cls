@isTest
public class OpportunityIsGold_Test {
    @TestSetup
    public static void testSetup(){
        
    }
    @istest
    public static void testSetupMtd(){
        
        Account acc = new Account(name='Test Account');
        insert acc;
        
        opportunity opp = new opportunity ();
        opp.StageName = 'Closed';
        opp.CloseDate = system.today();
        opp.AccountId = acc.id;
        opp.Name = 'Test Opportunity Triggers';
        opp.Amount = 20000;
        insert opp;
        
        acc.is_gold__c = true;
        update acc;
          
        System.assertEquals(true ,acc.is_gold__c);
    }
}