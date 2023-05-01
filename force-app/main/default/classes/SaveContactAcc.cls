public class SaveContactAcc {
    @AuraEnabled
        public static void getAccount(string AccConLst){
        system.debug('AccConLst'+AccConLst);
        List<Account> accList = new List<Account>();
        List<data> AccConLstwrrp = (List<data>)System.JSON.deserialize(AccConLst, List<data>.class);
        system.debug('AccConLstwrrp'+AccConLstwrrp);

        for(data dt : AccConLstwrrp){
           Account acc = new Account();
            accList.add(acc);
        }
        system.debug('accList '+accList);
        insert accList ;
        
        
        
        for(data accObj : AccConLstwrrp){
            String data1 = accObj.Account;
            System.debug('---'+data1);
            Map<String,Object> Acc1data = (Map<String,Object>)JSON.deserializeUntyped(data1);
            System.debug('---'+Acc1data);
           // AccConWrapper ex = (AccConWrapper)JSON.deserialize(jsonString, AccConWrapper.class);
           
            
            
            
        
               
           
        }
        System.debug('---'+accList);
        
        
    }
    
    public static  void testing(String JsonData){
        List<data> wrapperdata = (List<data>)System.JSON.deserialize(JsonData, List<data>.class);
        
        System.debug('---'+wrapperdata);
        
    }
    class data{
        public String Account;
        public List<String> contacts;
    }
    public class AccConWrapper{
        public Account AccRecord;
        public List<contact> conRecord;
    }
    public class AccRecord{
        public String Industry;
        public String Title;
        public String Status;
        public String Name;
    }
    public class ConRecord {
        public String FirstName;
        public String LastName;
        public String Email;
        public Integer Phone;
    }
}