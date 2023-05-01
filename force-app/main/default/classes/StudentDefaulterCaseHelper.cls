public class StudentDefaulterCaseHelper {
    public static void BeforeInsertCaseMtd(List<Student__c> studentLst){
        
        List<Case> CaseOfStudent = new List <Case>();
        List<Student__c> studentList= new List <Student__c>();
        string text ='Defaulter student -';
        
        for(student__c stu : studentLst){
            if(stu.Fee__c!=null){
                if(stu.Fee__c=='Defaulter'){
                    case caseRec = new case();
                    caseRec.Status='New';
                    caseRec.origin='Phone';
                    caseRec.Subject=text+stu.Name;
                    CaseOfStudent.add(caseRec);
                } 
            }
        }
        if(!CaseOfStudent.isEmpty()){
            insert CaseOfStudent;
            For(Integer i=0 ;i<CaseOfStudent.Size();i++){
                for(student__c stu : studentLst){
                    stu.Case__c = CaseOfStudent[i].Id;
                } 
            }
        } 
    }
}