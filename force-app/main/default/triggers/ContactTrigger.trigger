trigger ContactTrigger on Contact (before Insert,after insert,after update,before update ) {
    if(trigger.isAfter && trigger.isInsert){
        ContactTriggerHelper.afterInsert(Trigger.New);
        ContactTriggerHelper.conPrimary(Trigger.New);
    }
    if(trigger.isAfter && trigger.isUpdate){
        ContactTriggerHelper.afterUpdate(Trigger.New,Trigger.OldMap);
    }
     if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        ContactTriggerHelper.emailDuplicateError(Trigger.New,Trigger.OldMap);
    }
    
}