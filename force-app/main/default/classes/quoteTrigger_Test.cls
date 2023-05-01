@isTest
public class quoteTrigger_Test {
    
    static testMethod void testMethod1() 
    {
        Account acc = new Account (name='ABC');
        insert acc;
        
        Opportunity opp= new Opportunity ();
        opp.name= 'Testopp';
        Opp.Accountid= acc.id;
        opp.CloseDate= date.today();
        opp.StageName= 'Qualification';
        insert opp;
        
        Quote q= new Quote ();
        q.Name= 'Testq';
        q.OpportunityId= Opp.id;
        q.BillingStreet= '123';
        q.BillingCity= 'City';
        q.BillingPostalCode= '12345';
        insert q;
        delete q;
        
        List<Quote> qt = [select id from Quote];//Retrive the record
        integer i = qt.size();
        system.assertEquals(0,i);//Test that the record is delete
    }
}