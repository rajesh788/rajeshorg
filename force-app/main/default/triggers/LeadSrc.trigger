//When Lead status is Working-Contacted then Phone, Mobile and Email is required.

trigger LeadSrc on Lead (before insert) {
    if(trigger.isBefore) {
        if(trigger.isInsert) {
            LeadHelper.beforeInsertMtd(trigger.new); 
        }
    }
}