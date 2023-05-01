import {LightningElement} from 'lwc';

export default class bikeCard extends LightningElement{

name = 'Hero';

description = 'A nice bike build for comfort';

category = 'BiCycle';

material = 'Steel';

price = '100000';

pictureURL = 'https://s3-us-west-1.amazonaws.com/sfdc-demo/ebikes/electrax4.jpg';



ready = false;

connectedCallback(){

setTimeout(() =>{

this.ready = true;

}, 3000)

}

}