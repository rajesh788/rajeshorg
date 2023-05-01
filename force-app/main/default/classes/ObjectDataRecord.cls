public class ObjectDataRecord {
    
    @AuraEnabled//Method to get the List of All Objects
    public static Map<String, String> getAllObject(){
        
        Map<String,String> returnObjectMap = new Map<String,String>();
        
        //Schema.getGlobalDescribe() => return a Map of type Map<String, Schema.SObjectType>
        Map<String, Schema.SObjectType> objectMap = Schema.getGlobalDescribe();
        
        //get List of all sObject
        List<Schema.SObjectType> objectMapValuesLst = objectMap.Values();
        System.debug('All Objects '+ objectMapValuesLst);
        
        //prepare a Map to send Data from Server to Client Side
        
        for(Schema.SObjectType objType : objectMapValuesLst){
            String key = objType.getDescribe().getName();
            String value = objType.getDescribe().getLabel();
            returnObjectMap.put(key,value);
        }
        System.debug(returnObjectMap);
        if(returnObjectMap != null && returnObjectMap.size() > 0){
            return returnObjectMap;
        }else{
            return null;
        }
    }
    @AuraEnabled //Method to get all the fields of a particular Object
    public static List<FieldsValue> getAllfieldsMtd(String objectName){
        
        List<FieldsValue> allFieldsLst = new List<FieldsValue>();
        
        Map<String, Schema.SObjectType> objectMap = Schema.getGlobalDescribe();
        SObjectType objType = objectMap.get(objectName);
        
        // Map of fields with api name and Api name as value
        Map<String,Schema.SObjectField> objTypeFields = objType.getDescribe().fields.getMap();
        if(!objTypeFields.isEmpty()){
            for (String fieldName: objTypeFields.keySet()) {
                //getting labels of the fields
                String fieldLabel = objTypeFields.get(fieldName).getDescribe().getLabel();
                String fieldApiName = objTypeFields.get(fieldName).getDescribe().getname();
                //allFieldsLst.add(new FieldsValue(fieldName,fieldLabel));
                allFieldsLst.add(new FieldsValue(fieldName,fieldApiName));
            }
        }
        System.debug(allFieldsLst);
        return allFieldsLst;
    }
    public class FieldsValue{
        @AuraEnabled public String label;
        @AuraEnabled public String value;
        public FieldsValue(String label,String value){
            this.label=label;
            this.value=value;
        }
    }
   @AuraEnabled //Method to get all the fields name and query
    public static List<sObject> getfieldsName(String selectFieldOpt,String objectName){
        List<Sobject> varList = new List<Sobject>(); 
        system.debug('@#@# '+selectFieldOpt);
        system.debug('@#@# '+objectName);
        selectFieldOpt=selectFieldOpt.replaceAll('["]','');
        selectFieldOpt=selectFieldOpt.replace('[', '').replace(']', '');
        System.debug(selectFieldOpt);
        String query = 'SELECT Id, ';
        query+= selectFieldOpt;
        query+= ' FROM ' + objectName;
        System.debug('#### '+query);
        varList = Database.query(query);
        system.debug('@#@# '+varList);
        return varList;
    }
     //Class to store the dynamic data and list of related fields
    public class DynamicBindingWrapper{
        @AuraEnabled
        public List<sObject> sObjectData {get; set;}
        @AuraEnabled
        public List<fieldDataWrapper> fieldList {get; set;}
    }
    //Class to store the field information
    public class fieldDataWrapper{
        @AuraEnabled
        public String label {get; set;}
        @AuraEnabled
        public String value {get; set;}
    }
}