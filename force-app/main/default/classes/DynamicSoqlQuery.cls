public class DynamicSoqlQuery {
    list<sobject> records;
    public string sobj { get; set;}
    public string cols;
    public string condition;
    list<string> fields = new list<string>();
    
    public DynamicSoqlQuery(){
        string query = '';
        sobj = 'account';
        system.debug(query);
    }
    
    public list<selectoption> getSobjlist(){
        list<selectoption> opt = new list<selectoption>();
        opt.add(new selectoption('account','Account'));
        opt.add(new selectoption('contact','Contact'));
        return opt;
    }
    
    public void dummy(){
        
    }
    
    public list<sobject> getRecords(){
        cols = 'id, name';
        
        string query = 'select '+ cols+' from '+sobj;
        records = Database.query(query);
        system.debug('records==@'+records);
        return records;
    }

}