public class TestWeatherApi {
    public String city{get;set;}
    public TestWeatherApi(){
        
    }
    
    public void getData(){
        String endpointurl = 'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/'+city+'?unitGroup=metric&key=DNZVQU53G2PTZ6JNRD2PR3VLQ&contentType=json';
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpointurl);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 200) {
            Map<string,object> results=( Map<string,object>)JSON.deserializeUntyped(response.getBody());
            city = String.valueOf(results.get('name')); 
            
        }
    }
}