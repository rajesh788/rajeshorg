trigger OrderCrowProjectTrigger on Order (After Update) {
    if(trigger.isAfter){
        if(trigger.isUpdate){
            OrderCrowProjectHelper.AfterUpdateMtd(trigger.new,trigger.oldMap);
           
        }
    }
}