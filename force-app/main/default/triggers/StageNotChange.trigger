trigger StageNotChange on Opportunity (before Update) {
    if(trigger.isBefore){
        if(trigger.isUpdate){
            for(Opportunity opp: trigger.new){
                if(opp.StageName == 'Closed Lost' && trigger.oldMap.get(opp.Id).stageName=='Qualification'){
                    opp.addError('Do not update stage name from qualification to closed Lost');
                }
            }
        }
    }
}