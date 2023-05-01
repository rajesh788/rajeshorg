public class ContactController {
     
   /* @AuraEnabled
    Public static List<ContactWrapper> getContactList(){
        List<ContactWrapper> contactList = new List<ContactWrapper>(); 
        //get all contact list
        List<Contact> conList = [SELECT Id, Name, Account.Name, Phone, Email FROM Contact LIMIT 10];
        for(Contact con : conList){
            ContactWrapper obj = new ContactWrapper();
            obj.ContactId = con.Id;
            obj.Name = con.Name;
            obj.Account = con.Account.Name;
            obj.Phone = con.Phone;
            obj.Email = con.Email;
            obj.isSelected = false; 
            contactList.add(obj);
        }
        return contactList;
    }
     
    @AuraEnabled
    Public static void processSelectedContacts(string contactRecords){
        system.debug('contactRecords-' + contactRecords);
        List<ContactWrapper> contactList = new  List<ContactWrapper>();
        if(!string.isBlank(contactRecords)){
            contactList = (List<ContactWrapper>)System.JSON.deserialize(contactRecords,List<ContactWrapper>.class);
            system.debug('contactList-' + contactList);
        }
    }
     
    public class ContactWrapper{
        @AuraEnabled
        public String ContactId {get;set;}
        @AuraEnabled
        public String Name {get;set;}
        @AuraEnabled
        public String Account {get;set;}
        @AuraEnabled
        public String Phone {get;set;}
        @AuraEnabled
        public String Email {get;set;}
        @AuraEnabled
        public boolean isSelected {get;set;}
    }*/
    /*  @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
       return [
            SELECT FirstName,LastName,Email
            FROM Contact
            WITH SECURITY_ENFORCED
            ORDER BY FirstName
        ];
    }*/
     @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts() {
      // The following line is used only for the last challenge
      throw new AuraHandledException('Forced error');
      // return [SELECT FirstName, LastName, Email FROM Contact WITH SECURITY_ENFORCED ORDER BY LastName, FirstName];
    }
}