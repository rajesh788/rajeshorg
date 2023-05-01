trigger CaseClosedError on Case (before insert,before update) {
    if(trigger.isUpdate){
        Map <Id,Case> caseMap = new Map <Id,Case> ();
        for(Case caseObj : trigger.new){
            case OldCase = trigger.oldMap.get(caseObj.id);
            if(caseObj.Status=='Escalated' && OldCase.Status!='Escalated'){
                if(caseObj.ContactId!=null){
                    caseMap.put(caseObj.contactId,caseObj);
                }
            }
            List <Hire_form__c> hireFormList = ([select id,Candidate__c,Status__c from Hire_form__c where candidate__c In :caseMap.keyset()]);
            for(Hire_form__c hire : hireFormList){
                if(caseMap.containsKey(hire.Candidate__c)){
                    if(hire.Status__c!='Completed'){
                        case caseId = caseMap.get(hire.Candidate__c);
                        caseId.addError('Please complete the form status before close the case');
                    }
                }
            }
        }
    }
}