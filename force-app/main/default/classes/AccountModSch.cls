public class AccountModSch implements schedulable {
    public void execute(SchedulableContext sc){
        AccountModified_Batch accModify = new AccountModified_Batch();
        system.debug('the message '+accModify);
        database.executeBatch(accModify,5);
    }
}
//AccountModified_Batch accModify = new AccountModified_Batch();
      //  system.debug('the message '+accModify);
        // database.executeBatch(accModify,5);