trigger DomainMatch on Contact (before insert) {
    If(trigger.isBefore){
        if(trigger.isInsert){
            set<string> accIds = New set<string>();
            Map<Id,String> DomMap = new Map<Id,String>();
            Map<Id,String> conEmailMap=new Map<Id,String>();
            
            for(contact conObj : trigger.new){
                if (String.isNotEmpty(conObj.AccountId)) {
                    DomMap.put(conObj.AccountId,conObj.Email);
                }   
            }
            if(!DomMap.isEmpty()){
                List<Domain__C> domList=[SELECT Id,Name,Account_Related__C FROM Domain__C WHERE Account_Related__C In:DomMap.keySet()];
                if(!domList.isEmpty()){
                    for(Domain__C domObj : domList){
                        If(DomMap.containsKey(domObj.Account_Related__c)){
                            string mailAcc=DomMap.get(domObj.Account_Related__c);
                            if(!mailAcc.containsIgnoreCase(domObj.Name)){
                                accIds.add(domObj.Account_Related__c);
                            }
                        }
                        if(!accIds.isEmpty()){
                            For(contact conObj:trigger.new){
                                if(accIds.contains(conObj.AccountId)){
                                    conObj.addError('Email Domain Not Matched');
                                }
                            }
                        }
                    }
                }  
            }
        }
        
    }  
}