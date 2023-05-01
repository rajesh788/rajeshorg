import { LightningElement,api } from 'lwc';

export default class ContactCmp extends LightningElement {
@api firstname;
handleClick(event){
    this.dispatchEvent(new CustomEvent('parentupdate'));
}
}