import {LightningElement} from 'lwc';

export default class sObjectRecord extends LightningElement {

    accountId;

    handleSelectedLookup(event) {
        this.accountId = event.detail;
    }

}