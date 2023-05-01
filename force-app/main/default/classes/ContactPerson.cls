public class ContactPerson {
    public list<Contact> conList{get;set;}
    public list<contact> findList {get;set;}
    
    
    public ContactPerson (){
        conlist=[SELECT FirstName, LastName, Phone FROM Contact];
        findList=new list<contact>();
        
        system.debug('Contact List'+conList);
    }
    public PageReference searchContacts()
    {
        findList = [SELECT FirstName, LastName, Phone FROM Contact];
        return null;
    }
    
    
}