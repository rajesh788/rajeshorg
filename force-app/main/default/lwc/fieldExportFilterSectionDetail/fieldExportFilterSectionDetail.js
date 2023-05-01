import { LightningElement,api,wire,track } from 'lwc';


import {publish,subscribe,MessageContext} from 'lightning/messageService';
import FilterRecLMS from '@salesforce/messageChannel/FilterRec__c';
import OpenRangeSectionLMS from '@salesforce/messageChannel/OpenRangeSection__c';

export default class FieldExportFilterSectionDetail extends LightningElement {
    startDateTime = '';
    endDateTime = '';
    @api strOutput;
    filterData;

    @wire(MessageContext)
    messageContext;
    @track isDisplayRange = false;

    handleStartChange(event) {
        this.startDateTime = event.target.value;
        console.log('startDateTime ' + this.startDateTime);
        //this.selectedDateTime();
    }
    handleEndChange(event) {
        this.endDateTime = event.target.value;
        console.log('endDateTime ' + this.endDateTime);
       // this.selectedDateTime();
    }

    selectedDateTime(){
        publish(this.messageContext,FilterRecLMS,{startDate:this.startDateTime,endDate:this.endDateTime});
        console.log('startDate ==> ', message.startDate);
        console.log('endDate ==> ', message.endDate);
    } 
    connectedCallback() {
        this.getRangeSelectValue();
    }
    getRangeSelectValue() {
        this.subscription = subscribe(this.messageContext, OpenRangeSectionLMS, (message) => {
            this.isDisplayRange = message.OpenSection;
            console.log('this.selectedType #@#@#@==> ', this.selectedType);
            //console.log(' message.clearObjName =>  ',message.clearObjName);
        });
    }
    hideFilterComp(){
        
        this.subscription2 = subscribe(this.messageContext, OpenRangeSectionLMS, (message) => {
            this.isDisplayRange = message.closeFilterSection;
            console.log('this.closeFilterSection #@#@#@==> ', this.closeFilterSection);
        });
    }
}