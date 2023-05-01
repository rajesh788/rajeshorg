public class quoteTriggerHandler implements TriggerInterface {
    
    
    public static void beforeDelete(List<sObject> oldRecordsList , Map<Id, sObject> oldRecordsMap){
        quoteTriggerHelper.beforeDeleteMtd ((List<sObject>)oldRecordsList);
    }
    
    public static void beforeInsert(List<sObject> newRecordsList){
        
    }
    
    public static void afterInsert(List<sObject> newRecordsList , Map<Id, sObject> newRecordsMap){
        
    }
    
    public static void beforeUpdate(Map<Id, sObject> newRecordsMap, Map<Id, sObject> oldRecordsMap){
        
    }
    
    public static void afterUpdate(Map<Id, sObject> newRecordsMap,  Map<Id, sObject> oldRecordsMap){
        
    }
    
    
    public static void afterDelete(Map<Id, sObject> oldRecordsMap){
        
    }
    
    public static void afterUnDelete(List<sObject> newRecordsList , Map<Id, sObject> newRecordsMap) {
        
    }
    
}