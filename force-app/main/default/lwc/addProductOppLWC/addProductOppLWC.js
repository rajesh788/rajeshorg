import { LightningElement,track,wire,api } from 'lwc';
import getprodList from '@salesforce/apex/AddProductLwcController.getPriceBookEntry';
import getProductDetails from '@salesforce/apex/AddProductLwcController.productRecordsMethod';
export default class AddProductOppLWC extends LightningElement {
@api recordId;
@track isShowModal = true;
@track isOpenDataTable = true;
@track defaultProdRecord =[];
@api placeholder = 'Search Products...';
@track isShowNext=false;
@track checkSelectedProd = [] ;
@track prodRecords;
@track dataReceived;



@track columns = [
{ label: 'Name', fieldName: 'prodName' },
{ label: 'ProductCode', fieldName: 'PrdCode'},
{ label: 'UnitPrice', fieldName: 'utPrice'},
{ label: 'Description', fieldName: 'Descript'},
{ label: 'Family', fieldName: 'fmly'}
];

@track columnNextModal = [
{ label: 'Product', fieldName: 'prodName' },
{ label: 'Quantity', fieldName: '',editable: true },
{ label: 'Sales Price', fieldName: 'utPrice',editable: true },
{ label: 'Date', fieldName: '',editable: true,Type:Date },
{ label: 'Line Description', fieldName: '',editable: true }
];



showModalBox() {  
this.isShowModal = true;
}

hideModalBox() {  
alert('Hii');
this.isShowModal = false;
}

connectedCallback(){
  this.handelDefaultProd();
  this.handelRecordId();

}   
showNextModal() {  
this.isShowModal = false;
this.isOpenDataTable = false;
this.isShowNext = true;
var el = this.template.querySelector('lightning-datatable');
console.log(el);
this.checkSelectedProd  = el.getSelectedRows();
}

/*@wire(getProductDetails,({recId: '$recordId'}))
getProductDetails({data, error}){
    if(data){
        this.dataReceived = data;
        console.log('1234567890', this.dataReceived);
        console.log('recId', this.recId);
    }
    if(error){
        this.Error = error;
    }
}*/
handelDefaultProd(){
getprodList()
.then(result => {
this.defaultProdRecord = result;
this.error = undefined;
console.log('result '+JSON.stringify(result));
})
.catch(error => {
this.error = error;
this.defaultProdRecord = undefined;
});
}

handelRecordId() {
  getProductDetails()
        if (this.recordId != '') {
            productRecordsMethod({
                recId: this.recordId,
            })
                .then((result) => {
                    if (result != null) {
                        this.selectedRecord = result;
                    }
                })
                .catch((error) => {
                    this.error = error;
                });
        }
    }
  
}