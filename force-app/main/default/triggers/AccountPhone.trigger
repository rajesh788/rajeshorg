// Trigger for phone number is required on Account object.

trigger AccountPhone on Account (before insert) {
    if (trigger.isInsert) {
        for (Account mob: trigger.New) {
            if(string.isEmpty(mob.Phone)) { 
                mob.Adderror('Phone number is required');
                
            }
        }
    }
}