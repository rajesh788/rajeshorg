public class AccountName {
    public list<Account> accList{get;set;}
    public AccountName(){
        accList = [Select Id,Name,phone,fax from account];
        System.debug('accList'+accList);
    }
}