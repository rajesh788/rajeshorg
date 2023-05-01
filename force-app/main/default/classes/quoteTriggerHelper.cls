public class quoteTriggerHelper {
    public static void beforeDeleteMtd(List<Quote> quoteList){
        set <Id> qtOppIds = new Set <Id> ();
        for(Quote qtObj : quoteList){
            if(qtObj.OpportunityId!=null){
                qtOppIds.add(qtObj.OpportunityId);
            }
        }
        system.debug('qtOppIds '+qtOppIds);
        if(!qtOppIds.isEmpty()){
            List <Opportunity> oppList = [select Id,name,StageName from opportunity where Id In : qtOppIds and StageName!='Open'];
            for(Opportunity oppObj : oppList ){
                oppObj.StageName = 'Open';
            }
            update oppList;
        }
    }
}