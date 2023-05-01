trigger scenario1 on Account (before insert) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            for(Account accRec : Trigger.new){
                if(accRec.ShippingCity == null){
                    accRec.ShippingCity = accRec.BillingCity;
                }
                if(accRec.ShippingCountry == null){
                    accRec.ShippingCountry = accRec.BillingCountry;
                }
                if(accRec.ShippingState == null){
                    accRec.ShippingState = accRec.BillingState;
                }
                if(accRec.ShippingStreet == null){
                    accRec.ShippingStreet = accRec.BillingStreet;
                }
                if(accRec.ShippingPostalCode== null){
                    accRec.ShippingPostalCode = accRec.BillingPostalCode;
                }
            }
        }
    }
}