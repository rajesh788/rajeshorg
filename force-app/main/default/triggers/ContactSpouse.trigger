trigger ContactSpouse on Contact (before insert) {
    if (trigger.isInsert) {
        for (Contact wife :Trigger.new ){
            if(wife.Marrieds__c==true){
                if(string.isEmpty(wife.Spouse_Name__c)){
                    wife.Spouse_Name__c.addError('Please Enter Spouse Name');  
                } 
            }
        }
    } 
}