import { LightningElement, api, wire, track } from 'lwc';
import {publish, subscribe, MessageContext } from 'lightning/messageService';
import SearchTypeLMS from '@salesforce/messageChannel/SearchType__c';
// import FilterRecLMS from '@salesforce/messageChannel/FilterRec__c';
import ExportRsltLMS from '@salesforce/messageChannel/ExportRslt__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import OpenRangeSectionLMS from '@salesforce/messageChannel/OpenRangeSection__c';
//import firstResultLMS from '@salesforce/messageChannel/resetResult__c';

export default class FieldExportTable extends LightningElement {
    
    @wire(MessageContext)
    messageContext; 
    
    @track selectedType = [];
    @track exportDataRslt =[];
    @track dateStart;
    @track dateEnd;
    @track filterRslt;
    @track isDisplayTable;
    @track isCreateChkBox = false;
    @track isModifyChkBox = false;
    @track isOpenDialogBx = false;
    @track endDateTime ;

    @track columns = [ { label: 'Label', fieldName: 'FieldLable' }, 
                        { label: 'DataType', fieldName: 'DataType' }, 
                        { label: 'ValueTypeId', fieldName: 'ValueType' }, 
                        { label: 'Length', fieldName: 'Length' }, 
                        { label: 'Last Modified By', fieldName: 'LastModifyId' }, 
                        { label: 'Last Modified Date', fieldName: 'LastModifiedDt' }, 
                        { label: 'Created Date', fieldName: 'CreatedDate' }, 
                        { label: 'Created Name', fieldName: 'CreateName' }, 
    ];

    connectedCallback() {
        this.getObjFields();
        this.handleRemoveTable();
        this.getRangeSelectValue();
    }
    @track reset = [];
    getObjFields() {
        this.subscription = subscribe(this.messageContext, SearchTypeLMS, (message) => {
            console.log('message 19 ==> ', message.FieldResult);
            this.selectedType = message.FieldResult;
            this.reset = message.FieldResult;
            this.isDisplayTable = message.dataTableShow;
            console.log('this.selectedType #@#@#@==> ', this.selectedType);
            //console.log(' message.clearObjName =>  ',message.clearObjName);
        });
    }
    handleRemoveTable() {
        this.subscription = subscribe(this.messageContext, SearchTypeLMS, (message) => {
            console.log('message 19 33333333 ==> ', message.clearObjName);
            this.closeValue = message.clearObjName;
            if (this.closeValue == 'NullValue') {
                this.selectedType = [];
            }
        });
    }
    // Wed Nov 02 2022 17:59:10 GMT+0530 (India Standard Time)
    now = new Date();
    day = this.now.getDay() < 10 ? '0'+this.now.getDay() : this.now.getDay();
    month = (this.now.getMonth()+1);
    formatDate = this.now.getFullYear() +'-'+ this.month+'1'+'-'+this.day;


    
    handleStartChange(event) {
        this.startDateTime = event.target.value;
        console.log('startDateTime ' + this.startDateTime);
    }
    handleEndChange(event) {
        this.endDateTime = event.target.value;
        console.log('endDateTime '+this.endDateTime);
        console.log('CurrentDate '+this.formatDate);

        if(this.endDateTime > this.formatDate){
         this.endDateTime = ''; 
            const event = new ShowToastEvent({
                title: 'Wrong Date Entered',
                message: 'Given date is greater than the current date',
                variant: 'error',
                mode: 'dismissable'
            });
            this.dispatchEvent(event);        
        }
        console.log('endDateTime ' + this.endDateTime);
    }
    handleCreateChkBox(event) {
        this.isCreateChkBox = event.target.checked;
        console.log('@@@ '+this.isCreateChkBox );
    }
    handleModifyChkBox(event) {
        this.isModifyChkBox = event.target.checked;
        console.log('this.isModifyChkBox @@@ '+this.isModifyChkBox );
    }
    getFilterRecord() {
          alert('lpkoesj');
        if(this.startDateTime != null && this.startDateTime != '' && this.startDateTime != undefined 
                && this.endDateTime != null && this.endDateTime!= '' && this.endDateTime!= undefined){
        
            var allFields = JSON.stringify(this.selectedType);
            var allFieldsParse = JSON.parse(allFields);
            console.log('allFieldsParse 87 #@#@ ==> '+allFieldsParse);
                    console.log('this.isCreateChkBox #@# ',this.isCreateChkBox);
                    console.log('this.isModifyChkBox #@# ',this.isModifyChkBox);
           if(this.isCreateChkBox == true && this.isModifyChkBox == true){

            alert('Both are true ==>  ',this.isCreateChkBox +''+this.isModifyChkBox);
            var filterRslt = allFieldsParse.filter(element => element.CreatedInDate >= this.startDateTime && element.LastModifiedDate <= this.endDateTime);
            console.log('filterRslt 89 #@#@ ==>> '+filterRslt);
            this.selectedType = filterRslt;
            this.isShowFilterModel = false;
            publish(this.messageContext,ExportRsltLMS,{rsltFinal:this.selectedType});
            console.log('Final',message.rsltFinal);

          }else if(this.isCreateChkBox == true && this.isModifyChkBox == false){

            alert('create Date => ',this.isCreateChkBox);
            console.log('this.startDateTime @@ => ',this.startDateTime);
            console.log('this.endDateTime @@ => ',this.endDateTime);
            var filterRslt = allFieldsParse.filter(element => element.CreatedInDate >= this.startDateTime && element.CreatedInDate <= this.endDateTime);
            console.log('filterRslt 89 #@#@ ==>> '+filterRslt);
            this.selectedType = filterRslt;
            this.isShowFilterModel = false;
            publish(this.messageContext,ExportRsltLMS,{rsltFinal:this.selectedType});
            console.log('Final',message.rsltFinal);

          }else if(this.isCreateChkBox == false && this.isModifyChkBox == true) {

            alert('Modify => ',this.isModifyChkBox);
            var filterRslt = allFieldsParse.filter(element => element.LastModifiedDate >= this.startDateTime && element.LastModifiedDate <= this.endDateTime);
            console.log('filterRslt 89 #@#@ ==>> '+filterRslt);
            this.selectedType = filterRslt;
            this.isShowFilterModel = false;
            publish(this.messageContext,ExportRsltLMS,{rsltFinal:this.selectedType});
            console.log('Final',message.rsltFinal);
            
          } 
           
        }else{
            this.template.querySelectorAll('lightning-input').forEach(element => {
                element.reportValidity();
            });
        }
     }


    @track isShowFilterModel = false;
    // ===============================
    getRangeSelectValue() {
        this.subscription = subscribe(this.messageContext, OpenRangeSectionLMS,(message) => {
           console.log('message.OpenSection #@#@ => ',message.OpenSection);
            this.isShowFilterModel = message.OpenSection;
        });
    }
    closeModel(){
        console.log('Hiii 82 closeModel');
        this.isShowFilterModel = false;
    }
    openDialogBx(){
        this.isShowFilterModel = false;
        this.isOpenDialogBx = true;
    }
    cancelBtn(){
        this.isShowFilterModel = true;
        this.isOpenDialogBx = false;
    }
    handleConfirmClick(){
        this.selectedType = this.reset;
            this.isOpenDialogBx = false;
        this.isShowFilterModel = false;
        this.isDisplayTable = true;
        
    }

 
}