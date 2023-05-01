import {
    LightningElement,
    track,
    api
} from 'lwc';
import sentToApex from '@salesforce/apex/invoiceCreate.createInvoiceRec';
import NoHeaderCSS from '@salesforce/resourceUrl/NoHeader';
import {loadStyle} from 'lightning/platformResourceLoader';
import { NavigationMixin } from 'lightning/navigation';


export default class Invoice extends NavigationMixin(
    LightningElement
) {
    contactFieldVal;
    invoiceDate;
    invoiceStart
    invoiceEnd;
    @track InvoiceRecord;
    @track isLoading = false;
    contactId;
    @api isLoaded = false;
    connectedCallback() {
        this.parameters = this.getQueryParameters();
        console.log(this.parameters);
        this.contactId= this.parameters.c__recordId;
        loadStyle(this, NoHeaderCSS)
            .then(result => {});
    }
    handleValueContact(event) {
        this.contactFieldVal = event.target.value;
    }
    handleValueInvDt(event) {
        this.invoiceDate = event.target.value;
    }
    handleValueStartDt(event) {
        this.invoiceStart = event.target.value;
    }
    handleValueEndDt(event) {
        this.invoiceEnd = event.target.value;
    }
    saveInvoice(event) {
        
        this.isLoading = true;
        
       /* this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'invoice'
            },
            state: {
                id: this.InvoiceRecord
            }
        });
        alert('saveInvoice');
        alert(this.invoiceStart);*/
        const fatchInvoiceRec = {
            Contact__c: this.contactId,
            Invoice_Date__c: this.invoiceDate,
            Invoice_Start_Date__c: this.invoiceStart,
            Invoice_End_Date__c: this.invoiceEnd
        };
        this.InvoiceRecord = JSON.stringify(fatchInvoiceRec);
        console.log('fatchInvoiceRec ' + this.InvoiceRecord);

        sentToApex({
            invoiceRec: JSON.stringify(fatchInvoiceRec)
        }).then(result => {
            this.data = result;
            console.log('@@@# '+this.data)
            this.isLoading = false;
            // Navigate to View Account Page
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: result,
                        objectApiName: 'Invoice_Object__c',
                        actionName: 'view'
                    },
                });

        })
        
    }
    closeModal(event) {
        history.back(); 
    }
    getQueryParameters() {

        var params = {};
        var search = location.search.substring(1);

        if (search) {
            params = JSON.parse('{"' + search.replace(/&/g, '","').replace(/=/g, '":"') + '"}', (key, value) => {
                return key === "" ? value : decodeURIComponent(value)
            });
        }

        return params;
    }
}