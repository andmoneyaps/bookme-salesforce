public class AMBCustomParticipant implements Callable {
  /**  This is the ID of the MeetingContact record */
  @AuraEnabled
  public string meetingContactId { get; set; }
  /** This is the ID of the Contact record */
  @AuraEnabled
  public string id { get; set; }
  /** The email of the participant record. This should be the latest provided contact email */
  @AuraEnabled
  public string email { get; set; }

  /** The full name of the participant */
  @AuraEnabled
  public string name { get; set; }

  /** This is a flag to indicate if the participant is selected or not */
  @AuraEnabled
  public Boolean isSelected { get; set; }

  public AMBCustomParticipant() {
  }

  public AMBCustomParticipant(
    String meetingContactId,
    String id,
    String email,
    String name
  ) {
    this.meetingContactId = meetingContactId;
    this.id = id;
    this.email = email;
    this.name = name;
  }

  public Object call(String action, Map<String, Object> args) {
    switch on action {
      when 'meetingContactId' {
        return this.meetingContactId;
      }
      when 'id' {
        return this.id;
      }
      when 'email' {
        return this.email;
      }
      when 'name' {
        return this.name;
      }
      when 'isSelected' {
        return this.isSelected;
      }
      when else {
        throw new AMBNotImplementedException(
          'Callable method "' + action + '" not implemented'
        );
      }
    }
  }
}
