public class LeadHelper {
    
    public static void beforeInsertMtd(List<Lead>leadList){
        for (Lead lead1 : leadList){
            if(lead1.Status == 'Working - Contacted'){
                if(string.isEmpty(lead1.Phone)){
                    lead1.Phone.addError('Phone number is required'); 
                }
                if(string.isEmpty(lead1.Mobilephone)){
                    lead1.MobilePhone.addError('Mobile number is required'); 
                }
                if(string.isEmpty(lead1.Email)){
                    lead1.Email.addError('Email is required'); 
                }                   
            }   
        }
    }
}