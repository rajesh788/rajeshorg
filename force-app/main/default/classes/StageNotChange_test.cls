@istest
public class StageNotChange_test {
    @testSetup
    public static void testSetup(){
        
    }
    @istest
    public static void StageNotChange_testMtd(){
        opportunity opp = new opportunity(Name='test',StageName='Qualification',CloseDate = system.today());
        insert opp;
        opp.StageName ='Closed Lost';
        update opp;
    }
}