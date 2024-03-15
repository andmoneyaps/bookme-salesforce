public without sharing class BookMeConfigMetadataDeployment implements Metadata.DeployCallback {
    private static String metadataName = 'andmoney__AMB_SObject_Config.';
    private static String childMetadataName = 'andmoney__AMB_Config_Field_Mapping.';
  
    // Takes a list of Maps, where each map defines the configuration for an sobject type
    // see AMBConfigDeploymentScript.apex for an example of how to call this method
    public static void deployMetadata(List<Map<String, Object>> configs) {
      for (Integer i = 0; i < configs.size(); i++) {
        Map<String, Object> keyvaluePairs = new Map<String, Object>{
          'andmoney__sObject_Type__c' => configs[i].get('andmoney__sObject_Type__c'),
          'andmoney__With_Sharing__c' => configs[i].get('andmoney__With_Sharing__c')
        };
        String name = generateRecordName(
          (String) configs[i].get('andmoney__sObject_Type__c'),
          '',
          ''
        );
        Map<String, Map<String, Object>> childMetadataMappings = new Map<String, Map<String, Object>>();
  
        for (
          Map<String, Object> fieldMap : (List<Map<String, Object>>) configs[i]
            .get('fieldMappings')
        ) {
          Map<String, Object> mapping = new Map<String, Object>{
            'andmoney__Source_Field_Name__c' => fieldMap.get('andmoney__Source_Field_Name__c'),
            'andmoney__Target_Field_Name__c' => fieldMap.get('andmoney__Target_Field_Name__c'),
            'andmoney__Util_Class_Name__c' => fieldMap.get('andmoney__Util_Class_Name__c'),
            'andmoney__Util_Method_Name__c' => fieldMap.get('andmoney__Util_Method_Name__c'),
            'andmoney__With_Security__c' => fieldMap.get('andmoney__With_Security__c'),
            'andmoney__AMB_SObject_Config__c' => name
          };
  
          String childName = generateRecordName(
            (String) configs[i].get('andmoney__sObject_Type__c'),
            (String) fieldMap.get('andmoney__Source_Field_Name__c'),
            (String) fieldMap.get('andmoney__Target_Field_Name__c')
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
  
    // required implementation of the Metadata.DeployCallback interface
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
  
    // inserts or updates custom metadata records and child records
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

    // Utility class to generate a unique name for a custom metadata record name
    private static String generateRecordName(
        String sObjectType,
        String sourceField,
        String targetField
    ) {
        // Combine the sObject type, source field, and target field into a single string
        // to be used as name for the record
        Integer sourceFieldLength = sourceField != null ? sourceField.length() : 0;
        Integer targetFieldLength = targetField != null ? targetField.length() : 0;
        String inputString =
        sObjectType +
        '_' +
        sourceField?.substring(0, Math.min(sourceFieldLength, 4)) +
        '_' +
        targetField?.substring(0, Math.min(targetFieldLength, 4));

        // Remove any non-alphanumeric characters from the input string
        // these arent allowed
        String alphanumericString = inputString.replaceAll('[^a-zA-Z0-9]', '');

        // Ensure that the resulting string begins with a letter
        // this is required for the name of a custom metadata record
        if (!Pattern.matches('[a-zA-Z]', alphanumericString.substring(0, 1))) {
        alphanumericString = 'a' + alphanumericString;
        }

        // Replace any consecutive underscores with a single underscore
        // this is required for the name of a custom metadata record
        alphanumericString = alphanumericString.replaceAll('_+', '_');

        // Ensure that the resulting string does not end with an underscore
        // this is required for the name of a custom metadata record
        if (alphanumericString.endsWith('_')) {
        alphanumericString = alphanumericString.substring(
            0,
            alphanumericString.length() - 1
        );
        }

        // append a unique identifier to the end of the string
        // name must be unique
        alphanumericString += generateUniqueIdentifier();

        return alphanumericString;
    }

    private static String generateUniqueIdentifier() {
        // Generate a random number and append it to the name
        Integer randomNumber = Math.round(Math.random() * 10000);

        return '_' + String.valueOf(randomNumber);
    }
  }
  