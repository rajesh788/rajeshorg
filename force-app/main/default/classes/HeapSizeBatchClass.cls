global class HeapSizeBatchClass implements Database.Batchable <SObject> {
    //START METHOD
    global Database.QueryLocator start(Database.BatchableContext bc){
        String Query='Select Id,Name,First__c, Second__c, Third__c, Fourth__c from For_Heap_Size__c';
        return Database.getQueryLocator(Query);
    }
    //EXECUTE METHOD
    global void execute(Database.BatchableContext bc, List<For_Heap_Size__c> scopeList){
        system.debug('@@@'+scopeList);
        system.debug('update Acc Record'+scopeList.size());
        Map<Id,For_Heap_Size__c> sizeObjMap = new Map <Id,For_Heap_Size__c> ();
        for(For_Heap_Size__c objLst : scopeList){
                sizeObjMap.put(objLst.Id,objLst);
        }
        system.debug('jsonstringMap '+limits.getHeapSize());
        
         
        string jsonstringMap = JSON.serialize(sizeObjMap);
        system.debug('jsonstringMap after '+limits.getHeapSize());
       
       
        
        System.debug('parameters before:'+limits.getHeapSize());
        Map<String, SObject> parameters = new Map<String, SObject>();
        parameters = (Map<String, SObject>) JSON.deserialize(jsonstringMap, Map<String, SObject>.class);
        system.debug('parameters '+parameters);
        System.debug('parameters after:'+limits.getHeapSize());
    }
    //FINISH METHOD
    global void finish(Database.BatchableContext bc){
        
    }
}
/*HeapSizeBatchClass accModify = new HeapSizeBatchClass();
        system.debug('the message '+accModify);
        database.executeBatch(accModify,200); */