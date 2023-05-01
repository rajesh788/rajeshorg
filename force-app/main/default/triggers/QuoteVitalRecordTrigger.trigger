trigger QuoteVitalRecordTrigger on Quote (After insert,After Update) {
    if(trigger.isAfter){
        List <Vital_Record__mdt> VitalRecList = ([select id,Label,Sequence__c from Vital_Record__mdt order by Sequence__c Asc]);
        List<Vital_Statics__c> VitalList = new List<Vital_Statics__c>();
        
        if(trigger.isinsert || trigger.isUpdate){
            for(Quote qtObj : trigger.new){
                if(qtObj.Create_Vital_Statics__c==true){
                    if(trigger.isInsert || qtObj.Create_Vital_Statics__c!=trigger.oldMap.get(qtObj.id).Create_Vital_Statics__c){  
                        for(integer i=0;i<VitalRecList.size();i++){
                            Vital_Statics__c vsRec = new Vital_Statics__c ();
                            vsRec.Quote__c = qtObj.Id;
                            vsRec.Name = VitalRecList[i].Label;
                            VitalList.add(vsRec);
                        }
                    }
                }
            }
            system.debug('@#@#'+VitalList);
            if(!VitalList.isEmpty()){
                insert VitalList;
            }
        }
        // Clone Vital Record to other quote:-
        if(trigger.isUpdate){
            List <Vital_Statics__c> vitalCloneList = new List <Vital_Statics__c> ();
            Map <Id,List<Vital_Statics__c>> qtVitalMap = new Map <Id,List<Vital_Statics__c>> ();
            Set<Id> quoteSet = new Set<Id>();
            for(Quote qtObj : trigger.new){
                if(qtObj.clone_vital__c!=null && qtObj.clone_vital__c!=trigger.oldMap.get(qtObj.id).clone_vital__c){
                    quoteSet.add(qtObj.Id);           
                }
                if(qtObj.Move_Vital__c!=null && qtObj.Move_Vital__c!=trigger.oldMap.get(qtObj.id).Move_Vital__c){
                    quoteSet.add(qtObj.Id);           
                }
            }
            if(!quoteSet.isEmpty()){
                List <Quote> quoteList = ([select id,name,(select id,name from Vital_Staticses__r) from quote where Id In : quoteSet]);
                for(Quote qt : quoteList){
                    List <Vital_Statics__c> vitalListData = qt.Vital_Staticses__r;
                    system.debug('List Data'+vitalListData);
                    if(!qtVitalMap.containsKey(qt.id)){
                        qtVitalMap.put(qt.id,vitalListData);
                    }
                }
                for(Quote qtObj:trigger.new){
                    if(qtObj.clone_vital__c!=null){
                        if(qtObj.clone_vital__c!=trigger.oldMap.get(qtObj.id).clone_vital__c){
                            if(qtVitalMap.get(qtObj.id) != null){
                                system.debug('###3rd'+qtObj.clone_vital__c);  
                                for(Vital_Statics__c vsRec : qtVitalMap.get(qtObj.id)){
                                    Vital_Statics__c vsObj =  vsRec.clone(false,true,false,false);
                                    vsObj.Quote__c = qtObj.clone_vital__c;
                                    vitalCloneList.add(vsObj);
                                }
                            }
                        }
                    }
                }
                system.debug('@#@#'+vitalCloneList);
                if(!vitalCloneList.isEmpty()){
                    insert vitalCloneList;
                }
                // Move vital static record:-
                List <Vital_Statics__c> vitalMoveList = new List <Vital_Statics__c> ();
                for(Quote qtObj : trigger.new){
                    if(qtObj.Move_Vital__c!=null){
                        if(qtObj.Move_Vital__c!=trigger.oldMap.get(qtObj.id).Move_Vital__c){
                            if(qtVitalMap.containsKey(qtObj.Id)){
                                for(Vital_Statics__c vsRec : qtVitalMap.get(qtObj.id)){
                                    vsRec.Quote__c = qtObj.Move_Vital__c;
                                    vitalMoveList.add(vsRec);
                                    system.debug('@#@#'+vitalMoveList);
                                }
                            }
                        }
                    }
                }
                if(!vitalMoveList.isEmpty()){
                    update vitalMoveList;
                }
            }
            
        }
    }
}