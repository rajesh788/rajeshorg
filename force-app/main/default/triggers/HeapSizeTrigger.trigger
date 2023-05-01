trigger HeapSizeTrigger on For_Heap_Size__c (before update) {
    if(trigger.isBefore){
        if(trigger.isupdate){
            System.debug('Contact before:'+limits.getHeapSize());
            Map<Id,For_Heap_Size__c> sizeObjMap = new Map <Id,For_Heap_Size__c> ();
            List <For_Heap_Size__c> RecList = [Select Id,Name,First__c, Second__c, Third__c, Fourth__c from For_Heap_Size__c ];
            for(For_Heap_Size__c hSizeRec : RecList){
                sizeObjMap.put(hSizeRec.id,hSizeRec);
                system.debug('sizeObjMap '+sizeObjMap);
                System.debug('Contact after:'+limits.getHeapSize());
            }
            string jsonstringMap = JSON.serialize(sizeObjMap);
            system.debug('jsonstringMap '+jsonstringMap);
            System.debug('parameters before:'+limits.getHeapSize());
            Map<String, SObject> parameters = new Map<String, SObject>();
            parameters = (Map<String, SObject>) JSON.deserialize(jsonstringMap, Map<String, SObject>.class);
            system.debug('parameters '+parameters);
            System.debug('parameters after:'+limits.getHeapSize());
            
        }
    }
}