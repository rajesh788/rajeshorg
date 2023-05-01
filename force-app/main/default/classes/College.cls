public class College {
    public list <student__c> listOfStudents{get;set;}
    public list <Contact> listOfTeacher{get;set;}
    public College (){
        listOfStudents=[SELECT First_Name__c, Last_Name__c, DOB__c, Contact_Name__c from student__c];
        listOfTeacher=[SELECT id,name,Subject__c from contact where Subject__c  <> null];
    }
    
    public String name { get; set; }
    public list<student__c> findName { get; set; }
    
    
    public PageReference searchData (){
        
        string searchstr1=('%'+name+'%');
        findName = [SELECT First_Name__c from student__c where name like :searchstr1];
        return null;
    }
}