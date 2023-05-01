public class MinValue {
    public static void minimum (integer a,integer b ,integer c) {
        if( a <= b && a <= c)
        {  
            System.debug('The lowest number'+a);
        }
        else if (b <= a && b <= c){
            
            System.debug('The lowest number'+b);
        }
        else{
            
            System.debug('The lowest number'+c);
        }
        
    }
    
}