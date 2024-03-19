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

            // meetingtitle: "", // predetermined title to be used for the meeting
            // subthemeid: "", // the booking platform subthemeid to preload the flow with for a custom flow
            // meetingid: "", // id of an existing meeting to preload the meeting flow with (initiates an edit meeting flow)
            // configid: "", // id of the sobject config (custom metadata)
            // disableheaders: false, // disable headers on screens in flow
            // disableshowavailabletimesascustomerfilter: false, // disable show available times as customer filter on the planner
            // advisortypewhitelist: "", // whitelist of possible advisor types ('SpecificAdvisors' | 'LocalAdvisors' | 'AllAdvisors')
            // disableadditionalcontacts: false, // disable the ability to add additional contacts to a meeting
            // disablecreaterecordcheckbox: false, // if true, removes the option to create a related record to to attach the meeting event to
            // disablecustommeetingtitle: false, // remove the option to enter a custom meeting title
            // removeclosebutton: false, // removes the close button from the meeting confirmation page
            // customflow: "", // name of the custom flow to use ("withtheme", "cancel", "update")
            // disableprogressbar: false, // remove the progressbar
            // disablecustomermeetings: false, // removes the screen that shows upcoming meetings for the customer
        };

        this.configRecord = {
            recordid: this.recordId,
            accountId: this.recordId,
            recordname: this.objectApiName,
            flexipageRegionWidth: this.flexipageRegionWidth,

            // meetingtitle: "", // predetermined title to be used for the meeting
            // subthemeid: "", // the booking platform subthemeid to preload the flow with for a custom flow
            // meetingid: "", // id of an existing meeting
            // configid: "", // id of the sobject config (custom metadata)
            // disableheaders: false, // disable headers on screens in flow
            // disableshowavailabletimesascustomerfilter: false, // disable show available times as customer filter on the planner
            // advisortypewhitelist: "", // whitelist of possible advisor types ('SpecificAdvisors' | 'LocalAdvisors' | 'AllAdvisors')
            // disableadditionalcontacts: false, // disable the ability to add additional contacts to a meeting
            // disablecreaterecordcheckbox: false, // if true, removes the option to create a related record to to attach the meeting event to
            // disablecustommeetingtitle: false, // remove the option to enter a custom meeting title
            // removeclosebutton: false, // removes the close button from the meeting confirmation page
            // customflow: "", // name of the custom flow to use ("withtheme", "cancel", "update")
            // disableprogressbar: false, // remove the progressbar
            // disablecustomermeetings: false, // removes the screen that shows upcoming meetings for the customer
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