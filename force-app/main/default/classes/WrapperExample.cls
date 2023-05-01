public class WrapperExample {
    
    Public List <AccConOppWrapperLst> Lst {get;set;}
    public WrapperExample(){
        getRecord();
    }
    Public Void getRecord(){
        //List <wrapperLst> 
        List <AccConOppWrapperLst> wrapperLst = new List <AccConOppWrapperLst> ();
        List <Account> accList = [Select id,name from Account];
        Account accRec = new Account ();
        for(Account acc : accList){
            accRec = acc;
        }
        List <Contact> conList = [Select id,lastname from Contact];
        Contact conRec = new Contact ();
        for(Contact con : conList){
            conRec = con;
        }
       
        system.debug('wrapperLst '+wrapperLst);
    }
    public class AccConOppWrapperLst {
        Public  Account accObj {get;set;}
        Public Contact conObj {get;set;}
        Public  Opportunity oppObj {get;set;}
        
        public AccConOppWrapperLst (Account accName,Contact ConLastnm,Opportunity oppAmt){
            accObj = accName;
            conObj =  ConLastnm;
            oppObj = oppAmt;
            //System.debug('Decimal : '+ wrapperLst.oppObj);
        }
    }
    
    
   
    
}