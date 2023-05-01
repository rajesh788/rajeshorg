trigger AccountTrigger on Account (After Update) {
    if(trigger.isAfter){
        if(trigger.isUpdate){
            AccountTriggerHelper.AfterUpdateMtd(trigger.new);
            AccountTriggerHelper.AfterUpdateZipMtd(trigger.new,trigger.oldMap);
            AccountTriggerHelper.conEmailUpdate(trigger.new,trigger.oldMap);
        }
    }
}