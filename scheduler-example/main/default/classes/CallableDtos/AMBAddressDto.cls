public with sharing class AMBAddressDto implements Callable {
  @AuraEnabled
  public String displayName { get; set; }

  @AuraEnabled
  public String city { get; set; }

  @AuraEnabled
  public String countryOrRegion { get; set; }

  @AuraEnabled
  public String postalCode { get; set; }

  @AuraEnabled
  public String state { get; set; }

  @AuraEnabled
  public String street { get; set; }

  @AuraEnabled
  public Double latitude { get; set; }

  @AuraEnabled
  public Double longitude { get; set; }

  public Object call(String action, Map<String, Object> args) {
    switch on action {
      when 'displayName' {
        return this.displayName;
      }
      when 'city' {
        return this.city;
      }
      when 'countryOrRegion' {
        return this.countryOrRegion;
      }
      when 'postalCode' {
        return this.postalCode;
      }
      when 'state' {
        return this.state;
      }
      when 'street' {
        return this.street;
      }
      when 'latitude' {
        return this.latitude;
      }
      when 'longitude' {
        return this.longitude;
      }
      when else {
        throw new IllegalArgumentException('Invalid action');
      }
    }
  }
}
