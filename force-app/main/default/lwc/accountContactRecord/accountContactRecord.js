import { LightningElement,track,wire,api } from 'lwc';
import getContactOfAcc from '@salesforce/apex/AccountsContController.getContactOfAcc';

export default class AccountContactRecord extends LightningElement {
    
    @track columns = [
        { label: 'Id', fieldName: 'Id'},
        { label: 'Name', fieldName: 'Name'},
        { label: 'Phone', fieldName: 'Phone'},
        { label: 'AccountId', fieldName: 'AccountId'}
    ];
    @api recordId;
    @track searchKey;
    @track accounts;
    @track error;
    
        @wire(getContactOfAcc,{AccIds: '$recordId'})

        wiredAccounts({data, error}){
            console.log('data');
            if(data) {
                this.accounts =data;
                this.error = undefined;
            }else {
                console.log('Error');
                this.accounts =undefined;
                this.error = error;
            }
        }
        handleKeyChange(event){
            this.searchKey = event.target.value;
        }
}