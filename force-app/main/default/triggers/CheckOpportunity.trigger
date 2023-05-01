trigger CheckOpportunity on Account (After Insert) {
    if(trigger.isAfter) {
        if(trigger.isInsert) {
           AccountHelper.afterInsertMtd(trigger.new);
        }
    }
}