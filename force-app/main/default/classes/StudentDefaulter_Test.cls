@isTest
public class StudentDefaulter_Test {
@TestSetup
    public static void testSetup(){
        
    }
    @istest
    public static void testSetupMtd(){
        
        List <student__c> studentList = new List <student__c> ();
        class__c cls = new class__c (Name__c='10th');
        insert cls;
        
        student__c stu = new student__c (Last_Name__c='ABCD',Class__c=cls.id,Fee__c='Defaulter');
        insert stu;
        
        student__c stu1 = new student__c (Last_Name__c='ABCD',Class__c=cls.id,Fee__c='Defaulter');
        insert stu1;
        
    }
}