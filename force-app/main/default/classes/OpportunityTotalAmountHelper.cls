public class OpportunityTotalAmountHelper {
    public static void afterInsert(List<Opportunity> oppList){  
        set<Id>accountIds = new set <Id>();
        Map<Id,List<Opportunity>> mapOfAccIdOpps = New Map <Id,List<Opportunity>>();
        for(Opportunity opp : oppList){
            if(opp.AccountId!=null && opp.Amount!=null){
                accountIds.add(opp.AccountId); 
            }
        }
        if(!accountIds.isEmpty()){
            Decimal SumOfOppAmount=0;
            
            List<Opportunity> opptyList = new List<Opportunity>();
            opptyList=([SELECT Id,AccountId,name,Amount from Opportunity where AccountId In:accountIds]);
            for(Opportunity opp: opptyList){
                if(!mapOfAccIdOpps.containsKey(opp.accountId)){
                    mapOfAccIdOpps.put(opp.AccountId,new List<Opportunity>());
                }
                mapOfAccIdOpps.get(opp.AccountId).add(opp);
            }
            List<Account> accountList = new List <Account>();
            accountList=([select id,Opp_amount_total__c from account where Id In:accountIds]);
            for(Account acc : accountList){
                List<Opportunity> tempOpptyList = new List<Opportunity>();
                tempOpptyList=mapOfAccIdOpps.get(acc.id);
                for(Opportunity opp : tempOpptyList ){
                    if(opp.Amount!=null){
                        SumOfOppAmount+=Opp.Amount;
                    }
                        
                    
                }
            }
            
               
     			           
        }
    }
    public static void afterUpdate(List<Opportunity> oppList,Map<id,Opportunity>oldMap){  
    }
}