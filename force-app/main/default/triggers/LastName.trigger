/*trigger LastName on Account (before insert) {
if (trigger.isbefore)
for(Account acb:trigger.new) {
if(string.isEmpty(acb.site)) {
acb.Adderror('Name is required');
}


}
}*/

trigger LastName on Account (after insert) {
    if (trigger.isInsert){
        if (trigger.isAfter){
            List<Contact> conList = new List<Contact>();
            for(Account acc : trigger.new) {
                contact con = new contact();
                con.AccountId = acc.Id;
                con.LastName = acc.Name;
                con.Email = acc.Email_Address__c;
                conList.add(con);
            }
            if(conList.size()>0) {
                Insert conList;
            }
        }
    }
}