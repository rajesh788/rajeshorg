import { LightningElement,track,wire,api } from 'lwc';
import getObjects from '@salesforce/apex/sObjectController.getObjects';
import getFields from '@salesforce/apex/sObjectController.getFields';
import setObjectToRecentItems from '@salesforce/apex/sObjectController.setObjectToRecentItems';



export default class SObjectFields extends LightningElement {
    @track objects = [];
    @track fields = [];
    @track searchKey = ""; 
    
    
  
   /* wiredMethod({ error, data }) {
        if (data) {
            this.dataArray = data;
            let tempArray = [];
            this.dataArray.forEach(function (element) {
                var option=
                {
                    label:element,
                    value:element
                };
                tempArray.push(option);
            });
            this.objects=tempArray;
        } else if (error) {
            this.error = error;
        }
    } 
    
   handleObjectChange(event)
    {   
        const selectedOption = event.detail.value;  
        getFields({ objectName: selectedOption})
        .then(result => {
            this.dataArray = result;
            let tempArray = [];
            this.dataArray.forEach(function (element) {
                var option=
                {
                    label:element.Label,
                    value:element.Name
                };
                tempArray.push(option);
            });
            this.fields=tempArray;
        })
        .catch(error => {
            this.error = error;
        });

    }
    handleFieldChange(){

    }

}*/
 


    @api name;
    @api variant = "label-hidden";
    @api fieldLabel;
    @api childObjectApiName;
    @api targetFieldApiName;
    @api value;
    @api required = false;
    @api addToRecent = false;

    handleChange(event) {
        let selectedEvent = new CustomEvent('valueselected', {detail: event.detail.value[0]});
        this.dispatchEvent(selectedEvent);

        if (this.addToRecent) {
            if (event.detail.value.length > 0 && event.detail.value[0].length > 0) {
                addToRecentItems({
                    recordId: event.detail.value[0]
                })
                    .catch(error => {
                        console.log(error);
                    });
            }
        }
    }

    @api reportValidity() {
        if(this.required) {
            this.template.querySelector('lightning-input-field').reportValidity();
        }
    }

}