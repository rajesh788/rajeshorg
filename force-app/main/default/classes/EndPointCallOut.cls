public class EndPointCallOut {
    public static void getToken(){
        string EndPointAddress = 'https://login.salesforce.com/services/oauth2/token?username=client.org@gmail.com&password=13eajce016NwMZSZw0AJikBx3rd4iNQ1XnZ&grant_type=password&client_id=3MVG9fe4g9fhX0E7dz0jApRq7jAL6_OkCrcUBSd9IncDvfov6vhLYgz3AxUABpcOgLhT0MMVYs5.k8qXYpnsD&client_secret=09A3106BA10DE5A4909606B61496FFF158F92EC379DDC1954E589B00E060A7AF';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(EndPointAddress);
        req.setMethod('POST');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        if (res.getStatusCode() == 200) {
            System.debug('Body: '+res.getBody());
        }
    }
    public static void doCallOut(){
        string EndPointAddress; //https://dummyjson.com/products
        string key;
        string clientId;
       
        /* List <CallOut__c> callOutLst = CallOut__c.getall().values();
        for(CallOut__c clOut : callOutLst){
            EndPointAddress = clOut.EndPoint__c; 
        }*/
        
        APIInfo__mdt ApiMetaLst = [Select Label,EndPoint__c, Client_Id__c from APIInfo__mdt where Label = 'Detail1' Limit 1];
        EndPointAddress = ApiMetaLst.EndPoint__c;
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(EndPointAddress);
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        if (res.getStatusCode() == 200) {
            system.debug('res.getBody() '+res.getBody());
            ProductDataWrapper ProductDataWrapperObj=new ProductDataWrapper();
            ProductDataWrapperObj=ProductDataWrapperObj.getJSONDeslize(res.getBody());
            system.debug('22222'+ProductDataWrapperObj);
            
            //Mobile__c mobileObj=new Mobile__c();
            //mobileObj.name=ProductDataWrapperObj.products[0].
            
            List<Mobile__c> mobileList=new List<Mobile__c>();
            for(ProductDataWrapper.products productObj : ProductDataWrapperObj.products){
                mobileList.add(new Mobile__c(Name=productObj.title,description__c=productObj.description));
            }
            if(!mobileList.isEmpty()){
                insert mobileList;
            }
        }
    }
}