trigger scenario3 on Account (before Update) {
    if(trigger.isBefore){
        if(trigger.isUpdate){
            for(Account accRec : Trigger.new){
                Account accOldRec = Trigger.oldMap.get(accRec.Id); // store old value in accOldRec
                if(accRec.Name != accOldRec.Name){
                    accRec.addError('Account Name cannot be chandged once it is created');
                }
            }
        }
    }
}