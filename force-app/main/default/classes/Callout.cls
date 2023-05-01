public class Callout {
        @AuraEnabled 
        public static String Callout(){
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('callout:Test1/services/data/v35.0/tooling/query/?q=SELECT NameSpacePrefix, DeveloperName, TableEnumOrId, CreatedDate, CreatedById FROM CustomField WHERE TableEnumOrId =: Account');
            req.setMethod('GET');
            req.setHeader('Content-Type', 'application/json');
            HttpResponse res = h.send(req);
            return res.getBody(); 
        }
}