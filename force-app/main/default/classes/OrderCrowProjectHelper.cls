public class OrderCrowProjectHelper {
    public static void AfterUpdateMtd(List <Order> orderLst,Map<Id,Order>OldMap){
        
         List <Krow_Project__c> kProjectList = new List <Krow_Project__c> ();
            Map <Id,Order> OppOrderMap = new Map <Id,Order> ();
            for(Order orderObj : orderLst){
                if(orderObj.Status=='completed' && orderObj.Status!=oldmap.get(orderObj.id).Status){
                    Krow_Project__c krowRec = new Krow_Project__c ();
                    krowRec.Name = orderObj.Name;
                    krowRec.Onboarding_type__c = 'Installation';
                    krowRec.Order__c = orderObj.Id;
                    kProjectList.add(krowRec);
                    system.debug('@#@##'+ kProjectList);	
                }
                if(orderObj.Status=='completed' && orderObj.Status!=oldmap.get(orderObj.Id).Status){
                    if(orderObj.OpportunityId!=null){
                        OppOrderMap.put(orderObj.OpportunityId,orderObj);
                    }
                }
            }
            if(!kProjectList.isEmpty()){
                insert kProjectList;
                
                List <Krow_Task__c> taskNewRecLst = new List <Krow_Task__c> ();
                List <Krow_Task__c> krowTaskList = [select id,name from Krow_Task__c where Krow_Project__r.isTemplateKrow__c = true];
                
                for(Krow_Project__c krowRec  : kProjectList){
                    for(Krow_Task__c taskObj : krowTaskList){
                    	Krow_Task__c newTaskObj = new Krow_Task__c();
                        newTaskObj.Name = taskObj.Name;
                        newTaskObj.Krow_Project__c = krowRec.Id;
                        taskNewRecLst.add(newTaskObj);
                    }
                }
                if(!taskNewRecLst.isEmpty()){
                    insert taskNewRecLst;
                }
            }
            List <Opportunity> oppList = [select Id,name,StageName,(select id,Status from orders) from Opportunity where Id In :OppOrderMap.keyset()];
            for(Opportunity oppObj : oppList){
                if(OppOrderMap.containsKey(oppObj.Id)){
                    if(oppObj.StageName!='Signature'){
                        Order orderIds = OppOrderMap.get(oppObj.Id);
                        orderIds.addError('Do not allow to mark the order status to completed if opportunity stage is not Signature.');
                    }
                }
            }
    }

}