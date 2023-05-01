trigger scenario2 on Account (After insert) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            List <Contact> conList = new List <Contact> ();
            for(Account accRec : Trigger.New){
                Contact con = new Contact();
                con.LastName = accRec.Name;
                con.AccountId = accRec.Id;
                conList.add(con);
            }
            if(conList.size()>0){
                insert conList;
            }
        }
    }
}