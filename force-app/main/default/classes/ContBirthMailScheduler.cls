public class ContBirthMailScheduler implements schedulable {
    public void execute(SchedulableContext sc){
        ContBirthMail bdayMailToCon = new ContBirthMail();
        system.debug('the message '+bdayMailToCon);
        database.executeBatch(bdayMailToCon,2);
        
    }
}
//ContBirthMail bdayMailToCon = new ContBirthMail();
     //   system.debug('the message '+bdayMailToCon);
       // database.executeBatch(bdayMailToCon,2);