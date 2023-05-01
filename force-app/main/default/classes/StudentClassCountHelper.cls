public class StudentClassCountHelper {
    public static void BeforeInsertError(List<student__c> stuLst){
       /* Set<Id> classIds=new Set<Id>();
        for(Student__c stuObj : stuLst){
            if(String.isNotBlank(stuObj.Class__c)){
               classIds.add(stuObj.Class__c); 
            }
        }
        List<AggregateResult> aggrrList=[SELECT Class__r.Id,Count(Class__c) countStudent FROM Student__c WHERE Class__c In :classIDs Group by Class__r.Id];
        System.debug(aggrrList);
        Map<Id,Integer>  ClassStudentCountMap=new Map<Id,Integer>();
        for(AggregateResult aggrObj : aggrrList){
            //Integer countStudent=Integer.valueOf((aggrObj.get('countStudent')!=null) ? 0:aggrObj.get('countStudent'));
            ClassStudentCountMap.put(aggrObj.Id,Integer.valueOf(aggrObj.get('countStudent')));
        }
        System.debug(ClassStudentCountMap);
        for(Student__C stuObj : stuLst){
            Integer countStudent=ClassStudentCountMap.get(stuObj.Class__c);
            if(countStudent>=15){
                stuObj.addError('Do Not Add.');
            }
        }*/
        set<id>classIds= new set<id>();
        for(student__c stu : stuLst){
            classIds.add(stu.class__c);
            system.debug('Class Id'+classIds);//class Id
        }
        List <student__c> stuList = [select id,name,class__c,Class__r.name from student__c where Class__c IN:classIds];
        system.debug('Student List'+stuList);//All student list from old data
        Map<Id,integer> classMap = new Map<Id,integer>();
        
        
        for(student__c st : stuList){ // for loop for fill the map from the list
            integer totalstudent = 0; 
            if(classMap.containskey(st.Class__c)){ 
                totalstudent=classMap.get(st.Class__c);// get value of key from map 
            }
            totalstudent++;
            classMap.put(st.Class__c,totalstudent); // fill map (define key and value)
            system.debug('total Student'+totalstudent); // count student one by one and give total number
        }  
        for(student__c st : stuLst){ //new student record insert
            integer totalsize=0;
            if(classMap.containskey(st.Class__c)){ //
                totalsize= classMap.get(st.Class__c);
                system.debug('Total Size'+totalsize);
                if(totalsize>=20){
                    st.addError('Max students allow 17');
                }
            }
            totalsize++;
            classMap.put(st.Class__c,totalsize);
            system.debug('Total Size'+totalsize);
        } 
    }  
    
}