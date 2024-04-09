public with sharing class AMBAdvisor implements Callable {
  @AuraEnabled
  public String id { get; private set; }

  @AuraEnabled
  public String name { get; private set; }

  @AuraEnabled
  public String email { get; private set; }

  @AuraEnabled
  public String initials { get; private set; }

  @AuraEnabled
  public String location { get; private set; }

  public AMBAdvisor() {
  }

  public AMBAdvisor(
    String id,
    String name,
    String email,
    String initials,
    String location
  ) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.initials = initials;
    this.location = location;
  }

  public Object call(String action, Map<String, Object> args) {
    switch on action {
      when 'name' {
        return this.name;
      }
      when 'id' {
        return this.id;
      }
      when 'email' {
        return this.email;
      }
      when 'initials' {
        return this.initials;
      }
      when 'location' {
        return this.location;
      }
      when else {
        throw new IllegalArgumentException(
          'Callable method "' + action + '" not implemented'
        );
      }
    }
  }
}
