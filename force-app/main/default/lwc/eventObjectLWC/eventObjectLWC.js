import { LightningElement, wire, api, track } from 'lwc';
import { FlowAttributeChangeEvent, FlowNavigationNextEvent } from 'lightning/flowSupport';

import getEventLst from '@salesforce/apex/EventRecordCtrl.getAllEvent';

export default class EventObjectLWC extends LightningElement {
    @api NameInput;
    @api EmailInput;
    @api EvntNameInput;
    
    @track firstResult;
    @track options = [];
    @wire(getEventLst)

   

    connectedCallback() {
        this.getOptions();

    }

    getOptions() {
        getEventLst({})
            .then((result) => {
                console.log(JSON.stringify(result));
                let optArr = [];
                if (result) {
                    result.forEach(r => {
                        optArr.push({
                            label: r.label,
                            value: r.eventId,
                        });
                    });
                }
                this.options = optArr;
            })
            .catch((error) => {
                // handle Error
            });
    }



    handleEvntName(event) {
        this.EvntNameInput = event.detail.value;
        alert(this.EvntNameInput);
    }

    handleName(event) {
        this.nameValue = event.detail.value;
    }

    handleEmail(event) {
        this.EmailInput = event.detail.value;
    }

}