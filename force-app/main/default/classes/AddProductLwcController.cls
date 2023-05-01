public class AddProductLwcController {
    @AuraEnabled
    public static List <WrapperProductDetails> getPriceBookEntry(){
        List<WrapperProductDetails> wrapList = new List<WrapperProductDetails>();
        List <pricebookEntry> pbEntryList = [select id,name,ProductCode,UnitPrice,Product2.Description,Product2.Family from pricebookEntry];
        for(pricebookEntry pb : pbEntryList ){
            wrapList.add(new WrapperProductDetails(pb.Name,pb.ProductCode,pb.UnitPrice,pb.Product2.Description,pb.Product2.Family));
        }
        system.debug('@#@#@# '+wrapList);
        return wrapList;
    }
    
    @AuraEnabled
    public static List<string> productRecordsMethod(string recId) {
        system.debug('##### '+recId);
       return null; 
    }
    
    Public Class WrapperProductDetails {
        @AuraEnabled
        Public String prodName {get;set;}
        @AuraEnabled
        Public String PrdCode {get;set;}
        @AuraEnabled
        Public Decimal utPrice {get;set;}
        @AuraEnabled
        Public String Descript {get;set;}
        @AuraEnabled
        Public String fmly {get;set;}
        
        WrapperProductDetails(string prodName,String PrdCode,Decimal utPrice,string Descript ,String fmly){
            this.prodName = prodName;
            this.PrdCode =PrdCode;
            this.utPrice = utPrice;
            this.Descript = Descript;
            this.fmly = fmly;
        }
    }
}