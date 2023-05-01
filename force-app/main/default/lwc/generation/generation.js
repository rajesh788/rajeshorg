import { LightningElement,track } from 'lwc';
import goApexRecord from '@salesforce/apex/SaveContactAcc.getAccount';

export default class Generation extends LightningElement {
    
companyFieldVal;
staFieldVal;
titleFieldVal;
nameFieldVal;
@track accRecord;

fstNmFieldVal;
lastNmFieldVal;
emailFieldVal;
phoneFieldVal;
@track allRecordAccAndCon;
@track conRecordArray=[];
listdata =[];
@track ConRecList = [
{   
    Id:null,           
    FirstName: '',
    LastName: '',
    Email: '',
    Phone:'',
}
];



@track isContactOpen = false;
@track isAccountOpen = true;

openModal() {
//alert('openModal');

// to open modal set isModalOpen track value as true
this.isContactOpen = true;
this.isAccountOpen = false;
const fatchAccRecord = {Industry:this.companyFieldVal,Title:this.titleFieldVal,Status:this.staFieldVal,Name:this.nameFieldVal};

console.log('accountArray '+JSON.stringify(fatchAccRecord));
this.accRecord= JSON.stringify(fatchAccRecord);
//alert('accRecord '+this.accRecord);
}

keyIndex = 0;
@track itemList = [
{
id: 0
}
];

addRow() {
++this.keyIndex;
var newItem = [{ id: this.keyIndex }];
this.itemList = this.itemList.concat(newItem);

}

removeRow(event) {
if (this.itemList.length >= 2) {
this.itemList = this.itemList.filter(function (element) {
    return parseInt(element.id) !== parseInt(event.target.accessKey);
});
}
}
handleValueCmpy(event){
this.companyFieldVal=event.target.value;

}
handleValueStatus(event){
this.staFieldVal=event.target.value;

}
handleValueTitle(event){
this.titleFieldVal=event.target.value;

}
handleValueComnt(event){
this.nameFieldVal=event.target.value;

}

handleValueFname(event){
this.fstNmFieldVal=event.target.value;
}
handleValueLstname(event){
this.lastNmFieldVal=event.target.value;
}
handleValueEmail(event){
this.emailFieldVal=event.target.value;
}
handleValuePhone(event){
this.phoneFieldVal=event.target.value;
}

saveRec(event) {
//alert('saveRec');
const fatchConRecord = {FirstName:this.fstNmFieldVal,LastName:this.lastNmFieldVal,Email:this.emailFieldVal,Phone:this.phoneFieldVal};
this.conRecord= JSON.stringify(fatchConRecord);
//alert('conRecord '+this.conRecord);

//listdata.push(fatchConRecord);
this.conRecordArray.push(this.conRecord);
   // alert('conRecord Array '+this.conRecordArray);
    const saverecord =  {Account:this.accRecord,contacts:this.conRecordArray};
    const listOfObject = [];
    listOfObject.push(saverecord);
    alert('saverecord '+saverecord);
    this.allRecordAccAndCon =JSON.stringify(saverecord);
    
    
alert(this.allRecordAccAndCon);

goApexRecord({ AccConLst : JSON.stringify(listOfObject)}).then(result => {
   this.data = result;
   this.dispatchEvent(new ShowToastEvent({
    title: "Success!",
    message: "record is Saved",
   variant: "success",
        })  
    );
 })
}





}