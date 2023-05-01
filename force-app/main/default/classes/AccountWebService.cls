public with sharing class AccountWebService {
 
    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
 
public class NewAccountRequestWrapper {
    public String name {get; set;}
    public String phone {get; set;}
}
 
//test querying an Account record
public static void getAccount(Id accId) {
    request = new HttpRequest();
    request.setMethod('GET');
 
request.setEndpoint('callout:RajeshOrgAPI/services/apexrest/Acc/' + accId);
    response = http.send(request);
    System.debug(response.getBody());
}
 
//test creating an Account record
public static void addAccount(NewAccountRequestWrapper newAccount) {
    request = new HttpRequest();
    request.setMethod('POST');
 
request.setEndpoint('callout:RajeshOrgAPI/services/apexrest/Acc');
    request.setHeader('Content-Type',
'application/json;charset=UTF-8');
    request.setBody(JSON.serialize(newAccount));
    response = http.send(request);
    System.debug(response.getBody());
}
 
//test deleting an Account recoord
public static void deleteAccount(Id accId) {
    request = new HttpRequest();
    request.setMethod('DELETE');
 
request.setEndpoint('callout:RajeshOrgAPI/services/apexrest/Acc/' + accId);
    response = http.send(request);
    System.debug(response.getBody());
    }
}