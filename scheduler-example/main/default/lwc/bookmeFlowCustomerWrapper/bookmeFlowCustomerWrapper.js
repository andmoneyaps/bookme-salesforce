import { LightningElement, api, track, wire } from "lwc";
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import CONTACT_ID from "@salesforce/schema/User.ContactId";

// this gets you the logged in user
import USER_ID from "@salesforce/user/Id";

export default class BookmeFlowCustomerWrapper extends LightningElement {
    @api recordId; //get it from input in config
    @api accountId;
    @api objectApiName; //same as above but with record name
    @api flexipageRegionWidth; // used to make component width aware, and dependent on were it is inserted, values: SMALL/MEDIUM/LARGE
    @api eventId;
  
    @api
    availableActions = [];
  
    @track
    _config = {};

    @wire(getRecord, { recordId: USER_ID, fields: [CONTACT_ID] })
    user({ error, data }) {
        if(data) {
            this.config = {
                recordid: this.recordId,
                accountId: this.recordId,
                contactId: getFieldValue(data, CONTACT_ID),
                recordname: this.objectApiName,
                flexipageRegionWidth: this.flexipageRegionWidth,
                disableprogressbar: true, 
                removeclosebutton: true,
                configid: 'TemplateConfig'
            };
        }
        else if(error) {
            console.log('Error: ', error);
        }
    };

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