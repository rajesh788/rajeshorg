public class WrapperAccCon {
    Public List <accountConWrapper> accContWrap {get;set;}
    public WrapperAccCon(){
        getAllRec();
    }
    
    Public Static Void getAllRec(){
        List <accountConWrapper> accContWrap = new List <accountConWrapper> ();
        List <Account> accList = [Select Id,Name,phone,(select Id,LastName from contacts) from Account where Id ='0015j00000ttjvQAAQ'];
        String getLastName = '';
        String AvlMsg;
        Integer phoneDigit;
        for(Account acc : accList){
            for(Contact con : acc.Contacts){
                getLastName += con.LastName + ',';
            }
            if(acc.Phone==null){
                AvlMsg = 'Not Available';
            }else{
                AvlMsg = 'Available';
            }
             phoneDigit = acc.phone.Length();
            accContWrap.add(new accountConWrapper(acc,getLastName,AvlMsg,phoneDigit));
            system.debug('accContWrap '+accContWrap);
        }
    }
    
    public class accountConWrapper {
        Public Account acc {get;set;}
        string conName {get;set;}
        string Msg {get;set;}
        Integer phnDgt {get;set;}
        
        public accountConWrapper (Account accObj,string conNm,string AvlMsg,Integer phoneDigit ){
            acc =  accObj;
            conName = conNm;
            Msg = AvlMsg;
            phnDgt = phoneDigit;
        }
    }
    
}