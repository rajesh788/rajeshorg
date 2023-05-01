import { LightningElement,api,wire,track} from 'lwc';

export default class FilterRec extends LightningElement {
    startDateTime = '';
    endDateTime = '';
    @api strOutput;
    filterData;

    handleStartChange(event) {
        this.startDateTime = event.target.value;
        console.log('startDateTime ' + this.startDateTime);
    }
    handleEndChange(event) {
        this.endDateTime = event.target.value;
        console.log('endDateTime ' + this.endDateTime);
    }
    handelFilterRecords() {
        var allFields = JSON.stringify(this.strOutput);
         console.log('allFields ', allFields);
         var allFieldsParse = JSON.parse(allFields);
         console.log('allFieldsParse ', allFieldsParse);
         var filterRslt = allFieldsParse.filter(element => element.CreatedInDate >= this.startDateTime && element.CreatedInDate <= this.endDateTime);
         this.filterData = filterRslt;
         console.log('finalrsltChild ' + this.filterData);
         //create Event
         this.dispatchEvent( new CustomEvent( 'pass', {
            detail: this.filterData
        } ) );
        //  const searchEvent = new CustomEvent("getsearchvalue",{detail:this.filterData});
        //  console.log('Event ' + searchEvent);
        //  //Dispatch Event
        //  this.dispatchEvent(searchEvent);
      }
}