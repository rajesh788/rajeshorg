public class GetAccount {
    Public List<Account> listOfAccounts{get;set;}
    public GetAccount (){
        listOfAccounts=[SELECT id,name,AccountNumber, Phone, BillingCity, CreatedDate from account limit 20];
    }
}