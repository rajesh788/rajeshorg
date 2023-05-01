public class invoiceCreate {
    @AuraEnabled
    public static String createInvoiceRec (string invoiceRec){
        system.debug(invoiceRec);
        List <Invoice_Object__c> invoiceList = new List <Invoice_Object__c>();
        Invoice_Object__c invoiceLst = (Invoice_Object__c) System.JSON.deserialize(invoiceRec, Invoice_Object__c.class);
        system.debug('invoiceLst '+ invoiceLst);
        Invoice_Object__c InvoiceObj = new Invoice_Object__c();
        InvoiceObj.Invoice_Date__c = invoiceLst.Invoice_Date__c;
        system.debug('@@@@ '+InvoiceObj.Invoice_Date__c);
        InvoiceObj.Invoice_Start_Date__c = invoiceLst.Invoice_Start_Date__c;
        InvoiceObj.Invoice_End_Date__c = invoiceLst.Invoice_Start_Date__c.addDays(15);
        InvoiceObj.Contact__c = invoiceLst.Contact__c;
       // InvoiceObj.Name = 'ABC';
        system.debug('InvoiceObj '+InvoiceObj);
        Insert InvoiceObj;
        return InvoiceObj.Id;
    }
    
}