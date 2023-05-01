trigger DomainContains on Contact (before insert) {
if(trigger.isBefore){
        if(Trigger.isInsert){
            Set<String> accIds=new Set<String>();
            Map<Id,String> emailMap=new Map<Id,String>();
           // Map<Id,String> conEmailMap=new Map<Id,String>();
            
            for(Contact conObj : Trigger.New){
                if(String.isNotEmpty(conObj.AccountId)){
                    emailMap.put(conObj.AccountId,conObj.Email);
                }
            }
            if(!emailMap.isEmpty()){
                List<Domain__C> domList=[SELECT Id,Name,Account_Related__C FROM Domain__C WHERE Account_Related__C In:emailMap.keySet()];
                if(!domList.isEmpty()){
                    for(Domain__C domOn:domList){
                        if(emailMap.containsKey(domOn.Account_Related__C)){
                            String aEmail=emailMap.get(domOn.Account_Related__c);
                            if(!aEmail.containsIgnoreCase(domOn.Name)){
                                accIds.add(domOn.Account_Related__c);
                            }
                        }
                    }
                    if(!accIds.isEmpty()){
                        for(Contact conObj : Trigger.new){
                            if(accIds.contains(conObj.AccountId)){
                                conObj.addError('ERRROR..Coming....');
                            }
                        }
                    }
                }
            }
        }
    }
}