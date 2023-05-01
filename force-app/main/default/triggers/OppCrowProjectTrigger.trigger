trigger OppCrowProjectTrigger on Opportunity (After Update) {
    if(Trigger.isAfter){
        if(trigger.isUpdate){
            List <Krow_Project__c> kProjectList = new List <Krow_Project__c> ();
            for(Opportunity opp : trigger.new){
                if(opp.StageName =='Signature' && opp.StageName!= trigger.oldMap.get(opp.id).StageName){
                    Krow_Project__c krowRec = new Krow_Project__c ();
                    krowRec.Name = opp.Name;
                    krowRec.Onboarding_type__c = 'Customer Onboarding';
                    krowRec.Opportunity__c = opp.Id;
                    kProjectList.add(krowRec);
                    system.debug('@#@##'+ kProjectList);
                }
            }
            if(!kProjectList.isEmpty()){
                insert kProjectList;
                system.debug('@#@##'+ kProjectList);
            }   
        }
    }

}