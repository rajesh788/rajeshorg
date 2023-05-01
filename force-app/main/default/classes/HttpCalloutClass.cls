public class HttpCalloutClass {
    public static void doCallOut(string recId){
        HttpRequest req = new HttpRequest();
        //We will use Named Credentials as below
        req.setEndpoint('callout:RajeshSF/services/apexrest/Account/'+recId);
        req.setMethod('GET');
        // Create a new http object to send the request object
        Http http = new Http();
        HTTPResponse res = http.send(req);
        String body = res.getBody();
        system.debug('body '+body);
        
        List<TestCalloutWrapper> wrapper = TestCalloutWrapper.parse(body);
        System.debug('rec: '+wrapper[0].Contacts.records);
        System.debug('rec: '+wrapper[0].Opportunities.records);
        contactInsert(wrapper[0].Contacts);
    }
    public static void contactInsert(TestCalloutWrapper.Contacts contacts){
        List<Contact> conLst = new List<Contact>();
        for(TestCalloutWrapper.Records_Z item : contacts.records){
            conLst.add(new Contact(
            	FirstName=item.FirstName,
                LastName=item.LastName
            ));
        }
        insert conLst;
    }
    
}