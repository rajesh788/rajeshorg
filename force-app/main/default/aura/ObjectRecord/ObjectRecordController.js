({
    init : function(component, event, helper) {
        debugger;
        
        var action = component.get("c.getAllObject");
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                debugger;
                var result = response.getReturnValue();
                var listofObjects = [];
                for(var key in result){
                    listofObjects.push({key: key, value: result[key]});
                }
                component.set("v.allObject", listofObjects);
            }
        });
        $A.enqueueAction(action);
    },
    handleChange : function(component, event, helper){
        debugger;
        var action = component.get("c.getAllfieldsMtd");
        var options = [];
        console.log(component.get('v.selectedObject'));
        action.setParams({
            objectName : component.get('v.selectedObject')
            
        })
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS" ) {
                debugger;
                var result = response.getReturnValue();
                for(var i=0;i<result.length;i++){
                    console.log(result[i].label,result[i].value);
                    options.push({ label:result[i].label, value: result[i].value});
                }
                component.set("v.listOptions", options);
            }
        });
        $A.enqueueAction(action);
    },
    onChange: function (component, event) {
        // This returns all selected 'values'
        var selectedOptionValue = event.getParam("value"); // This works
        var selectedOptionLabel = event.getParam("label"); // 
        alert('selectedOptionValue'+selectedOptionValue);
        var action = component.get("c.getfieldsName");
        console.log( JSON.stringify(selectedOptionValue));
        action.setParams({
            selectFieldOpt : JSON.stringify(selectedOptionValue),
            objectName : component.get('v.selectedObject'),
        })
        action.setCallback(this, function(response) {
            debugger;
            var state = response.getState();
            if (state === "SUCCESS" ) {
                var result = response.getReturnValue();
                alert(result);
                console.log(result);
                component.set("v.records", result);
            }
        });
        $A.enqueueAction(action);
    },
    getQueryData: function (component, event) {
        alert('hello');
        component.set("v.truthy", !component.get("v.truthy"));
    }
})