({
	 getProductList: function(component) {
        var action = component.get('c.getProdDetails');
        var self = this;
        action.setCallback(this, function(actionResult) {
            component.set('v.products', actionResult.getReturnValue());
            
           console.log(JSON.stringify(actionResult.getReturnValue()));
        });
        $A.enqueueAction(action);
    },
    getBackProductLst: function(component) {
        var action = component.get('c.getProdDetails');
        var self = this;
        action.setCallback(this, function(actionResult) {
            component.set('v.products', actionResult.getReturnValue());
            
           console.log(JSON.stringify(actionResult.getReturnValue()));
        });
        $A.enqueueAction(action);
    }
})