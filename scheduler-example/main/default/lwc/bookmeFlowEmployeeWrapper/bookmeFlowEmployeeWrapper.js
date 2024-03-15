import { LightningElement, api, track } from "lwc";
import {
    FlowAttributeChangeEvent,
    FlowNavigationNextEvent,
} from 'lightning/flowSupport';

export default class BookmeFlowEmployeeWrapper extends LightningElement {
    @api recordId; //magically set, if within a record context
    @api accountId;
    @api objectApiName; //same as above but with record name
    @api flexipageRegionWidth; // used to make component width aware, and dependent on were it is inserted, values: SMALL/MEDIUM/LARGE
    @api eventId;
  
    @api
    availableActions = [];
  
    @track
    _config = {};

    connectedCallback() {
        this.configFlow = {
            recordid: this.recordId,
            accountId: this.accountId,
            recordname: this.objectApiName,
            flexipageRegionWidth: this.flexipageRegionWidth,
            disableprogressbar: true, 
            removeclosebutton: true
        };

        this.configRecord = {
            recordid: this.recordId,
            accountId: this.recordId,
            recordname: this.objectApiName,
            flexipageRegionWidth: this.flexipageRegionWidth,
            disableprogressbar: true, 
            removeclosebutton: true
        };

        this.config = this.objectApiName == 'Account' ? this.configRecord : this.configFlow;

        this.template.addEventListener("meetingbooked", (evt) => {
            const attributeChangeEvent = new FlowAttributeChangeEvent(
                'eventId',
                evt.detail    
            );
            this.dispatchEvent(attributeChangeEvent);
            // check if NEXT is allowed on this screen
            if (this.availableActions.find((action) => action === 'NEXT')) {
                // navigate to the next screen
                const navigateNextEvent = new FlowNavigationNextEvent();
                this.dispatchEvent(navigateNextEvent);
            }
  
        });

    }

    get config() {
        return this._config;
    }

    set config(val) {
        this._config = val;
    }

    get hasData() {
        return this._config && this._config.recordid;
    }
}