global class BatchClassSyntax implements Database.Batchable <SObject> {
//START METHOD
    global Database.QueryLocator start(Database.BatchableContext bc){
        String Query='Select id,LeadSource from Lead';
        return Database.getQueryLocator(Query);
            }
//EXECUTE METHOD
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        for(Lead l: scope){
            l.LeadSource='DreamForce';
        }
        update scope;
    }
//FINISH METHOD
    global void finish(Database.BatchableContext bc){
        Id job= bc.getJobId();
        System.debug(job);
    }
}

//invoke batch class
//MyBatchClass myBatchObject = new MyBatchClass();
//Id batchId = Database.executeBatch(myBatchObject);
//Id batchId = Database.executeBatch(myBatchObject, 100);
//AsyncApexJob job = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors FROM AsyncApexJob WHERE ID = :batchId ];