public without sharing class AMBConfigMetadataDeploymentUtil {
  public static String generateRecordName(
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
