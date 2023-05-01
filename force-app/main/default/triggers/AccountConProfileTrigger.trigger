trigger AccountConProfileTrigger on Account (After Update) {
    if(trigger.isAfter){
        if(trigger.isUpdate){
            Map <Id,String> accMap = new Map <Id,String> ();
            for(Account acc : trigger.new){
                if(acc.Website != null){
                    accMap.put(acc.Id,acc.Website);
                }
            }
            if(!accMap.isEmpty()){
                List <Contact> conList = [select id,FirstName,LastName,Profile__c,AccountId from contact where AccountId In : accMap.keySet()];
                
                if(!conList.isEmpty()){
                    for(Contact con : conList){
                        string fName = con.FirstName.subString(0,1);
                        string lName = con.LastName;
                        if(accMap.containskey(con.AccountId)){
                            system.debug('acc Id '+con.AccountId);
                            String websiteValue = accMap.get(con.AccountId);
                            con.Profile__c = websiteValue +' '+fName+' '+lName ;
                            system.debug('websiteValue '+websiteValue);
                        }
                    }
                    update conList;
                }
            } 
        }
    }
}