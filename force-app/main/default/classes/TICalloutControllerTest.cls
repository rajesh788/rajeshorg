@isTest
public class TICalloutControllerTest {    
    static testMethod void testGetContact() {
        // Set up test data
       	TiAPI__mdt apiData = new TiAPI__mdt(
            Label = 'ContactAPI',
            API_Key__c = 'testKey',
            End_Point__c = 'https://api.example.com',
            Domain__c = 'example.com',
            Url_Mapping__c = 'contacts',
            Parameter_Name__c = 'name',
            Parameter_Value__c = 'John',
            Set_Time_Out__c = '10000',
            Method__c = 'GET',
            Token__c = 'testToken'
        );
        //insert apiData;

        // Set up mock HTTP response
        HttpResponse mockResponse = new HttpResponse();
        mockResponse.setStatusCode(200);
        mockResponse.setBody('{"data":[{"firstName":"John","lastName":"Doe"}]}');

        // Set up mock HTTP callout
        Test.setMock(HttpCalloutMock.class, new TICalloutMock(mockResponse));

        // Call the method to test
        TICalloutController controller = new TICalloutController();
        String result = controller.getContact();

        // Verify the result
        System.assertEquals('Success', result);

        // Verify that the contact was created
        List<Contact> contacts = [SELECT FirstName, LastName FROM Contact WHERE FirstName = 'John'];
        System.assertEquals(1, contacts.size());
        System.assertEquals('John', contacts[0].FirstName);
        System.assertEquals('Doe', contacts[0].LastName);
    }

    // Helper class to mock the HTTP callout
    private class TICalloutMock implements HttpCalloutMock {
        private HttpResponse response;
        public TICalloutMock(HttpResponse response) {
            this.response = response;
        }
        public HttpResponse respond(HttpRequest request) {
            return response;
        }
    }
}