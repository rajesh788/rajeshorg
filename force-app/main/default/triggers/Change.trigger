trigger Change on Account (before insert) {
    if (trigger.isinsert){
        if (trigger.isafter) {
            List<contact>conList=new List<contact>();
            for (Account accObj : trigger.New) {
                contact conObj = new contact();
                conObj.FirstName='Info';
                conObj.LastName='Default';
                conObj.Email='info@websitedomail.ltd';
                conList.add(conObj);
            }
            
            if (conList.size()>0) {
                insert conList;
            }
        }
    }
}