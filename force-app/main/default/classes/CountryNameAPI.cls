//@RestResource(urlMapping='/CountryAPI/*')
global class CountryNameAPI {
    //@HttpGet
    global static string getCountryName(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api-hub-developer-edition.ap17.force.com/services/apexrest/CountryAPI');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        system.debug(results);
        List <Object> countryLst = (List<Object>) results.get('Country');
        
        system.debug(countryLst);
        for(Object str: countryLst) {
            system.debug('###'+str); 
        }
        if(response.getStatusCode() == 200) {
            system.debug(response.getStatusCode());
        }
        return JSON.serialize(countryLst);
    }
}