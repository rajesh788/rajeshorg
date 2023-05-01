//
trigger AccountAddressTrigger on Account (before insert,before update) {
    if (trigger.isBefore)
        for (Account abc :trigger.new) {
            if(string.isNotEmpty(abc.BillingPostalCode)) {
                if(abc.Match_Billing_Address__c == true) {
                    abc.ShippingPostalCode = abc.BillingPostalCode;  
                }
         
            }
        }
}