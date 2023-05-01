public class CustomLookupController {
   // Method to fetch lookup search result   
    @AuraEnabled(cacheable=true)
    public static  List<ObjectDataWrappper> fetchLookupData(string searchKey) {  
        List<ObjectDataWrappper> objWrapperList=new List<ObjectDataWrappper>();
    
        System.debug(searchKey);
        List<string> SObjectList = new List<string>();
        for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
            String name = objTyp.getDescribe().getName();
            // Exclude all the unwanted Sobjects e.g. History, Share etc..
            
            if((!name.containsignorecase('history') && !name.containsignorecase('tag')&&
                !name.containsignorecase('share') && !name.containsignorecase('feed')) ){      
                    SobjectList.add(name);
                    System.debug( 'Name : ' + name);
                    objWrapperList.add(new ObjectDataWrappper(objTyp.getDescribe().getName(),objTyp.getDescribe().getLabel()));
                }
        }
        System.debug(objWrapperList);
        return objWrapperList;
    }
    
    // Method to fetch lookup default value 
    @AuraEnabled
    public static sObject fetchDefaultRecord(string recordId , string sObjectApiName) {
        string sRecId = recordId;    
        string sQuery = 'Select Id,Name From ' + sObjectApiName + ' Where Id = : sRecId LIMIT 1';
        for (sObject obj: database.query(sQuery)) {
            return obj;
        }
        return null;
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
}