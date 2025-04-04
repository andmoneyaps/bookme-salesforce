public without sharing class AMBConfigMetadataDeployment implements Metadata.DeployCallback {
  private static String metadataName = 'AMB_SObject_Config.';
  private static String childMetadataName = 'AMB_Config_Field_Mapping.';

  public static void deployMetadata(List<Map<String, Object>> configs) {
    for (Integer i = 0; i < configs.size(); i++) {
      Map<String, Object> keyvaluePairs = new Map<String, Object>{
        'sObject_Type__c' => configs[i].get('sObject_Type__c'),
        'With_Sharing__c' => configs[i].get('With_Sharing__c')
      };
      String name = AMBConfigMetadataDeploymentUtil.generateRecordName(
        (String) configs[i].get('sObject_Type__c'),
        '',
        ''
      );
      Map<String, Map<String, Object>> childMetadataMappings = new Map<String, Map<String, Object>>();

      for (
        Map<String, Object> fieldMap : (List<Map<String, Object>>) configs[i]
          .get('fieldMappings')
      ) {
        Map<String, Object> mapping = new Map<String, Object>{
          'Source_Field_Name__c' => fieldMap.get('Source_Field_Name__c'),
          'Target_Field_Name__c' => fieldMap.get('Target_Field_Name__c'),
          'Util_Class_Name__c' => fieldMap.get('Util_Class_Name__c'),
          'Util_Method_Name__c' => fieldMap.get('Util_Method_Name__c'),
          'With_Security__c' => fieldMap.get('With_Security__c'),
          'AMB_SObject_Config__c' => name
        };

        String childName = AMBConfigMetadataDeploymentUtil.generateRecordName(
          (String) configs[i].get('sObject_Type__c'),
          (String) fieldMap.get('Source_Field_Name__c'),
          (String) fieldMap.get('Target_Field_Name__c')
        );
        childMetadataMappings.put(childName, mapping);
      }

      handleInsertAndUpdate(
        metadataName,
        name,
        name,
        keyValuePairs,
        childMetadataName,
        childMetadataMappings
      );
    }
  }

  public void handleResult(
    Metadata.DeployResult result,
    Metadata.DeployCallbackContext context
  ) {
    if (result.Status == Metadata.DeployStatus.Succeeded) {
      System.debug('success: ' + result);
    } else {
      System.debug('fail: ' + result);
    }
  }

  public static void handleInsertAndUpdate(
    String metadataName,
    String devName,
    String label,
    Map<String, Object> fieldWithValuesMap,
    String childMetadataName,
    Map<String, Map<string, Object>> childDevNameToFieldMapping
  ) {
    Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();
    customMetadata.fullName = metadataName + devName;
    customMetadata.label = label;

    for (String key : fieldWithValuesMap.keySet()) {
      Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();

      customField.field = key;
      customField.value = fieldWithValuesMap.get(key);
      customMetadata.values.add(customField);
    }

    Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();

    if (childMetadataName != null && childDevNameToFieldMapping != null) {
      for (String childKey : childDevNameToFieldMapping.keySet()) {
        Metadata.CustomMetadata childMetadata = new Metadata.CustomMetadata();
        childMetadata.fullName = childMetadataName + childKey;
        childMetadata.label = childKey;

        for (
          String mapKey : childDevNameToFieldMapping.get(childKey).keySet()
        ) {
          Metadata.CustomMetadataValue childValue = new Metadata.CustomMetadataValue();

          childValue.field = mapKey;
          childValue.value = childDevNameToFieldMapping.get(childKey)
            .get(mapKey);
          childMetadata.values.add(childValue);
        }

        mdContainer.addMetadata(childMetadata);
      }
    }

    mdContainer.addMetadata(customMetadata);
    AMBConfigMetadataDeployment callback = new AMBConfigMetadataDeployment();
    Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
  }
}
