public class CustomLookupLwcController {
    
    // Method to get Object name Direct search result  
    @AuraEnabled(cacheable=true)
    public static  List<ObjectDataWrappper> fetchLookupData(string searchKey) { 
        System.debug(searchKey); 
        List<ObjectDataWrappper> objWrapperList=new List<ObjectDataWrappper>();
        if(String.isBlank(searchKey)){
            System.debug('Enter Space ');
            List<string> SObjectList = new List<string>();
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
               
                String name = objTyp.getDescribe().getName();
                // Exclude all the unwanted Sobjects e.g. History, Share etc..
                
                if((!name.containsignorecase('history') && !name.containsignorecase('tag')&&
                    !name.containsignorecase('share') && !name.containsignorecase('feed')) ){      
                        SobjectList.add(name);
                        //System.debug( 'Name : ' + name);
                        objWrapperList.add(new ObjectDataWrappper(objTyp.getDescribe().getName(),objTyp.getDescribe().getLabel()));
                    }
            }
            //System.debug(objWrapperList);
        }else{
            System.debug('Enter else ');
            List<string> SObjectList = new List<string>();
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
                String name = objTyp.getDescribe().getName();
                // Exclude all the unwanted Sobjects e.g. History, Share etc..
                if((!name.containsignorecase('history') && !name.containsignorecase('tag')&&
                    !name.containsignorecase('share') && !name.containsignorecase('feed')) ){      
                        SobjectList.add(name);
                        //System.debug( 'Name : ' + name);
                        String objName=objTyp.getDescribe().getName().toLowerCase();
                        searchKey=searchKey.toLowerCase(); 
                        if(objName.contains(searchKey)){
                            objWrapperList.add(new ObjectDataWrappper(objTyp.getDescribe().getName(),objTyp.getDescribe().getLabel()));
                        }
                    }
            }
            //System.debug(objWrapperList);
        }
        return objWrapperList;
    }
   
    public class ObjectDataWrappper{
        @AuraEnabled 
        public String label;
        @AuraEnabled 
        public String value;
        
        public ObjectDataWrappper(String value,String label){
            this.value=value;
            this.label=label;
        }
    }
    @Auraenabled(cacheable=true)
    public static List<FieldWrap> getFields(string objectName)
    {
        system.debug('objectName'+objectName);
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
        system.debug('allFieldsLst '+allFieldsLst);
        return allFieldsLst;
    }
    public class FieldWrap
    {
        @Auraenabled
        public string Name{get;set;}
        @Auraenabled
        public string Label{get;set;}
    }
    @Auraenabled(cacheable=true)
    public static List<DataWrapperClass> getFieldDetails(string objectName) {
        system.debug('objectName'+objectName);
        List <DataWrapperClass> allFieldWrapperLst1 = new List <DataWrapperClass> (); 
        string objName = objectName;
        String Query='SELECT DurableId, DeveloperName, label, DataType, ValueTypeId,LastModifiedById,LastModifiedBy.Name,LastModifiedDate, Length FROM FieldDefinition WHERE EntityDefinition.QualifiedApiName =:  objName';
        List<FieldDefinition> sobjList = Database.query(Query);
       
        String customFieldJSON = CustomLookupLwcController.CalloutMtd(objectName);
        JSON2ApexCustomField jsonRecord = (JSON2ApexCustomField)JSON.deserialize(customFieldJSON, JSON2ApexCustomField.class);
        Map<String, JSON2ApexCustomField.Records> fieldDefinationMap = new Map<String, JSON2ApexCustomField.Records>();
        for(JSON2ApexCustomField.Records fldRec : jsonRecord.Records){
            fieldDefinationMap.put(fldRec.DeveloperName, fldRec);
        }
        
        
        for(FieldDefinition ob : sobjList){
            DataWrapperClass fData = new DataWrapperClass();
            fData.FieldLable = ob.Label;
            fData.APIName = ob.DeveloperName;
            fData.DataType = ob.DataType;
            fData.ValueType = ob.ValueTypeId;
            fData.Length = ob.Length;
            fData.LastModifyId = ob.LastModifiedBy.Name;
            fData.CreateName = fieldDefinationMap.containsKey(ob.DeveloperName) ? fieldDefinationMap.get(ob.DeveloperName).CreatedBy.Name : '';
            fData.LastModifiedDt = ob.LastModifiedDate;
            fData.CreatedDate  = fieldDefinationMap.containsKey(ob.DeveloperName) ? fieldDefinationMap.get(ob.DeveloperName).CreatedDate : null;
            fData.CreatedInDate  = fieldDefinationMap.containsKey(ob.DeveloperName) ? date.newinstance(fieldDefinationMap.get(ob.DeveloperName).CreatedDate.year(), fieldDefinationMap.get(ob.DeveloperName).CreatedDate.month(), fieldDefinationMap.get(ob.DeveloperName).CreatedDate.day()) : null;
            allFieldWrapperLst1.add(fData);
        }
        system.debug('### '+allFieldWrapperLst1);
        return allFieldWrapperLst1;
    }
    @Auraenabled(cacheable=true)
    // CustomLookupLwcController.CalloutMtd('Account');
    public static String CalloutMtd(string objectName){
        List <DataWrapperClass> customWrapperLst = new List <DataWrapperClass> (); 
        string objName = objectName;
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:RajeshOrgAPI/services/data/v48.0/tooling/query?q=SELECT+NameSpacePrefix,DeveloperName,CreatedBy.Name,TableEnumOrId,CreatedDate+FROM+CustomField+WHERE+TableEnumOrId=\'' + objName +  '\'');
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');
        HttpResponse res = h.send(req);
        System.debug('@@@ '+res.getBody());	
        JSON2ApexCustomField jsonRecord = (JSON2ApexCustomField)JSON.deserialize(res.getBody(), JSON2ApexCustomField.class);
        System.debug('jsonRecord'+JSON.serialize(jsonRecord.records));
        return res.getBody();
    }
    public class DataWrapperClass
    {
        @AuraEnabled
        public string FieldLable {get;set;}
        @AuraEnabled
        public string APIName {get;set;}
        @AuraEnabled
        public string DataType {get;set;}
        @AuraEnabled
        public string ValueType {get;set;}
        @AuraEnabled
        public integer Length {get; set;}
        @AuraEnabled
        public String LastModifyId {get;set;}
        @AuraEnabled
        public DateTime LastModifiedDt {get;set;}
        @AuraEnabled
        public string CreateName {get;set;}
        @AuraEnabled
        public DateTime CreatedDate {get;set;}
        @AuraEnabled
        public Date CreatedInDate {get;set;}
        @AuraEnabled
        public string DevName {get;set;}
        
        public DataWrapperClass(FieldDefinition fd) {
            this.FieldLable = fd.Label;
            this.APIName = fd.DeveloperName;
            this.DataType = fd.DataType;
            this.ValueType = fd.ValueTypeId;
            this.Length = fd.Length;
            this.LastModifyId = fd.LastModifiedById;
        }
        public DataWrapperClass(){
            
        }
        
    }
    @AuraEnabled(cacheable=true) 
public static void getFilterData(string startDate, string endDate) {
    List <DataWrapperClass> allFieldWrapperLst1 = new List <DataWrapperClass> ();
    System.debug('startDate @#@#  '+startDate);
    System.debug('endDate @#@  '+endDate);


    
}


    
}