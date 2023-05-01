trigger quoteTrigger on Quote (before Delete) {
    if(Trigger.isDelete){
     // TriggerDispatcher.run(new quoteTriggerHandler(), 'quoteTrigger');
    }
}