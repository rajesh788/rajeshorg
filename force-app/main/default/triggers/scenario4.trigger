trigger scenario4 on Account (before delete) {
    if(trigger.isBefore){
        if(trigger.isDelete){
            for(Account accOld: Trigger.Old){
                if(accOld.Active__c =='Yes'){
                    accOld.addError('You cannot delete an active account');
                }
            }
        }
    }
}