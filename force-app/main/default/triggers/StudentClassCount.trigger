trigger StudentClassCount on student__c (Before insert) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            StudentClassCountHelper.BeforeInsertError(trigger.new);
            StudentDefaulterCaseHelper.BeforeInsertCaseMtd(trigger.new);
        }
    }
}