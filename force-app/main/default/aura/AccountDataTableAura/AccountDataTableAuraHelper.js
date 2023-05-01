({
getContactRecords : function(component) {
var action = component.get("c.getContacts");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {
                console.log('result'+response.getReturnValue());
                console.log('result',response.getReturnValue());
                component.set('v.contactRecords',response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
}
})