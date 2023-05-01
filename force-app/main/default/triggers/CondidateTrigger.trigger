trigger CondidateTrigger on Condidate__c (After insert) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            Map <Id,Account> conBrokerageMap = new Map <Id,Account>  (); 
            Map <Id,Account> conManageMap = new Map <Id,Account>  ();
            Map <Id,Contact> canContactMap = new Map <Id,Contact>();
            
            for(Condidate__c can : trigger.new){
                if(can.Brokerage__c!=null){
                    Account acc = new Account ();
                    acc.Name = can.Brokerage__c;
                    conBrokerageMap.put(can.Id,acc);
                }
            }
            insert conBrokerageMap.values();
            
            for(Condidate__c can : trigger.new){
                if(can.Manage_Brokerage__c!=null){
                    Account acct = new Account ();
                    acct.Name = can.Manage_Brokerage__c;
                    conManageMap.put(can.Id,acct);
                    Contact cont = new contact ();
                    cont.LastName = can.First_Name__c;
                    canContactMap.put(can.id,cont);
                    system.debug('Acc'+acct);
                    system.debug('Contact'+cont);
                }
            }
            // parent id to manage brokerge account 
            for(Id key : conManageMap.keySet()){
                if(conBrokerageMap.containsKey(key)){
                    Account accManage = new Account();
                    Account accBrokerage = new Account();
                    accBrokerage = conBrokerageMap.get(key);
                    accManage = conManageMap.get(key);
                    accManage.ParentId =accBrokerage.id;
                    conManageMap.put(key,accManage);
                }
            }
            insert conManageMap.values();
            
            // account id on contact
            for(Id key : conManageMap.keySet()){ 
                if(canContactMap.containsKey(key)){
                    Contact contRec = new Contact();
                    Account acc = new Account();
                    acc = conManageMap.get(key);
                    contRec = canContactMap.get(key);
                    contRec.accountId = acc.id; // account id on inserted contact
                    contRec.Condidate__c = key; // id update on contact- look up field
                    canContactMap.put(key,contRec);
                }
            }
            insert canContactMap.values();
            List <Task> taskList = new List <Task>();
            for(Id ids : canContactMap.Keyset()){
                Contact conObj = new Contact();
                Task taskObj = new Task ();
                conObj=canContactMap.get(ids);
                taskObj.Subject= 'Portal Contact Setup';
                taskObj.WhoId= 	conObj.Id;
                taskObj.WhatId = ids ;
                taskList.add(taskObj);
            }
            insert taskList;
        }
       /* if(Trigger.isUpdate){
            Set<Id> CondidateIds = new Set <Id>();
            for(Condidate__c can : trigger.new){
                if(can.Condidate_Status__c== 'Webinar - Attended' && Can.User_Created__c==false){
                    CondidateIds.add(can.Id);
                }
               
                Map<id,Contact> mapCanCon = new Map<id,Contact>([SELECT id, FirstName, LastName, Email FROM Contact where Condidate__c in :CondidateIds]);
                
                List<User> newUserList = new List<User>();
                
                
                
               
                
            }
            
        }*/
    }
}