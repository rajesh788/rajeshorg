public class UserTriggerHelper{
    public static void afterInsertUser(List<User> userLst,Map<Id,User>newMap){
        list<GroupMember> listGroupMember = new list<GroupMember>();
        List <Group> groupLst = [select id,name from Group where name =: newMap.values().Sales_Office__c];
        for(User usr : userLst){
            if(newMap.containsKey(usr.Id)){
                for(Group  grp : groupLst){
                    if(grp.Name == newMap.get(usr.id).Sales_Office__c){
                        GroupMember gm= new GroupMember();
                        gm.GroupId = grp.id;
                        gm.UserOrGroupId = usr.Id;
                        listGroupMember.add(gm);
                    }
                }
            }
            insert listGroupMember;
        }
    }
}