@RestResource(urlMapping='/BookAPI/*')
global with sharing class BookRecord {
    List<cls_records> BookRecord1;
    @HttpGet
    global static Book__c getDetails(){
        RestRequest request = RestContext.request;
        
        String bookId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        
        Book__c result = [Select Id,Author__c,Price__c from Book__c limit 1];
        return result;
    }
    
    @HttpPost
    global static void bookRecInsert() 
        
    {
        List <string> userName = new List <string> ();
        system.debug('@#@#'+userName);
        Book__c BookRecord = new Book__c();
        RestRequest request    = RestContext.request;
        RestResponse response   = RestContext.response;    
        response.addHeader('Content-Type','applicatin/json');
        List<Object> fieldList = (List<Object>)JSON.deserializeUntyped(Request.requestBody.toString());
        Map <String, Object> data1 = new Map <String, Object> ();
        system.debug('@#@'+data1);
        for(Object x : fieldList) {
            data1 = (Map<String, Object>)x;
            String strAuthor=String.valueOf(data1.get('Author'));
            system.debug('$$'+strAuthor);
            userName.add(strAuthor);
        }
        system.debug('$$'+data1);
        List <User> userList = [select Id,name from user where name in : userName];
        system.debug('##'+userList);
        
        Map <String,String> userMap = new Map <string,String>();
        for(User usrObj : userList){
            userMap.put(usrObj.name,usrObj.Id);
        }
       
        Map<String, Object> data= new Map<String,Object> ();
        
        List <Book__c> recordsList = new List <Book__c>();
        Map<String,String> autherMap=new Map<String,String>();
        for (Object x : fieldList) {
            data = (Map<String, Object>)x;
            String strName=String.valueOf(data.get('Name'));
            String strAuthor=String.valueOf(data.get('Author'));
            Integer strPrice=Integer.valueOf(data.get('Price'));
            Book__c bookObj = new Book__c();
            bookObj.Name = String.valueOf(data.get('Name'));
            bookObj.Price__c = Integer.valueOf(data.get('Price'));
            string auth = String.valueOf(data.get('Author'));
            autherMap.put(strName,auth);
            Id usObjId=userMap.get(strAuthor);
            bookObj.Author__c= usObjId; 
            recordsList.add(bookObj);
        } 
        System.debug('recordsList--->'+recordsList);
        Insert recordsList;
    }
    
    @HttpDelete
    global static void deleteRec()  {
        RestRequest request = RestContext.request;
        String bookId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Book__c thisbook = [SELECT Id FROM Book__c WHERE Id = :bookId];
        delete thisbook;
    }
    @HttpPatch
    global static Id updateBookRec() {
        RestRequest request = RestContext.request;
        String bookId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Book__c thisbook = [SELECT Id FROM Book__c WHERE Id = :bookId];
        // Deserialize the JSON string into name-value pairs
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
        // Iterate through each parameter field and value
        for(String fieldName : params.keySet()) {
            // Set the field and value on the Case sObject
            thisbook.put(fieldName, params.get(fieldName));
        }
        update thisbook;
        return thisbook.Id;
    }
    
    global List <cls_records> records;
    global class cls_records {
        Book__c BookRecord;      
    }
}