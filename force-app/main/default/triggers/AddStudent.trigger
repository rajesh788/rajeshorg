//When Contact record is created and mark (checkbox field) the contact as students.
//On insert create student record if above field is checked.
//On Update check if above field is updated as checked.

trigger AddStudent on Contact (After insert,After Update) {
    if(trigger.isAfter) {
        if(trigger.isInsert) {
            List<student__c>stuList = new List<student__c>();
            for(contact con:trigger.new){
                if(con.Mark_as_Student__c == true) {
                    student__c stu=new student__c();
                    stu.First_Name__c = con.FirstName;
                    stu.Last_Name__c = con.LastName;
                    stu.DOB__c = con.Birthdate;
                    stu.Emails__c = con.Email; 
                    stu.Class__c='a0G5j000000mDKWEA2';
                    stuList.add(stu);
                }
                if(stuList.size()>0) {
                    insert stuList;
                }
            }
        }
        if(trigger.isUpdate) {
            List<student__c> stuList1 = new List<student__c>();
            for(contact con:trigger.new){
                if(con.Mark_as_Student__c != trigger.oldMap.get(con.Id).Mark_as_Student__c){
                    if(con.Mark_as_Student__c == true) {
                        student__c stu1=new student__c();
                        stu1.First_Name__c = con.FirstName;
                        stu1.Last_Name__c = con.LastName;
                        stu1.DOB__c = con.Birthdate;
                        stu1.Emails__c = con.Email; 
                        stu1.Class__c='a0G5j000000mDKWEA2';
                        stuList1.add(stu1);
                    }
                    if(stuList1.size()>0) {
                        insert stuList1;
                    }
                }
            }
        }
    }
}