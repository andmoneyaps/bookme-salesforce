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
  
    @track
    _config = {};

    @wire(getRecord, { recordId: USER_ID, fields: [CONTACT_ID] })
    user({ error, data }) {
        if(data) {
            this.config = {
                accountId: this.recordId,
                contactId: getFieldValue(data, CONTACT_ID),
                recordname: this.objectApiName,
                flexipageRegionWidth: this.flexipageRegionWidth,
                // subthemeid: "", // the booking platform subthemeid to preload the flow with for a custom flow
                // customeremail: "", // initialize the flow with a prefilled customer email
                // disablecancelmeeting: false, // disable the option for the customer to cancel a meeting in the flow
                // disablereschedulemeeting: false // disable the option for the customer to reschedule a meeting in the flow
                // configOverride: { advisorOptionWhitelist: ["PrimaryAdvisor", "OtherAdvisors"], meetingTypeWhitelist: ["Physical", "Online", "Telephone", "OffSite"] }, // Defines an object of whitelisted advisor options and meeting types
                // removeclosebutton, // removes the close button from the meeting confirmation page
                // configid: "", // id of the sobject config (custom metadata)
                // meetingid: "", // id of an existing meeting to preload the meeting flow with (initiates an edit meeting flow)
                // customflow: "", // name of the custom flow to use ("withtheme", "cancel", "update")
                // disableprogressbar: false, // remove the progressbar from the flow
                // disablecustomermeetings: false, // removes the screen that shows upcoming meetings for the customer
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