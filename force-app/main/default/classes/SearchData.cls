public class SearchData {
    
    public string qtext {get; set;}
    public list<string> fields {get;set;}
    public list<sObject> result {get;set;}
    public boolean showResult {get;set;}
    
    public SearchData(){
        showResult=false;
    }
    public pageReference runQuery(){
        fields =new List <string>();
        List<string>fieldList = qText.toLowerCase().substringBefore('from').substringAfter('select').split(',');
        for(string f:fieldList){
            f=f.trim();
            fields.add(f);
        }
        result=database.query(qText);
        showResult=true;
        return null;
    }
}