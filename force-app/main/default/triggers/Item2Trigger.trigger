trigger Item2Trigger on Item2__c (before insert) {
    List<String> f1List = new List<String>();
    List<String> f2List = new List<String>();
    for(Item2__c itm : trigger.new){
        if(itm.f1__c !=null && itm.f2__c != null){
            f1List.add(itm.f1__c);
            f2List.add(itm.f2__c);
        }
    }
    List<Item1__c> itmLst = [select id,field1__c,field2__c,field3__c from Item1__c where (field1__c In : f1List) OR (field2__c IN : f2List)];
    Map<List<string>,string> itme1Map = new Map<List<string>,string>();
    List<String> itmlist1 = new List<String>();
    for(Item1__c itm : itmLst){
        itmlist1.add(itm.field1__c);
        itmlist1.add(itm.field2__c);
        itme1Map.put(itmlist1,itm.field3__c);
    }
    if(!itme1Map.isEmpty()){
       /* for(Item2__c itm : trigger.new){
            if(itmMap.containsKey(itm.id)){
                List<String> itmFieldLst = itmMap.get(itm.Id);
                //List<String> itm1Lst = itme1Map.get();*/
                
                
            }
            
        }