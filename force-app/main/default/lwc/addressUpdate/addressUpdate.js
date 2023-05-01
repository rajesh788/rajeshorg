import { LightningElement,track,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class AddressUpdate extends LightningElement {
    @track isShowModal = false;
    @api recordId;

    showModalBox() {  
        this.isShowModal = true;
    }

    hideModalBox() {  
        this.isShowModal = false;
    }
    handleSuccess(event) {
        alert('hi');
    const fields = event.detail.fields;
   
}
handleSubmit(event) {
        alert('hi');
    const fields = event.detail.fields;
   
}
}