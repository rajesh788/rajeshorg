({
    doInit : function(component, event, helper) {
        
        // Prepare the action to load account record
        var action = component.get("c.getAccount");
        action.setParams({"accountId": component.get("v.recordId")});
        
        // Configure response handler
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                component.set("v.account", response.getReturnValue());
            } else {
                console.log('Problem getting account, response state: ' + state);
            }
        });
        $A.enqueueAction(action);
    },
    
    handleSaveOpportunity: function(component, event, helper) {
        if(helper.validateOpportunityForm(component)) {
            
            // Prepare the action to create the new opportunity
            var saveOpportunityAction = component.get("c.saveOpportunityWithAccount");
            saveOpportunityAction.setParams({
                "opportunity": component.get("v.newOpportunity"),
                "accountId": component.get("v.recordId")
            });
            
            // Configure the response handler for the action
            saveOpportunityAction.setCallback(this, function(response) {
                var state = response.getState();
                if(state === "SUCCESS") {
                    
                    // Prepare a toast UI message
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "title": "Opportunity Saved",
                        "message": "The new opportunity was created."
                    });
                    
                    // Update the UI: close panel, show toast, refresh account page
                    $A.get("e.force:closeQuickAction").fire();
                    resultsToast.fire();
                    $A.get("e.force:refreshView").fire();
                }
                else if (state === "ERROR") {
                    system.debug('Problem saving opportunity, response state: ' + state);
                }
                    else {
                        console.log('Unknown problem, response state: ' + state);
                    }
            });
            
            // Send the request to create the new opportunity
            $A.enqueueAction(saveOpportunityAction);
        }
        
    },
    findAmt: function(component, event) {
        var searchKey = component.find("inputValue").get("v.value");
        console.log('searchKey : ', searchKey);
        //var action = component.get("c.findByAmt");
        component.set('v.amnt',searchKey);
        
        var action = component.get("c.findAmt");
        action.setParams({
            amnt: searchKey
        });
        action.setCallback(this, function(a) {
            component.set("v.amnt", a.getReturnValue());
            component.set("v.amnt", searchKey); 
        });
    },
    
    doSomething: function(component, event, helper) {
        var getConID=component.find("selectConID").get("v.value");
        console.log('getConID'+getConID);
        
        var getRole=component.find("selectRole").get("v.value");
        console.log('getRole'+getRole);
        
        var action = component.get("c.getContactName");
        
        var cname = getConID;
        component.set("v.conName",cname);
        console.log('cname'+cname);
        
        var rolenm = getRole;
        component.set("v.roleName",rolenm);
        
        var action = component.get("c.getContactRole");
        action.setParams({
            searchKey: value
        });
        
        action.setCallback(this, function(a) {
            component.set("v.conName", a.getReturnValue());
            component.set("v.roleName", rolenm); 
            
        });
        $A.enqueueAction(action);
    }
})