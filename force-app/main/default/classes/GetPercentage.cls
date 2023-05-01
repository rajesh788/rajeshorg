public class GetPercentage {
    public static void percent (Integer total,integer get) {
        Decimal result=(get/total)*100;
    
    if (result<=36)
    {
        system.debug('Passed with 1 Division');
            } 
    else if(result>35 || result<48 )
    {
        system.debug('Passed with 2nd Division');
            }
    else if (result<48) {
        system.debug('Failed');
            } 
}
}