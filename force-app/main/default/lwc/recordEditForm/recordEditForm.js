import { LightningElement,api } from 'lwc';
//import NAME_FIELD from '@salesforce/schema/Contact.Name';

export default class RecordEditForm extends LightningElement {
   //nameField = [NAME_FIELD];

    // Flexipage provides recordId and objectApiName
    @api recordId;
    @api objectApiName;
  }