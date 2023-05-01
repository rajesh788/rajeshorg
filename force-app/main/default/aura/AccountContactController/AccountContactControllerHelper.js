({
    //get Contact List from apex controller
    doInit : function(component, event, helper) {
        var action = component.get("c.getContactList");
        action.setCallback(this, function(result){
            var state = result.getState();
            if (component.isValid() && state === "SUCCESS"){
                component.set("v.contactList",result.getReturnValue());   
            }
        });
        $A.enqueueAction(action);
    },
     
    //Select all contacts
    handleSelectAllContacts: function(component, event, helper) {
        var getID = component.get("v.contactList");
        var checkvalue = component.find("selectAll").get("v.value");        
        var checkContact = component.find("checkContact"); 
        if(checkvalue == true){
            for(var i=0; i<checkContact.length; i++){
                checkContact[i].set("v.value",true);
            }
        }
        else{ 
            for(var i=0; i<checkContact.length; i++){
                checkContact[i].set("v.value",false);
            }
        }
    },
     
    //Process the selected contacts
    handleSelectedContacts: function(component, event, helper) {
        var contactList = component.get("v.contactList");
        var isSelectAll = component.get("v.isSelectAll");
         
        var selectedContacts = [];
         
        if(isSelectAll){
            selectedContacts = contactList;
        }
        else{
            var k = 0;
            for (var i=0; i<contactList.length; i++){
                var c = contactList[i];
                if(c.isSelected) {
                    selectedContacts[k] = c;
                    k++; 
                }     
            }
        }
         
        if(selectedContacts.length > 0){
            var contactRecords = JSON.stringify(selectedContacts);
            var action = component.get("c.processSelectedContacts");
            action.setParams({
                contactRecords : contactRecords
            });
            action.setCallback(this, function(result){
                var state = result.getState();
                if (component.isValid() && state === "SUCCESS"){
                    alert('Success in calling server side action');
                }
                else if(state == "ERROR"){
                    alert('Error in calling server side action');
                }
            });
            $A.enqueueAction(action);
        }
    }
})