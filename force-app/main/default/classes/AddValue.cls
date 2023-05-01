public class AddValue {
    public static void add (integer A) {
        if (A>1000) {
            system.debug('update value'+(A+100));
        }
        else if (A>500 || A<1000) {
            system.debug('update value'+(A+50));
        }
        else {
            system.debug('update value'+(A+10));
            
        }
        
    }

}