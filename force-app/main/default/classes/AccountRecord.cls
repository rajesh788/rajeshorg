@RestResource(urlMapping='/Account/*')
global with sharing class AccountRecord {
    @HttpGet
    global static Account getAccountById(){
         RestRequest request = RestContext.request;
        
        String accId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        
        Account result =[Select Id,Name from Account where Id =: accId];
        return result;
    }
@HttpPost
    global static ID createAccount (String Name) {
        Account thisAcc = new Account(
            Name=name);
        insert thisAcc;
        return thisAcc.Id;
    }
}