trigger UserTrigger on User (after insert) {
     if(trigger.IsAfter){
        if(trigger.IsInsert){
            UserTriggerHelper.afterInsertUser(trigger.new,trigger.newMap);
        }
    }

}