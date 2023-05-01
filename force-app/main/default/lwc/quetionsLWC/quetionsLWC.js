import { LightningElement ,track,wire,api} from 'lwc';
import getQuesData from '@salesforce/apex/EventRecordCtrl.getQuesData';
import { FlowAttributeChangeEvent,FlowNavigationNextEvent} from 'lightning/flowSupport';
export default class QuetionsLWC extends LightningElement {
    @api EvtNameFromMain;
    @track eventQuesResult;

     @wire(getQuesData, { evtId: '$EvtNameFromMain' })
  WireContactRecords({ error, data }) {
  
    if (data) {
      this.eventQuesResult = data;
      alert(JSON.stringify(this.eventQuesResult));
      this.error = undefined;
    } else {
      this.error = error;
      this.contacts = undefined;
    }
  }
}