public class AddressUpdateController {
    @AuraEnabled
    public static List <Lead> getAddressRec(string recordId) {
        system.debug('recordId '+recordId);
        List <Lead> LeadLst = [SELECT Id,Name,Street,City,Country,State,PostalCode from Lead where Id =: recordId];
        system.debug('LeadLst '+LeadLst);
        return LeadLst;
        
    }
    @AuraEnabled
    public static String getAddressData(string ObjData,string recId) {
        system.debug('hi');
        system.debug('ObjData '+ObjData);
        system.debug('recId '+recId);
        String errorMsg='';
        DataWrapper DataWrapperObj=new DataWrapper();
        DataWrapperObj=DataWrapperObj.parse(ObjData);
        System.debug(DataWrapperObj);
        Lead LeadLst = [SELECT Id,Name,Street,City,Country,State,PostalCode from Lead where Id =: recId];
        LeadLst.Street=DataWrapperObj.street;
        LeadLst.City=DataWrapperObj.city;
        LeadLst.Country=DataWrapperObj.country;
        LeadLst.State=DataWrapperObj.state;
        LeadLst.PostalCode=DataWrapperObj.postalCode;
        
        Database.SaveResult isLeadUpdate=Database.update(LeadLst,false);
        System.debug(isLeadUpdate);
        /*if(isLeadUpdate){
            errorMsg='Successfully Update.';
        }else{
            errorMsg='ERROR.'; 
        }*/
        return null;
        
    }
    
    public class DataWrapper{
        public String state;	
        public String country;	
        public String city;	
        public String street;	
        public String postalCode;
        public DataWrapper parse(String json){
            return (DataWrapper) System.JSON.deserialize(json, DataWrapper.class);
        }
    }
}