import { LightningElement,api, track, wire} from 'lwc';
import getAccounts1 from '@salesforce/apex/getRecordDataController.getAccounts';

export default class GetDataDisplayData extends LightningElement {
    @api recordId;
    
     @track columns = [
          { label: 'Id', fieldName: 'Id' },
          { label: 'LastName', fieldName: 'LastName'},
          { label: 'Phone', fieldName: 'Phone'}
      ];
     @track accountList;

     //Method 2
     @wire (getAccounts1,{ recordId: '0015j00000dJa7CAAS'}) wiredAccounts({data,error}){
          if (data) {
               this.accountList = data;
          console.log(data); 
          } else if (error) {
          console.log(error);
          }
     }
}