trigger LineItemDates on Quote (After Update) {
    if(trigger.isAfter){
        if(trigger.isUpdate){
            Set<id> QuoteIds = new Set <id>();
            for(Quote quoteObj:trigger.new){
                QuoteIds.add(quoteObj.id);
            }
            List<QuoteLineItem> quoteLineItmeList = new List <QuoteLineItem>();
            Map<Id,Quote>qtLineItemMap =new Map<Id,Quote>([Select name,Is_Clone__c,Term__c,(select id,Quoteid,PricebookEntryId,Product2Id,UnitPrice,Quantity,Subtotal from QuoteLineItems) from quote where id IN : quoteIds]);
            for(Quote qtObj : trigger.new){
                if(qtLineItemMap.ContainsKey(qtObj.id)){
                    if(qtObj.Term__c!=trigger.oldMap.get(qtObj.id).Term__c && qtObj.Term__c!=null){
                        Decimal termMonth=qtLineItemMap.get(qtObj.id).Term__c;
                        Decimal term =termMonth/12;
                        Decimal dt= termMonth*30; //days number
                        Decimal yr= dt/365; //years in decimal
                        integer yRound = ((integer)yr.round(system.RoundingMode.CEILING)-1);//year-1
                        Decimal mth=(yr-yRound)*12; //years in decimal
                        integer mthRound = ((integer)mth.round(system.RoundingMode.CEILING));//month round off
                        integer afterRound = (integer)term.round(system.RoundingMode.CEILING);//year round off
                         
                        for(QuoteLineItem lineItem : qtLineItemMap.get(qtObj.id).QuoteLineItems){
                            lineItem.Start_Date__c=system.today();
                            lineItem.End_Date__c= system.today().addYears(1);
                            
                            integer i=1;
                            for(i=1; i<afterRound; i++){
                                QuoteLineItem QI=lineItem.clone (false,true,false,false); 
                                QI.Start_Date__c=system.today().addYears(i);
                                if(term-i>=1){
                                    QI.End_Date__c= system.today().addYears(i+1); 
                                }
                                else{
                                    QI.End_Date__c=QI.Start_Date__c.addMonths(mthRound); 
                                }
                                quoteLineItmeList.add(QI); 
                            }
                            quoteLineItmeList.add(lineItem); 
                        }
                    } 
                } 
            }
            if(quoteLineItmeList.size()>0){
                insert quoteLineItmeList;
            }
        }
    }
}