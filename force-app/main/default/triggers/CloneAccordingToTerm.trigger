trigger CloneAccordingToTerm on Quote (After update) {
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
                        Decimal roundFig =termMonth/12;
                        integer afterRound = (integer)roundFig.round(system.RoundingMode.CEILING);
                           integer i;
                        for(i=1; i<afterRound; i++){
                            for(QuoteLineItem lineItem : qtLineItemMap.get(qtObj.id).QuoteLineItems){
                                quoteLineItmeList.add(lineItem.clone (false,true,false,false));  
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
}