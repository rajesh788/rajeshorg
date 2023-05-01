public class WeatherAPI {
    public String city {get;set;}
    public String temp {get;set;}
    public String temp_min {get;set;}
    public String temp_max {get;set;}
    
    public WeatherAPI(ApexPages.StandardController stdController) {
        Weather_Info__c weather = (Weather_Info__c)stdController.getRecord();
        weather = [SELECT Id,City__c FROM Weather_Info__c];
        
        String city = weather.City__c;
        String apiKey = '13704cb5abd32ebb6ce995ad9dc94ba1';
        
        String requestEndpoint = 'http://api.openweather.org/data/2.5/weather';
        requestEndpoint +=	 '?q=' + city;
        requestEndpoint += '&units=metric';
        requestEndpoint += '&APPID=' + apiKey;
        
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(requestEndpoint);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            
            // Deserialize the JSON string into collections of primitive data types.
            Map<string,object> results=( Map<string,object>)JSON.deserializeUntyped(response.getBody());
            // city=string.valueof(result.get('name'));
            city = String.valueOf(results.get('name')); 
            Map<string,object> mainresults=( Map<string,object>)(results.get('main'));
            temp = string.valueOf(mainresults.get('temp'));
            temp_min = string.valueOf(mainresults.get('temp_min'));
            temp_max = string.valueOf(mainresults.get('temp_max'));
            
        }
        else {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Tere was an error');
            ApexPages.addMessage(myMsg);
        }
    }
}