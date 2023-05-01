({
    doInit : function(component, event, helper) {
        //  alert('init method');
        helper.getContactRecords(component);
        component.set('v.columns', [
            {label: 'LastName', fieldName: 'LastName', type: 'text'},
            {label: 'Email', fieldName: 'Email', type: 'text'},
            {label: 'Phone', fieldName: 'Phone', type: 'text'},
        ]);
            },
            searchKeyChange: function(component, event) {
            debugger;
            var searchKey = component.find("searchKey").get("v.value");
            console.log('searchKey:::::'+searchKey);
            var action = component.get("c.fetchContact");
            action.setParams({
            "searchKey": searchKey
            });
            action.setCallback(this, function(a) {
            component.set("v.contactRecords", a.getReturnValue());
            });
            $A.enqueueAction(action);
            } 
            })