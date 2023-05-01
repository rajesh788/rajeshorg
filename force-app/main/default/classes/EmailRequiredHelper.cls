public class EmailRequiredHelper {
    
    public static void beforeMtd(List<Contact>conList){
        for (Contact con : conList) {
            if(string.isEmpty(con.Email)) {
                con.Email.addError('Email Address Required');
            }
        }
    }
}