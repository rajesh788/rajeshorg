trigger AccountDefaultContactTrigger on Account (After insert) {
    if(Trigger.isAfter){
        if(trigger.isInsert){
            Set <Id> accIdset = new Set <Id>();
            for(Account acc : trigger.new){
                Contact con = new Contact ();
                con.AccountId = acc.Id;
                con.FirstName = 'Info';
                con.LastName =  'Default';
                con.Email = 'info@crmlanding.in';
                insert con;
                accIdset.add(acc.Id);
            }
            if(!accIdset.isEmpty()){
                List <Account>  accLst = new List <Account> (); // Only_Default_Contact__c value true
                for(Id accId : accIdset){
                    Account acc1 = new Account ();
                    acc1.Id = accId;
                    acc1.Only_Default_Contact__c = true;
                    accLst.add(acc1);
                    system.debug('accLst '+accLst);
                }
                Update accLst;
            }
  
        }
    }
}