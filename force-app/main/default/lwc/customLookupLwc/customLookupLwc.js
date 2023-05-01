import {
    LightningElement,
    api,
    wire,
    track
} from 'lwc';
import fetchLookupData from '@salesforce/apex/CustomLookupLwcController.fetchLookupData';
import getFieldsinfo from '@salesforce/apex/CustomLookupLwcController.getFieldDetails';
import getAccountDataToExport from '@salesforce/apex/CustomLookupLwcController.fetchLookupData';

import {getRecord} from 'lightning/uiRecordApi';
const DELAY = 300; // dealy apex callout timing in miliseconds  
export default class CustomLookupLwc extends LightningElement {
    // public properties with initial default values 
    @api Label = 'Object Details';
    @api placeholder = 'Search...';
    @api iconName = 'standard:account';
    @api sObjectApiName = 'Account';
    @api defaultRecordId = '';
    @track objectFields = [];
    @track objectFieldsFilter = [];
    @track isOpen = false;
    today = new Date();
    startDateTime = '';
    endDateTime = '';
    @track range;
    filterCmp = true;
    mainCmp = true;
    @track dataFilter = [];
    strInput;
    @track searchValue;

    @track columns = [

        {
            label: 'Label',
            fieldName: 'FieldLable'
        },
        {
            label: 'DataType',
            fieldName: 'DataType'
        },
        {
            label: 'ValueTypeId',
            fieldName: 'ValueType'
        },
        {
            label: 'Length',
            fieldName: 'Length'
        },
        {
            label: 'Last Modified By',
            fieldName: 'LastModifyId'
        },
        {
            label: 'Last Modified Date',
            fieldName: 'LastModifiedDt'
        },
        {
            label: 'Created Date',
            fieldName: 'CreatedDate'
        },
        {
            label: 'Created Name',
            fieldName: 'CreateName'
        },
    ];
    searchTerm;
    @track valueObj;
    href;
    @track options; //lookup values
    @track isValue;
    @track blurTimeout;
    @track objectData = {}
    columnHeader = ['Label', 'Data Type', 'Value Type', 'Length', 'LastModified By', 'Last Modified Date', 'Created Date', 'Created Name']
    @wire(getAccountDataToExport)
    wiredData({
        error,
        data
    }) {
        if (data) {
            console.log('Records----- ' + data);
            this.objectData = data;
            console.log('Records Object--------' + this.objectData);
        } else if (error) {
            console.log('Error------' + error);
        }
    }
    // private properties 
    lstResult = []; // to store list of returned records   
    hasRecords = true;
    searchKey = ''; // to store input field value    
    isSearchLoading = false; // to control loading spinner  
    delayTimeout;
    selectedRecord = {}; // to store selected lookup record in object formate 
    // initial function to populate default selected lookup record if defaultRecordId provided  
    connectedCallback() {
        if (this.defaultRecordId != '') {
            fetchDefaultRecord({
                recordId: this.defaultRecordId,
                'sObjectApiName': this.sObjectApiName
            })
                .then((result) => {
                    if (result != null) {
                        this.selectedRecord = result;
                        this.handelSelectRecordHelper(); // helper function to show/hide lookup result container on UI
                    }
                })
                .catch((error) => {
                    this.error = error;
                    this.selectedRecord = {};
                });
        }
    }
    // wire function property to fetch search record based on user input
    @wire(fetchLookupData, {
        searchKey: '$searchKey'
    })
    searchResult(value) {
        console.log(value);
        const {
            data,
            error
        } = value; // destructure the provisioned value
        this.isSearchLoading = false;
        if (data) {
            this.hasRecords = data.length == 0 ? false : true;
            this.lstResult = JSON.parse(JSON.stringify(data));
        } else if (error) {
            console.log('(error---> ' + JSON.stringify(error));
        }
    };
    //To get preselected or selected record
    @wire(getRecord, {
        recordId: '$valueId',
        fields: FIELDS
    })
    wiredOptions({
        error,
        data
    }) {
        if (data) {
            this.lstResult = data;
            this.error = undefined;
            this.valueObj = this.record.fields.Name.value;
            this.href = '/' + this.record.id;
            this.isValue = true;
            console.log("this.href", this.href);
            console.log("this.record", JSON.stringify(this.record));
        } else if (error) {
            this.error = error;
            this.record = undefined;
            console.log("this.error", this.error);
        }
    }
    // update searchKey property on input field change  
    handleKeyChange(event) {
        // Debouncing this method: Do not update the reactive property as long as this function is
        // being called within a delay of DELAY. This is to avoid a very large number of Apex method calls.
        this.isSearchLoading = true;
        window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value;
        this.delayTimeout = setTimeout(() => {
            this.searchKey = searchKey;
        }, DELAY);
    }
    // method to toggle lookup result section on UI 
    toggleResult(event) {

        const lookupInputContainer = this.template.querySelector('.lookupInputContainer');
        const clsList = lookupInputContainer.classList;
        const whichEvent = event.target.getAttribute('data-source');
        switch (whichEvent) {
            case 'searchInputField':
                clsList.add('slds-is-open');
                break;
            case 'lookupContainer':
                clsList.remove('slds-is-open');
                break;
        }
    }
    // method to clear selected lookup record  
    handleRemove() {
        this.searchKey = '';
        this.selectedRecord = {};
        this.lookupUpdatehandler(undefined); // update value on parent component as well from helper function 
        // remove selected pill and display input field again 
        const searchBoxWrapper = this.template.querySelector('.searchBoxWrapper');
        searchBoxWrapper.classList.remove('slds-hide');
        searchBoxWrapper.classList.add('slds-show');
        const pillDiv = this.template.querySelector('.pillDiv');
        pillDiv.classList.remove('slds-show');
        pillDiv.classList.add('slds-hide');
        this.isOpenDataTable = false;
        this.isOpenFilterIcon = false;
        this.objectFields =null;
    }
    handleStartChange(event) {
        this.startDateTime = event.target.value;
        console.log('startDateTime ' + this.startDateTime);

    }
    handleEndChange(event) {
        this.endDateTime = event.target.value;
        console.log('endDateTime ' + this.endDateTime);

    }

    //initialize boolean with false always


    // method to update selected record from search result 
    handelSelectedRecord(event) {
        var objId = event.target.getAttribute('data-recid'); // get selected record Id 
        getFieldsinfo({
            objectName: objId
        })
            .then(result => {
                this.objectFields = result;
                this.strInput = result;
                console.log('result', result);
                console.log('this.strInput', this.strInput);
                this.isOpenFilterIcon = true;
                this.isOpenDataTable = true;
            })
            .catch(error => {
                this.error = error;
            });
        this.selectedRecord = this.lstResult.find(data => data.value === objId); // find selected record from list 
        this.lookupUpdatehandler(this.selectedRecord); // update value on parent component as well from helper function 
        this.handelSelectRecordHelper(); // helper function to show/hide lookup result container on UI
    }
    /*COMMON HELPER METHOD STARTED*/
    handelSelectRecordHelper() {
        this.template.querySelector('.lookupInputContainer').classList.remove('slds-is-open');
        const searchBoxWrapper = this.template.querySelector('.searchBoxWrapper');
        searchBoxWrapper.classList.remove('slds-show');
        searchBoxWrapper.classList.add('slds-hide');
        const pillDiv = this.template.querySelector('.pillDiv');
        pillDiv.classList.remove('slds-hide');
        pillDiv.classList.add('slds-show');
    }
    // send selected lookup record to parent component using custom event
    lookupUpdatehandler(value) {
        const oEvent = new CustomEvent('lookupupdate', {
            'detail': {
                selectedRecord: value
            }
        });
        this.dispatchEvent(oEvent);
    }
    exportData() {
        // Prepare a html table
        if (this.objectFields != null && this.objectFields != undefined && this.objectFields != '') {
            console.log('this.objectFields #@# ',this.objectFields);
            console.log('Hiiii');
            let doc = '<table>';
            // Add styles for the table
            doc += '<style>';
            doc += 'table, th, td {';
            doc += '    border: 1px solid black;';
            doc += '    border-collapse: collapse;';
            doc += '}';
            doc += '</style>';
            // Add all the Table Headers
            doc += '<tr>';
            this.columnHeader.forEach(element => {
                doc += '<th>' + element + '</th>'
            });
            doc += '</tr>';
            // Add the data rows
            console.log('objectFields ' + JSON.stringify(this.objectFields));
            this.objectFields.forEach(field => {
                doc += '<tr>';
                doc += '<th>' + field.FieldLable + '</th>';
                doc += '<th>' + field.DataType + '</th>';
                doc += '<th>' + field.ValueType + '</th>';
                doc += '<th>' + field.Length + '</th>';
                doc += '<th>' + (field.LastModifyId == undefined ? " " : field.LastModifyId) + '</th>';
                doc += '<th>' + (field.LastModifiedDt == undefined ? " " : field.LastModifiedDt) + '</th>';
                doc += '<th>' + (field.CreatedDate == undefined ? " " : field.CreatedDate) + '</th>';
                doc += '<th>' + (field.CreateName == undefined ? " " : field.CreateName) + '</th>';
                doc += '</tr>';
            });
            doc += '</table>';
            console.log('Doc  ', doc);
            var element = 'data:application/vnd.ms-excel,' + encodeURIComponent(doc);
            let downloadElement = document.createElement('a');
            console.log('downloadElement ' + downloadElement);
            downloadElement.href = element;
            downloadElement.target = '_self';
            // use .csv as extension on below line if you want to export data as csv
            downloadElement.download = 'Object Data.xls';
            document.body.appendChild(downloadElement);
            downloadElement.click();
        }else{
            console.log('else #@@@#@ ');
        }
    }
    @track isOpenFilterIcon = false;
    @track isOpenDataTable = false;
    // =========================
    fetchValue(event) {

        console.log('Value from Child LWC is ' + event.detail);
        this.objectFields = event.detail;
        console.log('this.strOutput ==>>  ' + this.objectFields);
    }
    // =========================
    @track isOpenFilterBox = false;

    handleFilterIcon() {
        this.isOpenDataTable = false;
        this.isOpenFilterBox = true;

    }
}