trigger OpportunityTaskTrigger on Opportunity (after insert) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            List <Task> taskList = new List <Task>();
            
            List<Activities_Matrix__mdt> preTaskList =[select id,DeveloperName, Label, Sequence__c  from Activities_Matrix__mdt];
            Map<Double,String> taskMap =new map <Double,String>();
            for(Activities_Matrix__mdt mdtTask : preTaskList){
                taskMap.put(mdtTask.Sequence__c,mdtTask.Label);
                system.debug('@#@#@#'+taskMap);
            }
            string subj= taskMap.get(1);	
            for(Opportunity opp : trigger.new){
                taskList.add(new task (subject=subj,WhatId=opp.id,sequence__c=1)); 
            }
            if(!taskList.isEmpty()){
                insert taskList;
            }
        }
    }
}