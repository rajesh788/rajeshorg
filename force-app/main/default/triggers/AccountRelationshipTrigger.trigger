trigger AccountRelationshipTrigger on Accounts_Relationship_Map__c (After Insert,After Delete) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            AccountRelationMapHelper.AfterInsertMtd(trigger.new);
        }
        if(trigger.isdelete){
           AccountRelationMapHelper.AfterDeleteMtd(trigger.old);
        }
    }
}