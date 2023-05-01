@isTest
public class AccountModSch_Test {
    @isTest
     static  void testScheduledJob() {
        SchedulableContext sc = null;
        AccountModSch accModify = new AccountModSch();
        accModify.execute(sc);
    }
}