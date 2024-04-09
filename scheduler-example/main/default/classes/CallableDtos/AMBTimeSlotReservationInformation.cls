public with sharing class AMBTimeSlotReservationInformation implements Callable {
  @AuraEnabled
  public String advisorId { get; set; }

  @AuraEnabled
  public String reservationKey { get; set; }

  @AuraEnabled
  public String reservedTimeSlotId { get; set; }

  public AMBTimeSlotReservationInformation(
    String advisorId,
    String reservationKey,
    String reservedTimeSlotId
  ) {
    this.advisorId = advisorId;
    this.reservationKey = reservationKey;
    this.reservedTimeSlotId = reservedTimeSlotId;
  }

  public AMBTimeSlotReservationInformation() {
  }

  public Object call(String action, Map<String, Object> args) {
    switch on action {
      when 'advisorId' {
        return this.advisorId;
      }
      when 'reservationKey' {
        return this.reservationKey;
      }
      when 'reservedTimeSlotId' {
        return this.reservedTimeSlotId;
      }
      when else {
        throw new IllegalArgumentException(
          'Callable method "' + action + '" not implemented'
        );
      }
    }
  }
}
