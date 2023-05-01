public class EventRecordCtrl {
    @AuraEnabled//Method to get the List of event List
    public static List<DataWrapper> getAllEvent(){
        List<DataWrapper> DataWrapperList=new List<DataWrapper>();      
        List<Events__c> eventList = [Select Id,Name from Events__c];
        if(!eventList.isEmpty()){
            for(Events__c eventObj : eventList){
                DataWrapper dataWrapperObj=new DataWrapper();
                dataWrapperObj.label=eventObj.name;
                dataWrapperObj.value=eventObj.name;
                dataWrapperObj.eventId=eventObj.ID;
                DataWrapperList.add(dataWrapperObj);
            }
            
        }
        system.debug('@#@# '+eventList);
        System.debug('@@@@'+DataWrapperList);
        return DataWrapperList;
    }
    
    public Class DataWrapper{
        @auraEnabled
        public String label;
        @auraEnabled
        public String value;
        @auraEnabled
        public String eventId;
        
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Question__c> getQuesData(String evtId) {
        System.debug('evtId '+evtId);      
        List <Question__c> quesLst = [select id,Name,Type__c,Events__c,Choice__c from Question__c where Events__c =:evtId];
        system.debug('quesLst '+quesLst);
        return quesLst;
    }
}