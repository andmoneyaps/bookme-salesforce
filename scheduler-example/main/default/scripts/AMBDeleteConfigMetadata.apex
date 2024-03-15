
String sObjectConfigDeveloperName = 'Opportunity_8436';

if (String.isBlank(sObjectConfigDeveloperName)) {
    return;
}

List<andmoney__AMB_SObject_Config__mdt> sobjectConfigs = [
    SELECT Id, andmoney__sObject_Type__c, andmoney__With_Sharing__c, DeveloperName
    FROM andmoney__AMB_SObject_Config__mdt
    WHERE DeveloperName = :sObjectConfigDeveloperName
];

List<Id> sObjectConfigMetadataIds = new List<Id>();
for (andmoney__AMB_SObject_Config__mdt config : sobjectConfigs) {
    sObjectConfigMetadataIds.add(config.Id);
}

// read list of 
List<andmoney__AMB_Config_Relation__mdt> configRelations = [
    SELECT andmoney__AMB_Config__c, andmoney__AMB_SObject_Config__c, DeveloperName
    FROM andmoney__AMB_Config_Relation__mdt
    WHERE andmoney__AMB_SObject_Config__c in :sObjectConfigMetadataIds
];


List<andmoney__AMB_Config_Field_Mapping__mdt> fieldMappings = [
    SELECT
        DeveloperName,
        andmoney__AMB_SObject_Config__r.Id,
        andmoney__Source_Field_Name__c,
        andmoney__Target_Field_Name__c,
        andmoney__Util_Class_Name__c,
        andmoney__Util_Method_Name__c,
        andmoney__With_Security__c
    FROM andmoney__AMB_Config_Field_Mapping__mdt
    WHERE andmoney__AMB_SObject_Config__c IN :sObjectConfigMetadataIds
];

List<String> fieldsMappingsToDelete = new List<String>();

for (andmoney__AMB_Config_Field_Mapping__mdt fieldMapping : fieldMappings) {
    fieldsMappingsToDelete.add('andmoney__AMB_Config_Field_Mapping__mdt.' + fieldMapping.DeveloperName);
}

List<String> SObjectConfigRelationsToDelete = new List<String>();

for (andmoney__AMB_Config_Relation__mdt configRelation : configRelations) {
    SObjectConfigRelationsToDelete.add('andmoney__AMB_Config_Relation__mdt.' + configRelation.DeveloperName);
}

List<String> SObjectConfigsToDelete = new List<String>();

for (andmoney__AMB_SObject_Config__mdt sObjectConfig : sobjectConfigs) {
    SObjectConfigsToDelete.add('andmoney__AMB_SObject_Config__mdt.' + sObjectConfig.DeveloperName);
}


// TODO: Figure out how to access this class
MetadataService.MetadataPort service = new MetadataService.MetadataPort();

service.deleteMetadata(fieldsMappingsToDelete);
service.deleteMetadata(SObjectConfigRelationsToDelete);
service.deleteMetadata(SObjectConfigsToDelete);