public class TICalloutController {
    public static Map <String,TiAPI__mdt> TIApiMap = new Map <String,TiAPI__mdt>(); 
    public TICalloutController(){
        List<TiAPI__mdt> ApiRecLst = [Select Label,API_Key__c,End_Point__c, Domain__c, Url_Mapping__c, Parameter_Name__c, Parameter_Value__c,Set_Time_Out__c,Method__c,Token__c from TiAPI__mdt];
        for(TiAPI__mdt rec : ApiRecLst){
            TIApiMap.put(rec.Label,rec);
        }
        system.debug('TIApiMap '+TIApiMap);
    }
    public string getContact(){
        TiAPI__mdt ApiData = TIApiMap.get('ContactAPI');
        String baseUrl =ApiData.End_Point__c;
        String paraValue = ApiData.Parameter_Value__c;
        String paraName = ApiData.Parameter_Name__c;
        string ulrMap = ApiData.Url_Mapping__c;
        String method = ApiData.Method__c;
        String token = ApiData.Token__c;
        HttpRequest req = new HttpRequest();
        req.setMethod(method);
        String EndPointAddress = baseUrl+'/'+ulrMap+'?'+paraName+'='+paraValue;
        req.setEndpoint(EndPointAddress);
        system.debug('EndPointAddress  '+EndPointAddress);
        req.setHeader('API-TOKEN', token);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        try{
            if (res.getStatusCode() == 200 || res.getStatusCode() == 201 ) {
                TICalloutWrapper ConDataWrapperObj = new TICalloutWrapper();
                ConDataWrapperObj = ConDataWrapperObj.parseMtd(res.getBody());
                system.debug('res.getBody## '+res.getBody());
                system.debug('ConDataWrapperObj '+ConDataWrapperObj);
                List<Contact> conList = new List<Contact>();
                for(TICalloutWrapper.clsData obj : ConDataWrapperObj.data){
                    Contact con = new Contact();
                    con.FirstName = obj.firstName;
                    con.LastName =  obj.lastName;  
                    conList.add(con);
                }
                system.debug('conList '+conList);
                if(!conList.isEmpty()){
                    insert conList[0]; 
                    return 'Success';
                }
            }else{
                Error_Log__c rec = new Error_Log__c();
                rec.Status_Code__c = res.getStatusCode();
                rec.Error__c = res.getBody()+'';
                insert rec;
                return 'Error';
            }
            return 'Error';
        }
        catch (Exception e){
            return e.getMessage();
        }
    }
}

/*{
	"data": [{
		"id": "44bfbaf2-3add-44c9-870b-bd67f88fabb8",
		"clientId": "",
		"disabled": "false",
		"sfAccountId": "",
		"sfContactId": "",
		"externalCustomerId": "",
		"email": "vrushalij@knowledgesynonyms.com",
		"firstName": "Vrushali",
		"lastName": "Nalawade",
		"lastActiveAt": "2023-02-23T07:53:16.311000-08:00",
		"ref1": "",
		"ref2": "",
		"ref3": "",
		"ref4": "",
		"ref5": "",
		"ref6": "",
		"ref7": "",
		"ref8": "",
		"ref9": "",
		"ref10": ""
	}]
}*/