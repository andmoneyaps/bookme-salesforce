# BookMe Salesforce konfiguration

This repository contains setup for the BookMe Salesforce products.
It contains examples of how to configure the scheduler and present products, with stub implementations of the various Callable interfaces.

## Scheduler

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

Examples of employee and customer flow wrappers can be found in this repo.

### Metadata configuration of BookMe scheduler

OBS: Your classes implementing the Callable interface, used for configuration of bookMe scheduler, must be be set to global classes.

- *AMB Meeting Configuration* - Create a new record of this type to enable configuration of the meeting's title and the displayed locations. This requires reference to an Apex class that implements the Callable interface. In the record, specify the Callable implementation's class name and the action name to call. An example of a Callable implementation is found in this repo (*BookMeMeetingConfiguration*).

- *Booking Platform DI Implementation* - Create a new record of this type to enable configuration of the booking platform's DI implementation. This requires reference to an Apex class that implements the Callable interface. In the record, specify the Callable implementation's class name. Examples of implementations can be found in this repo such as *BookMeCompetenceProvider*, *BookMeSearchProvider* and *BookMeSlaProvider*

- *AMB Brand Setting* - create records to specify the styling theme to be used for both the employee and customer flows. The record should contain the name of the theme. These default to the 'AndMoney' theme if not specified.

- *AMB Config*, *AMB SObject Config*, *AMB Config Relation*, *AMB Config Field Mapping*  - Together, these metadata types definions configurations for what and how standard sObjects are created and updated in the booking flow. The *AMB Config* record is the main configuration record, and it references the *AMB SObject Config* record, which in turn references the *AMB Config Field Mapping* record. The *AMB Config Relation* record is used to define the relationship between the sObjects. An example of these metadata types is found in this repo. The script *AMBConfigDeploymentScript* can be used to deploy these configurations to a Salesforce org. For each field mapping, a utility method can be specified to be used for the mapping of between the DTO and the SObject field. The utility method must be within a global class - and example implementation of the callable interface can be found in *BookMeConfigCallable* - and the name of the actions are the ones specified on the *AMB Config Field Mapping* records.
