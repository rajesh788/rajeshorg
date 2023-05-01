trigger TaskEvent on Task (after Update) {
    if(trigger.isAfter){
        if(trigger.isUpdate){
            
            Set<Id> completedTasks = new Set<Id>();
            Set<Id> OpportunityIds = new Set<Id>();
            
            List<Activities_Matrix__mdt> preTaskList =[select id,DeveloperName, Label, Sequence__c  from Activities_Matrix__mdt];
            Map<Double,String> taskMap =new map <Double,String>();
            for(Activities_Matrix__mdt mdtTask : preTaskList){
                taskMap.put(mdtTask.Sequence__c,mdtTask.Label);
            }
            
            for(Task task: Trigger.New){
                Decimal sequence = task.sequence__c;
                sequence++;
                
                Task oldTask = Trigger.oldMap.get(task.Id);
                if (task.Status == 'Completed' ){
                    completedTasks.add(task.Id);
                    OpportunityIds.add(task.WhatId);
                }
            }
            if (!OpportunityIds.isEmpty()){
                Map<id,Opportunity> oppMap= new Map <id,Opportunity>([select id,name from Opportunity where Id in : OpportunityIds]);
                
                List<Task> newTasks = new List<Task>();
                
                for(Id id: completedTasks) {
                    Task taskRec = Trigger.newMap.get(id);
                    Opportunity opp = oppMap.get(taskRec.WhatId);
                    
                    if(opp == null){
                        continue;
                    }
                    newTasks.add(new task(subject=taskMap.get(taskRec.Sequence__c+1),WhatId=opp.id,Sequence__c=taskRec.Sequence__c+1)); 
                }
                if (!newTasks.isEmpty()) {
                    insert newTasks;
                }
            }
        }
    }
}