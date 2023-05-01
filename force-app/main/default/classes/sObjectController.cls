global class sObjectController {
   @Auraenabled
    public static List<string> getObjects()
    {
        List<string> sObjectList = new List<string>();
        for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
            String objName = objTyp.getDescribe().getName();
            sObjectList.add(objName);
        }
        System.debug(sObjectList);
        return sObjectList;
    }
    @Auraenabled(cacheable=true)
    public static List<FieldWrap> getFields(string objectName)
    {
        Map<String, Schema.SObjectType> objectMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType ctype = objectMap.get(objectName); 
        Map<String, Schema.SobjectField> objTypeFields = ctype.getDescribe().fields.getMap();   
        List<FieldWrap> allFieldsLst = new List<FieldWrap>();
        for(String fieldName: objTypeFields.keySet()) {
            FieldWrap wmp = new FieldWrap();
            wmp.name = fieldName;
            wmp.label = objTypeFields.get(fieldName).getDescribe().getLabel();        
            allFieldsLst.add(wmp);
        }
        return allFieldsLst;
    }
    public class FieldWrap
    {
        @Auraenabled
        public string Name{get;set;}
        @Auraenabled
        public string Label{get;set;}
    }
      @AuraEnabled
    public static void setObjectToRecentItems(Id recordId) {
        if (!String.isBlank(recordId)) {
            Schema.SObjectType sObjectType = recordId.getSobjectType();
            String queryString = String.format('SELECT Id, Name FROM {0} WHERE Id =: recordId FOR VIEW', new List<Object>{sObjectType});
            Database.query(queryString);
        }
    }

}

// https://www.forcetree.com/2020/06/custom-lookup-component-in-lwc.html