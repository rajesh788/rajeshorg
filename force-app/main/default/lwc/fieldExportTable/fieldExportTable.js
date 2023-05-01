import { LightningElement, api, wire, track } from 'lwc';
import {publish, subscribe, MessageContext } from 'lightning/messageService';
import SearchTypeLMS from '@salesforce/messageChannel/SearchType__c';
import FilterRecLMS from '@salesforce/messageChannel/FilterRec__c';
import ExportRsltLMS from '@salesforce/messageChannel/ExportRslt__c';
export default class FieldExportTable extends LightningElement {


    @wire(MessageContext) messageContext;
    
    @track selectedType = [];
    @track exportDataRslt =[];
    @track dateStart;
    @track dateEnd;
    @track filterRslt;
    @track isDisplayTable;
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
        this.selectedClick();
    }
    getObjFields() {
        this.subscription = subscribe(this.messageContext, SearchTypeLMS, (message) => {
            console.log('message 19 ==> ', message.FieldResult);
            this.selectedType = message.FieldResult;
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
    selectedClick() {
            this.subscription2 = subscribe(this.messageContext,FilterRecLMS, (message) => {
                console.log('message .startDate 75 ==> ', message.startDate);
                console.log('message.endDate 76 ==> ', message.endDate);

                this.dateStart = message.startDate;
                this.dateEnd = message.endDate;
                    var allFields = JSON.stringify(this.selectedType);
                    var allFieldsParse = JSON.parse(allFields);
                    console.log('allFieldsParse 87 #@#@ ==> '+allFieldsParse);
                    var filterRslt = allFieldsParse.filter(element => element.CreatedInDate >= this.dateStart && element.CreatedInDate <= this.dateEnd);
                    console.log('filterRslt 89 #@#@ ==>> '+filterRslt);
                    this.selectedType = filterRslt;
                    publish(this.messageContext,ExportRsltLMS,{rsltFinal:this.selectedType});
                    console.log('Final',message.rsltFinal);
                 
            });
    }
    
}