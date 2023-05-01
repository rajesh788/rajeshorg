public class AccountDataController {
    @auraenabled
    Public Static List<Contact> getContacts(){
        return [SELECT LastName,Phone,Email FROM Contact ORDER BY createdDate ASC];
    }
    @auraenabled
     public static List < Contact > fetchContact(String searchKeyWord) {
            String searchKey = + searchKeyWord + '%';
             return [SELECT LastName,Phone,Email FROM Contact where Name LIKE: searchKey LIMIT 50];
        }
    }