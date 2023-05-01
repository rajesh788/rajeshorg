trigger Product2Trigger on Product2 (After insert,After Update) {
    if(trigger.isAfter){
        if(trigger.isInsert ){
            
            List<PricebookEntry> bookEntryList = new List <PricebookEntry>();
            
            string PrePriceBookId = [SELECT Id FROM Pricebook2 where Name = 'Standard Price Book'].id;
            
            for(Product2 prod : trigger.new){
                system.debug('New'+prod); // get productID,Price here
                PricebookEntry pBEntry = new PricebookEntry(); 
                pBEntry.Pricebook2Id = PrePriceBookId; // AAH--Pricebook2Id
                pBEntry.Product2Id = prod.Id; // AAQ--Product2Id
                pBEntry.UnitPrice = prod.Price__c; // 1000
                bookEntryList.add(pBEntry);
                system.debug('@@@@'+pBEntry);
            }
            if(!bookEntryList.isEmpty()){
                insert bookEntryList; // new record id generate
                system.debug('input'+bookEntryList);
            }
        }
    }
    if (trigger.isAfter){
        if(trigger.isUpdate){
            set <Id> product2Ids = new set <Id>();
            // List <Product2> productList =([SELECT Id,name,Price__c from Product2]);
            for(product2 prod : trigger.new){
                if(prod.Price__c!=null){
                    if(prod.Price__c!=Trigger.oldMap.get(prod.Id).price__c){
                        product2Ids.add(prod.id);
                    }
                }
            }
            if(!product2Ids.isEmpty()){
                List <PricebookEntry> PbEntryNewPrice = new List <PricebookEntry>();
                List <PricebookEntry> pBEntryList =([SELECT Id,Product2Id, Pricebook2Id, Name, UnitPrice from PricebookEntry where Id IN: product2Ids]);
                for(product2 prd : trigger.New){
                    for(PricebookEntry pBook : pBEntryList){
                        pBook.UnitPrice=prd.Price__c;
                    }    
                }
                if(!PbEntryNewPrice.isEmpty()){
                    update PbEntryNewPrice;
                }
            }
        }
    }
}