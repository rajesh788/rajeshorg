import { LightningElement,track,wire,api } from 'lwc';
import getObjects from '@salesforce/apex/DependencyController.getObjects';
import getApex from '@salesforce/apex/DependencyController.getApex';
import getLightningComponent from '@salesforce/apex/DependencyController.getLightningComponent';
import getDepdency from '@salesforce/apex/DependencyController.getDepdency';

const columnList = [
    { label: 'Metadata Component Name', fieldName: 'MetadataComponentName' },
    { label: 'Metadata Component Type', fieldName: 'MetadataComponentType' }
];

export default class Dependencynfo extends LightningElement {
    @track objectList= [];
    @track fieldList=[];
    @track fields=[];
    @track objectFields=[];
    @track rows=[];
    @track columns = columnList;
    @track apexList=[];
    @track compList=[];
    error;
    @track type = '';
    isApexSelected = false;
    isLightningSelected = false;
    isFieldSelected = false;
    selectedApex='';
    selectedComp='';
    object='';
    selectedField='';
    @api
    get types() {
        return [
            { label: 'Please Select', value: '' },
            { label: 'Apex Class', value: 'apex' },
            { label: 'Lightning Component', value: 'lightning' },
            { label: 'Field', value: 'field' },
        ];
    } 
    
    @wire(getObjects)
    wiredObject({ error, data }) {
        if (data) {
            var objs=data.Objects;
            this.objectFields=data.Fields;
            for(var i=0; i<this.objectFields.length; i++)  {
                var label=this.objectFields[i].TableEnumOrId;
                var id=this.objectFields[i].TableEnumOrId;
                    // To Get Label for Standard Object
                    var obj=objs.find(x => x.Id === this.objectFields[i].TableEnumOrId);
                    if(obj!=undefined){
                        label=obj.DeveloperName;
                    }
                //Check Duplicate Records
                var objFound=this.objectList.filter(x => x.label === label);
                if(objFound.length==0)
                {
                    this.objectList = [...this.objectList ,{value: id , label: label} ];
                }
            }
            this.error = undefined;
        } else if (error) {
            this.error = error;
        }
    }
   
    handleType(event)
    {
        this.type=event.detail.value;
        this.isFieldSelected=(this.type === 'field');
        this.isLightningSelected=(this.type === 'lightning');
        this.isApexSelected=(this.type === 'apex');
        if(this.isApexSelected)
        {
            this.getApexList();
        }
        if(this.isLightningSelected)
        {
            this.getComponentList();
        }
    }
    getApexList()
    {
        if(this.apexList.length==0)
        {
            getApex()
            .then(data => {
                if (data) {
                    for(var i=0; i<data.length; i++)  {
                        this.apexList = [...this.apexList ,{value: data[i].Id, label: data[i].Name} ];                                   
                    }   
                } else if (error) {
                    this.error = error;
                }
            })
            .catch(error => {
                this.error = error;
                console.log(error);
            });
        }
    }
    getComponentList()
    {
        if(this.compList.length==0)
        {
            getLightningComponent()
            .then(data => {
                if (data) {
                    for(var i=0; i<data.length; i++)  {
                        this.compList = [...this.compList ,{value: data[i].Id, label: data[i].DeveloperName} ];                                   
                    }    
                } else if (error) {
                    this.error = error;
                }
                console.log(JSON.stringify(this.compList));
            })
            .catch(error => {
                this.error = error;
                console.log(error);
            });
        }
    }
    handleObjectList(event)
    {   
        this.fieldList=[];
        const selectedOption = event.detail.value;  
        this.object=selectedOption;
        //Filter selected Object's Fields
        var fields=this.objectFields.filter(x => x.TableEnumOrId === selectedOption);
        for(var i=0; i<fields.length; i++)  {
            this.fieldList = [...this.fieldList ,{value: fields[i].Id, label: fields[i].DeveloperName} ];                                   
        }  
    }

    handleFieldList(event)
    {   
        this.selectedField= event.detail.value;  
        this.handleDependency(event.detail.value);
    }
    handleDependency(objectId)
    {
        getDepdency({ id: objectId})
        .then(data => {
            if (data) {
                this.fields=data;         
                this.error = undefined;
            } else if (error) {
                this.error = error;
            }
        })
        .catch(error => {
            this.error = error;
        });
    }

    handleFileDownload(event)
    {
        if(this.fields!==undefined)
        {
            let csvContent = "data:text/csv;charset=utf-8,";
            
            this.fields.forEach(function(rowArray) {
                let row = rowArray.MetadataComponentName+","+rowArray.MetadataComponentType+",";
                csvContent += row + "\r\n";
            });
            var encodedUri = encodeURI(csvContent);
            var link = document.createElement("a");
            link.setAttribute("href", encodedUri);
            link.setAttribute("download", "Dependent.csv");
            document.body.appendChild(link); 
            link.click();
        }
    }

    handleCompChange(event)
    {
       this.selectedComp=event.detail.value;
       this.handleDependency(event.detail.value);
    }
    handleApexChange(event)
    {
        this.selectedApex=event.detail.value;
        this.handleDependency(event.detail.value);
    }
}