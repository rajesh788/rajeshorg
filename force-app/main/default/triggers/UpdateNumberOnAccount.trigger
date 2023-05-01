trigger UpdateNumberOnAccount on Contact (After insert) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            ContactHelper.afterInserMtd(trigger.new);
        }
    }
}