# BookMe Salesforce konfiguration

This repository contains setup for the BookMe Salesforce products.
There are examples of how to configure the scheduler and present products, with stuv implementations of the various Callable interfaces.

When implementing scheduler, create a wrapper component for the `andmoney-bookme-employee-flow` and the `andmoney-bookme-customer-flow` components to configure the flows.
An example of a wrapper is found in this repo. To configure the flow, pass a config object to the bookme employee or customer flow. 
It should look something like this:

```
config = {
    meetingtitle: "", // predetermined title to be used for the meeting
    subthemeid: "", // the booking platform subthemeid to preload the flow with for a custom flow
    meetingid: "", // id of an existing meeting
    configid: "", // id of the sobject config (custom metadata)
    accountId: "", // id of the account
    contactId: "", // id of the contact
    disableheaders: false, // disable headers on screens in flow
    disableshowavailabletimesascustomerfilter: false, // disable show available times as customer filter on the planner
    advisortypewhitelist: "", // whitelist of possible advisor types ('SpecificAdvisors' | 'LocalAdvisors' | 'AllAdvisors')
    recordid: "", // id of the record of the current record page
    recordname: "" // name of the type of sobject the current record page is showing
    disableadditionalcontacts: false, // disable the ability to add additional contacts to a meeting
    disablecreaterecordcheckbox: false, // if true, removes the option to create a related record to to attach the meeting event to
    disablecustommeetingtitle: false, // remove the option to enter a custom meeting title
    removeclosebutton: false, // removes the close button from the meeting confirmation page
    customflow: "", // name of the custom flow to use ("withtheme", "cancel", "update")
    disableprogressbar: false, // remove the progressbar
    disablecustomermeetings: false, // removes the screen that shows upcoming meetings for the customer
}

// create a config object and set it like this 

<c-bookme-employee-flow config-override={your_config_object}></c-bookme-employee-flow> 
```