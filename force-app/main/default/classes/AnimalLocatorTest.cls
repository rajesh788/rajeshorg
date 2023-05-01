@isTest
public class AnimalLocatorTest {
    @isTest Static Void AnimalLocatorMock1(){
        try{
            Test.setMock(HttpCalloutMock.class,new AnimalLocatorMock());
            string result = AnimalLocator.getAnimalNameById(1);
            string expectedResult = 'fox';
            system.assertEquals(result, expectedResult);
        }
        catch (exception e){
            system.debug('The Following expection has occured '+ e.getMessage());
        }
    }
}