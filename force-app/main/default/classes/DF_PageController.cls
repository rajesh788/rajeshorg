public class DF_PageController {
    public List<sObject> lstObjs {get;set;}
    public List<string> lstFlds {get;private set;}
    
    public DF_PageController(){
        lstFlds = new List<String>();
		string query = 'select id, name, AccountNumber from Account limit 50';
        lstObjs = Database.query(query);
        
        Set<string> setFlds = new Set<String>();
        for(integer i=0;i<lstObjs.size();i++){
            setFlds.addAll(lstObjs[i].getPopulatedFieldsAsMap().keySet());
        }
        
        lstFlds.addAll(setFlds);
        system.debug(lstFlds);
    }
}