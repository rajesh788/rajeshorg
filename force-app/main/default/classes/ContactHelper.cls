public class ContactHelper {
    public static void afterInserMtd (List<Contact>conList){
        set<Id>accIds=new set<Id>();
            for(contact con:conList){
                if(con.Phone!=null && con.AccountId!=null){
                    accIds.add(con.AccountId);
                }
            }
            List<Account>accList=new List<Account>([Select Id,phone from Account where Id IN:accIds]);
                for(contact con:conList){
                    for (Account acc: accList){
                        acc.phone = con.Phone;
                    }
            }
           update accList; 
    }

}