@RestResource(urlMapping='/AccountData/*')
global class ApiDataInsert {
    /*@HttpPost
    global static Account getRecord() {
    RestRequest req = RestContext.request;
    String jsonBody = req.requestBody.toString();
    DataWrapper ob = new DataWrapper();
    ob = (DataWrapper)JSON.deserialize(jsonBody, DataWrapper.class);
    System.debug('recordIds'+ob);
    return null;//[SELECT Id from Account WHERE Id = :recordId LIMIT 1];
    }*/
    @HttpPost
    global static String getRecord(Boolean CreateContact, Boolean CreateOpportunity, Boolean CreateAccount) {
        
        
        ResponseWrapper res = new ResponseWrapper();
        try{
            if (CreateContact == true){
                Contact con = new Contact();
                con.FirstName = 'first';
                con.LastName = 'Contact';
                INSERT con;
                res.message = 'Contact Created Successfully, Id = '+con.Id;
                res.statusCode = 200;
            }
            if (CreateOpportunity == true){
                Opportunity Opp = new Opportunity();
                Opp.Name = 'Trading';
                Opp.CloseDate = system.today();
                Opp.StageName = 'Qualification';
                INSERT Opp;
                res.message = 'Opportunity Created Successfully, Id = '+Opp.Id;
                res.statusCode = 200;
            }
            if (CreateAccount == true){
                Account Acc = new Account();
                Acc.Name = 'Test Acc22';
                INSERT Acc;
                res.message = 'Account Created Successfully, Id = '+Acc.Id;
                res.statusCode = 200;
            }
            
           /* Contact con = new Contact(FirstName = firstName,LastName =lastName);
            INSERT con;
            res.message = 'Contact Created Successfully, Id = '+con.Id;
            res.statusCode = 200;*/
        }catch(Exception e){
            res.message = e.getMessage();
            res.statusCode = 400;
        }
        return JSON.serialize(res);//[SELECT Id from Account WHERE Id = :recordId LIMIT 1];
    }
    public class ResponseWrapper{
        public String message;
        public Integer statusCode;
        public ResponseWrapper(){
        }
    }
}