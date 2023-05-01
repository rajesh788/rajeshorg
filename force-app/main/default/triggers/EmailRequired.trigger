// Trigger for Email is required on Contact object.

trigger EmailRequired on Contact (before insert) {
    if(trigger.isInsert) {
        EmailRequiredHelper.beforeMtd(trigger.new);
        }
    }