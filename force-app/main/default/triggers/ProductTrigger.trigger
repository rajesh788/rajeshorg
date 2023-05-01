trigger ProductTrigger on Product_Category__c (Before insert,Before Update) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            for(Product_Category__c proObj : trigger.new){
                string A = proObj.Brand_1__c;
                string B = proObj.Brand_2__c;
                string C = proObj.Brand_3__c;
                if((A==B || A==C || B==C)) {
                    proObj.addError('Please Select Different Value');
                } 
            }
        }  
    }
    if(trigger.isUpdate){
        for(Product_Category__c proObj : trigger.new){
            string A = proObj.Brand_1__c;
            string B = proObj.Brand_2__c;
            string C = proObj.Brand_3__c;
            if((A==B || A==C || B==C)) {
                proObj.addError('Cannon insert 2 same product');
            }
        }
    }
}