// Template for how to setup configs through the metadata deployment class
// replace sobject type and underlying fieldmappings with whatever is needed
List<Map<String, Object>> configs = new List<Map<String,Object>>{

    // EVENT
    new Map<String, Object> {
        'andmoney__sObject_Type__c' => 'Event',
        'andmoney__With_Sharing__c' => false,
        'fieldMappings' => new List<Map<String,Object>>{
            new Map<String,Object>{
                'andmoney__Source_Field_Name__c' => 'startDate',
                'andmoney__Target_Field_Name__c' => 'StartDateTime',
                'andmoney__Util_Class_Name__c' => '',
                'andmoney__Util_Method_Name__c' => '',
                'andmoney__With_Security__c' => false
            },
            new Map<String,Object>{
                'andmoney__Source_Field_Name__c' => 'endDate',
                'andmoney__Target_Field_Name__c' => 'EndDateTime',
                'andmoney__Util_Class_Name__c' => '',
                'andmoney__Util_Method_Name__c' => '',
                'andmoney__With_Security__c' => false
            },
            new Map<String,Object>{
                'andmoney__Source_Field_Name__c' => 'meetingTitle',
                'andmoney__Target_Field_Name__c' => 'Subject',
                'andmoney__Util_Class_Name__c' => '',
                'andmoney__Util_Method_Name__c' => '',
                'andmoney__With_Security__c' => false
            },
            new Map<String,Object>{
                'andmoney__Source_Field_Name__c' => 'description',
                'andmoney__Target_Field_Name__c' => 'Description',
                'andmoney__Util_Class_Name__c' => '',
                'andmoney__Util_Method_Name__c' => '',
                'andmoney__With_Security__c' => false
            },
            new Map<String,Object>{
                'andmoney__Source_Field_Name__c' => 'location',
                'andmoney__Target_Field_Name__c' => 'Location',
                'andmoney__Util_Class_Name__c' => '',
                'andmoney__Util_Method_Name__c' => '',
                'andmoney__With_Security__c' => false
            },
            new Map<String,Object>{
                'andmoney__Source_Field_Name__c' => 'advisor',
                'andmoney__Target_Field_Name__c' => 'OwnerId',
                'andmoney__Util_Class_Name__c' => 'BookMeConfigCallable',
                'andmoney__Util_Method_Name__c' => 'getAdvisorUserIdFromEmail',
                'andmoney__With_Security__c' => false
            },
            new Map<String,Object>{
                'andmoney__Source_Field_Name__c' => '',
                'andmoney__Target_Field_Name__c' => 'ShowAs',
                'andmoney__Util_Class_Name__c' => 'BookMeConfigCallable',
                'andmoney__Util_Method_Name__c' => 'getShowAsValue',
                'andmoney__With_Security__c' => false
            },
            new Map<String,Object>{
                'andmoney__Source_Field_Name__c' => '',
                'andmoney__Target_Field_Name__c' => 'IsAllDayEvent',
                'andmoney__Util_Class_Name__c' => 'BookMeConfigCallable',
                'andmoney__Util_Method_Name__c' => 'getIsAllDayEvent',
                'andmoney__With_Security__c' => false
            },
            new Map<String,Object>{
                'andmoney__Source_Field_Name__c' => 'eventDetailsId',
                'andmoney__Target_Field_Name__c' => 'andmoney__AMB_Event_Detail__c',
                'andmoney__Util_Class_Name__c' => '',
                'andmoney__Util_Method_Name__c' => '',
                'andmoney__With_Security__c' => false
            }
        }

    },


    // OPPORTUNITY
    new Map<String, Object>{
        'andmoney__sObject_Type__c' => 'Opportunity',
        'andmoney__With_Sharing__c' => false,
        'fieldMappings' => new List<Map<String,Object>>{
            new Map<String, Object>{
                'andmoney__Source_Field_Name__c' => 'meetingTitle',
                'andmoney__Target_Field_Name__c' => 'Name',
                'andmoney__Util_Class_Name__c' => '',
                'andmoney__Util_Method_Name__c' => '',
                'andmoney__With_Security__c' => false
            },
            new Map<String, Object>{
                'andmoney__Source_Field_Name__c' => 'accountId',
                'andmoney__Target_Field_Name__c' => 'AccountId',
                'andmoney__Util_Class_Name__c' => '',
                'andmoney__Util_Method_Name__c' => '',
                'andmoney__With_Security__c' => false
            },
            new Map<String, Object>{
                'andmoney__Source_Field_Name__c' => 'advisor',
                'andmoney__Target_Field_Name__c' => 'OwnerId',
                'andmoney__Util_Class_Name__c' => 'BookMeConfigCallable',
                'andmoney__Util_Method_Name__c' => 'getAdvisorUserIdFromEmail',
                'andmoney__With_Security__c' => false
            },
            new Map<String, Object>{
                'andmoney__Source_Field_Name__c' => 'endDate',
                'andmoney__Target_Field_Name__c' => 'CloseDate',
                'andmoney__Util_Class_Name__c' => 'BookMeConfigCallable',
                'andmoney__Util_Method_Name__c' => 'getOpportunityCloseDate',
                'andmoney__With_Security__c' => false
            },
            new Map<String, Object>{
                'andmoney__Source_Field_Name__c' => 'description',
                'andmoney__Target_Field_Name__c' => 'Description',
                'andmoney__Util_Class_Name__c' => '',
                'andmoney__Util_Method_Name__c' => '',
                'andmoney__With_Security__c' => false
            },
            new Map<String, Object>{
                'andmoney__Source_Field_Name__c' => '',
                'andmoney__Target_Field_Name__c' => 'StageName',
                'andmoney__Util_Class_Name__c' => 'BookMeConfigCallable',
                'andmoney__Util_Method_Name__c' => 'getOpportunityStageName',
                'andmoney__With_Security__c' => false
            }
        }
    }

    // LEAD
    new Map<String,Object>{
        'sObject_Type__c' => 'Lead',
        'With_Sharing__c' => false,
        'fieldMappings' => new List<Map<String,Object>>{
            new Map<String, Object>{
                'Source_Field_Name__c' => 'description',
                'Target_Field_Name__c' => 'Description',
                'Util_Class_Name__c' => '',
                'Util_Method_Name__c' => '',
                'With_Security__c' => false
            },
            new Map<String, Object>{
                'Source_Field_Name__c' => 'advisor',
                'Target_Field_Name__c' => 'Email',
                'Util_Class_Name__c' => 'BookMeConfigCallable',
                'Util_Method_Name__c' => 'getAdvisorEmail',
                'With_Security__c' => false
            },
            new Map<String, Object>{
                'Source_Field_Name__c' => 'advisor',
                'Target_Field_Name__c' => 'FirstName',
                'Util_Class_Name__c' => 'BookMeConfigCallable',
                'Util_Method_Name__c' => 'getAdvisorFirstName',
                'With_Security__c' => false
            },
            new Map<String, Object>{
                'Source_Field_Name__c' => 'advisor',
                'Target_Field_Name__c' => 'LastName',
                'Util_Class_Name__c' => 'BookMeConfigCallable',
                'Util_Method_Name__c' => 'getAdvisorLastName',
                'With_Security__c' => false
            },
            new Map<String, Object>{
                'Source_Field_Name__c' => 'advisor',
                'Target_Field_Name__c' => 'OwnerId',
                'Util_Class_Name__c' => 'BookMeConfigCallable',
                'Util_Method_Name__c' => 'getAdvisorUserIdFromEmail',
                'With_Security__c' => false
            },
            new Map<String, Object>{
                'Source_Field_Name__c' => '',
                'Target_Field_Name__c' => 'Company',
                'Util_Class_Name__c' => 'BookMeConfigCallable',
                'Util_Method_Name__c' => 'getCompanyName',
                'With_Security__c' => false
            },
            new Map<String, Object>{
                'Source_Field_Name__c' => 'accountId',
                'Target_Field_Name__c' => 'FinServ__RelatedAccount__c',
                'Util_Class_Name__c' => '',
                'Util_Method_Name__c' => '',
                'With_Security__c' => false
            }
        }
    },
};


AMBConfigMetadataDeployment.deployMetadata(configs);
