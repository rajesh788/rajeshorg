public class MaxValue {
    public static void maximum (integer a,integer b ,integer c) {
        if( a >= b && a >= c)
        {  
            System.debug('The largest number'+a);
        }
        else if (b >= a && b >= c){
            
            System.debug('The largest number'+b);
        }
        else{
            
            System.debug('The largest number'+c);
        }
    }
}