trigger CloneLineItem on Quote (After update) {
    if(trigger.isAfter){
        If(trigger.isupdate){
            Set<id> QuoteIds = new Set <id>();
            for(Quote quoteObj:trigger.new){
                QuoteIds.add(quoteObj.id);
            }
            List<QuoteLineItem> quoteLineItmeList = new List <QuoteLineItem>();
            Map<Id,Quote>qtLineItemMap =new Map<Id,Quote>([Select name,Is_Clone__c,(select id,Quoteid,PricebookEntryId,Product2Id,UnitPrice,Quantity,Subtotal from QuoteLineItems) from quote where id IN : quoteIds]);
            for(Quote qtObj : trigger.new){
                if(qtLineItemMap.ContainsKey(qtObj.id)){
                    if(qtObj.Is_Clone__c!=trigger.oldMap.get(qtObj.id).Is_Clone__c && qtObj.Is_Clone__c==true){
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