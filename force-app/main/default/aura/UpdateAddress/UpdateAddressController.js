({
    doInit : function(component, event, helper) {
        var action = component.get("c.getAddressRec");    
        var artId = component.get("v.recordId");
        console.log(artId);
        action.setParams({"recordId":artId});
        action.setCallback( this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.ac", response.getReturnValue());
                console.log(response.getReturnValue());
            }
        });
        // Queue this action to send to the server
        $A.enqueueAction(action);
    },
    
    handleClose : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire() 
    },
       
    handleOnSubmit : function(component, event, helper) {
        var objectData={
            state:component.get("v.stateAt"),
            country:component.get("v.countryAt"),
            postalCode:component.get("v.postalAt"),
            city : component.get("v.cityAt"),
            street:component.get("v.streetAt")
        };
        console.log('@@@@@@@@@@@'+JSON.stringify(objectData));
        var records = component.get("v.objectData");
        var artId = component.get("v.recordId");
        var action = component.get("c.getAddressData");
        action.setParams({"ObjData":JSON.stringify(objectData),"recId":artId});
        $A.enqueueAction(action);
        
       /* event.preventDefault(); //Prevent default submit
        var eventFields = event.getParam("fields"); //get the fields
        alert('eventFields '+JSON.stringify(eventFields));
        eventFields["Description"] = 'Lead was created from Lightning RecordEditForm'; //Add Description field Value
        component.find('leadCreateForm').submit(eventFields); //Submit Form
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            mode: 'sticky',
            message: 'This is a required message',
            messageTemplate: 'Record {0} created! See it {1}!',
            messageTemplateData: ['Salesforce', {
                url: 'http://www.salesforce.com/',
                label: 'here',
            }
                                 ]
        });
        toastEvent.fire();*/
        $A.get("e.force:closeQuickAction").fire() 
    },
    streetChange: function(component, event, helper){
       // var myAttri = component.find("myStreet").get("v.value");
       // console.log(myAttri);
        component.set("v.streetAt",component.find("myStreet").get("v.value"));
    },
    cityChange: function(component, event, helper){
       // var myAttri = component.find("myCity").get("v.value");
       // console.log(myAttri);
        component.set("v.cityAt",component.find("myCity").get("v.value"));
    },
    stateChange: function(component, event, helper){
      //  var myAttri = component.find("myState").get("v.value");
      //  console.log(myAttri);
        component.set("v.stateAt",component.find("myState").get("v.value"));
    },
    postalChange: function(component, event, helper){
        //var myAttri = component.find("myPostal").get("v.value");
        //console.log(myAttri);
        component.set("v.postalAt",component.find("myPostal").get("v.value"));
    },
    CountryChange: function(component, event, helper){
        //var myAttri = component.find("myCountry").get("v.value");
        //console.log(myAttri);
        component.set("v.countryAt",component.find("myCountry").get("v.value"));
    },
    
    
    
    
})