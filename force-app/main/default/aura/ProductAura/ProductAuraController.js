({    
    doInit: function(component, event, helper) {
        helper.getProductList(component);
        component.set("v.isProductScreen", true);
        component.set("v.displaySelectedProduct", false);
    },
    mainPage: function(component, event, helper) {
        
        component.set("v.isProductScreen", true);
        component.set("v.displaySelectedProduct", false);
        helper.getProductList(component);
    },
    searchKeyChange: function(component, event) {
        var searchKey = component.find("searchKey").get("v.value");
        console.log('searchKey@@'+searchKey);
        var action = component.get("c.findByName");
        action.setParams({
            "searchKey": searchKey
        });
        action.setCallback(this, function(a) {
            component.set("v.products", a.getReturnValue());
        });
        $A.enqueueAction(action);
    },
    moveSelectedRows: function (component, event) {
        
        //console.log('###'+ JSON.stringify(component.get("v.products")));
        var getRecordJSON = JSON.stringify(component.get("v.products"));
        
        //console.log('getRecordJSON'+getRecordJSON);
        var getRecParse = JSON.parse(getRecordJSON);
        var selectedRecord = [];
        for(var i=0; i<getRecParse.length; i++){
            //console.log(getRecParse[i]['Name']);
            //console.log('getRecParse',getRecParse[i].checked);
            if(getRecParse[i].checked){
                selectedRecord.push(getRecParse[i]);
            }
        }
        component.set('v.selectedRecord',selectedRecord);
        console.log('selectedRecord',selectedRecord)
        component.set('v.displaySelectedProduct',true);
        component.set('v.isProductScreen',false);
    },
 confirmButton: function (component, event) {
     alert('Hello');
        //console.log('###'+ JSON.stringify(component.get("v.products")));
        var getRecordJSON1 = JSON.stringify(component.get("v.selectedRecord"));
        console.log('getRecordJSON1'+getRecordJSON1);
        
       var getRecParse1 = JSON.parse(getRecordJSON1);
        var selectedRecord1 = [];
        for(var i=0; i<getRecParse1.length; i++){
                selectedRecord1.push(getRecParse1[i]);
        }
     console.log('@@@ '+JSON.stringify(selectedRecord1));
     var SelRecJson = JSON.stringify(selectedRecord1);
       component.set('v.selectedRecordCmp',SelRecJson);
        console.log('SelRecJson',SelRecJson)
        alert('Hello22')
      // component.set('v.displaySelectedProduct',false);
       // component.set('v.isProductScreen',false);
    },
    handleSave: function (cmp, event, helper) {
        alert('HandelSaveFunction');
        var selectedProdJsonLst = JSON.stringify(cmp.get("v.selectedRecordCmp"));       
        console.log('selectedProdJsonLst ##',selectedProdJsonLst);
         
        var recordParse = JSON.parse(selectedProdJsonLst);
        console.log('recordParse ##',recordParse);
        
        var confirmProdLst = [];
        for(var i=0; i<recordParse.length; i++){
            confirmProdLst.push(recordParse[i]);
        }
        //console.log('confirmProdLst ##',confirmProdLst);
      console.log('confirmProdLst ##',JSON.stringify(confirmProdLst));
        
        var action = cmp.get("c.saveSelectedProd");
       action.setParams({"prodSelected" : JSON.stringify(confirmProdLst)});
        //action.setParams({"prodSelected" :confirmProdLst});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS" ) {
                var result = response.getReturnValue();
                alert(result);
                console.log(result);
            }
        });
        $A.enqueueAction(action);
    },
     
})