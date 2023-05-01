public class ProductClassAura {
    @AuraEnabled
    public static List<WrapperProductDetails> getProdDetails() {
        List<WrapperProductDetails> wrapList = new List<WrapperProductDetails>();
        // Map<product2,List<PricebookEntry>> prodMap = new Map <product2,List<PricebookEntry>>();
	for(product2 pro : [select Id,name,productcode,Description,Family,(SELECT UnitPrice FROM PricebookEntries) from product2 limit 5]){
            for(PricebookEntry prpriceObj : pro.PricebookEntries ){
                wrapList.add(new WrapperProductDetails(pro, prpriceObj.UnitPrice,0));
                //break;
                integer i=1;
                System.debug(i++);
                //prodMap.put(pro,pro.PricebookEntries);
            }
        }        
        System.debug('wrapList 1 ---->  '+ wrapList);
        return wrapList;
    }
    @AuraEnabled
    public static List <WrapperProductDetails> findByName(String searchKey) {
        String name =  + searchKey + '%';
        List<WrapperProductDetails> wrapperList = new List<WrapperProductDetails>();
        for(product2 pro : [select name,productcode,Description,Family,(SELECT UnitPrice FROM PricebookEntries) from product2  WHERE Name LIKE: name]){
            for(PricebookEntry priceObj : pro.PricebookEntries){
                wrapperList.add(new WrapperProductDetails(pro, priceObj.UnitPrice,0));
                break;
            }
        }
        return wrapperList;
    }
    Public Class WrapperProductDetails {
        @AuraEnabled  
        Public Product2 productObj {get;set;}
        @AuraEnabled  
        Public Decimal priceDec{get;set;}
        @AuraEnabled 
        public decimal Quantity{get;set;}
        WrapperProductDetails(Product2 productObj, Decimal priceDec,decimal Quantity){
            this.productObj = productObj;
            this.priceDec = priceDec;
            this.Quantity=Quantity;
            System.debug('productObj ---->  '+ productObj);
            System.debug('priceDec ---->  '+ priceDec);
        }
    }
    @AuraEnabled 
    public static List<OpportunityLineItem> saveSelectedProd (String prodSelected) {
        system.debug('selectedProdJsonLst '+prodSelected);
        List <OpportunityLineItem> SelectedProdLst = new List <OpportunityLineItem>();
        String jsonInput = prodSelected;
        system.debug('jsonInput '+jsonInput);
        //system.debug('qtyValue '+qtyValue);
        Object result = JSON.deserializeUntyped(jsonInput);
        system.debug('result '+result);
        
        Map<String, Object> resultmap = (Map<String, Object>)JSON.deserializeUntyped(jsonInput);
        system.debug('resultmap '+resultmap);
        
        List<Object> inputList =( List<Object> ) resultmap.get('');
        
        
        
        
        
       
        
        
        List<JSON2Apex> data = JSON2Apex.parse(jsonInput);
        system.debug('data'+data);
        Map <Id,Id> pbEntryMap = new Map <Id,Id>();
        
        for(JSON2Apex dt : data ){
            OpportunityLineItem oppLineItem = new OpportunityLineItem ();
            oppLineItem.Product2Id = dt.productObj.Id;
            oppLineItem.UnitPrice=dt.priceDec;
           // oppLineItem.Quantity=
            oppLineItem.OpportunityId='0065j00000eIFCAAA4';
            
            oppLineItem.PriceBookEntryId=dt.productObj.PricebookEntries[0].Id;
            
            for(JSON2Apex.PricebookEntries  pricebook : dt.productObj.PricebookEntries){
                //System.debug(pricebook.Id+'----'+pricebook.Product2Id+'----'+pricebook.UnitPrice);
                pbEntryMap.put(pricebook.Product2Id,pricebook.Id);
            }
            system.debug('pbEntryMap@@@' + pbEntryMap);
            SelectedProdLst.add(oppLineItem); 
        }
        System.debug('--->'+data[0].productObj.PricebookEntries);
        system.debug('SelectedProdLst '+SelectedProdLst);
        insert SelectedProdLst;
        return null;
    }
}