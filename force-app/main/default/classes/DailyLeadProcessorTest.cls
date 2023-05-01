@isTest
public class DailyLeadProcessorTest{

    static testMethod void testMethod1() 
    {
                Test.startTest();
        
        List<Lead> lstLead = new List<Lead>();
        for(Integer i=0 ;i <200;i++)
        {
            Lead led = new Lead();
            led.FirstName ='FirstName';
            led.LastName ='LastName'+i;
            led.Company ='demo'+i;
            lstLead.add(led);
        }
        
        insert lstLead;
        
        DailyLeadProcessor ab = new DailyLeadProcessor();
         String jobId = System.schedule('jobName','0 5 * * * ? ' ,ab) ;
        
   
        Test.stopTest();
    }
}