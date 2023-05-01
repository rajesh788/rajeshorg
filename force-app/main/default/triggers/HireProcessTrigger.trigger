trigger HireProcessTrigger on Hire_form__c (Before Insert,After Insert,After update) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            List <Contact> conList = new List <contact>();
            List <Hire_form__c> hireList = new List <Hire_form__c>();
            List <case> caseList = new List <case>();
            for(Hire_form__c hire : trigger.new){
                hire.status__c = 'In progress';
                hireList.add(hire);
                contact con = new contact ();
                con.FirstName=hire.First_Name__c;
                con.LastName=hire.Last_name__c;
                con.Email=hire.Email__c;
                con.Phone=hire.Phone__c;
                conList.add(con);
            }
            if(!conList.isEmpty()){
                insert conList; 
                
                List<Id> conIds = new List <Id>();
                for(contact con : conList){
                    conIds.add(con.Id);
                    Case CaseObj = new Case(); // new case create
                    CaseObj.Status = 'New';
                    CaseObj.Origin = 'Web';
                    CaseObj.Subject= 'case of '+con.FirstName;
                    CaseObj.ContactId= con.Id; // contact id relate to case
                    caseList.add(CaseObj);
                }
                insert caseList;
                
                for(integer i=0;i<hireList.size();i++){ //contact id in look up field (Candidate__c).
                    hireList[i].Candidate__c=conIds[i];
                }
            } 
        }			   
    }
    set <Id> formContactIds = new Set <Id>();
    List <Case> ListOfCase = new List <Case>();

    if(trigger.isAfter){
        if(trigger.isUpdate){
            for(Hire_form__c form : trigger.new){
                if(form.status__c == 'Completed' && form.status__c != trigger.oldMap.get(form.Id).status__c){
                    formContactIds.add(form.Candidate__c);
                }
            }
            if(!formContactIds.isEmpty()){
                List <Case> caseListAfter =([select id,ContactId,Status from Case where ContactId In : formContactIds]);
                for(Case caseObj : caseListAfter){
                    caseObj.Status='Escalated'; // case status change when form status completed
                    ListOfCase.add(caseObj);
                }
                if(!ListOfCase.isEmpty()){
                    update ListOfCase;	
                }
            }
        }
    }
}