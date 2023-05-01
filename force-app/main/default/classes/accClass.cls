@RestResource(urlMapping='/Acc/*')
global with sharing class accClass{ 

global class newWrapper {
        global string id;
        
    }
    @HttpPost
    global static list<account> doPost(list<newWrapper> idList){ 
        SET<String>newSet = new SET<String>();
        for(newWrapper jsn : idList){
            newSet.add(jsn.id);
        }
        list<sObject> accData = [SELECT id , Name,(select id,Name from contacts),(select id,name
                                 from opportunities) from account where id=:newSet];
        system.debug('acc'+accData);
        return accData;
    }
    }