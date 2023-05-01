import { LightningElement, api,track,wire } from 'lwc';

export default class AccountCmp extends LightningElement {
    firstname='Rajesh';
    handlechildevent(event){
        alert('parent');
    
    }
}