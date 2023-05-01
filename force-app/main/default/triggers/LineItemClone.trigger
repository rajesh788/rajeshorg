trigger LineItemClone on QuoteLineItem (After insert) {
    if(trigger.isAfter){
        If(trigger.isinsert){
            Set<id> quoteIds = new Set<id>();
            
            for(QuoteLineItem qLineObj:trigger.new){
                if(qLineObj.Product2Id!=null){
                    quoteIds.add(qLineObj.QuoteId); 
                }
            }
            list<QuoteLineItem> quotetLineItemList = new list<QuoteLineItem>();
            List<Quote> qtList = [Select id,name,Is_Clone__c,(select id,Quoteid,Product2Id,UnitPrice,Quantity,Subtotal from QuoteLineItems) from quote where id IN : quoteIds];
            
            
            for(Quote qtObj : qtList){
                if(qtObj.Is_Clone__c==true){
                    for(QuoteLineItem lineItem :trigger.new){
                        system.debug('Entered Data' +lineItem);
                        //QuoteLineItem qut = lineItem.clone(false,true,true,false);
                        // qut.quote=qtObj.id;
                        quotetLineItemList.add(lineItem.clone (true,true,true,true));  
                    }
                }
            }
            system.debug('quotetLineItemList'+quotetLineItemList);
            if(quotetLineItemList.size()>0){
                insert quotetLineItemList;
            }
        }
    } 
}