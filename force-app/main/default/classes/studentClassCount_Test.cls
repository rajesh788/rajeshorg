@isTest
public class studentClassCount_Test {
    @isTest
    public static void studentClassCount_TestMtd(){
        List<student__c> stuLst = new  List<student__c>();
        
        class__c cls1 = new class__c (Name__c='10th'); 
        insert cls1;
        
        student__c stu = new student__c (Last_Name__c='ABCD',Class__c=cls1.id);
        insert stu;
        
        student__c stu1 = new student__c (Last_Name__c='ABCD',Class__c=cls1.id);
        stuLst.add(stu1);
        insert stuLst;
        
        StudentClassCountHelper.BeforeInsertError(stuLst); // 
    }
}