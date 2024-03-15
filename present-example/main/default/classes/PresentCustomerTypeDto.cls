public with sharing class PresentCustomerTypeDto {
  @AuraEnabled
  public string label { get; set; }

  @AuraEnabled
  public string value { get; set; }

  @AuraEnabled
  public string referenceId { get; set; }

  public PresentCustomerTypeDto() {
    this.label = '';
    this.value = '';
    this.referenceId = '';
  }

  public PresentCustomerTypeDto(
    string label,
    string value,
    string referenceId
  ) {
    this.label = label;
    this.value = value;
    this.referenceId = referenceId;
  }
}
