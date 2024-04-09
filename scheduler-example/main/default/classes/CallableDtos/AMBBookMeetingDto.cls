public class AMBBookMeetingDTO implements Callable {
  // #region Provided by frontend

  /* Related record id which is either an activity object or activity participant*/
  @AuraEnabled
  public String relatedRecordId { get; set; }
  /* &bookme id for the activity */
  @AuraEnabled
  public String bookingId { get; set; }
  @AuraEnabled
  public String accountId { get; set; }
  @AuraEnabled
  public String themeId { get; set; }
  @AuraEnabled
  public List<String> contactIds { get; set; }
  @AuraEnabled
  public List<AMBCustomParticipant> contacts { get; set; }
  @AuraEnabled
  public List<AMBCustomParticipant> participants { get; set; }
  @AuraEnabled
  public String meetingTypeId { get; set; }
  @AuraEnabled
  public String meetingTypeLabel { get; set; }
  @AuraEnabled
  public String description { get; set; }
  @AuraEnabled
  public Boolean bookedByCustomer { get; set; }
  @AuraEnabled
  public string roomId { get; set; }
  @AuraEnabled
  public DateTime startDate { get; set; }
  @AuraEnabled
  public DateTime endDate { get; set; }
  @AuraEnabled
  public Boolean sendMeetingInvites { get; set; }
  @AuraEnabled
  public String meetingOwner { get; set; }
  @AuraEnabled
  public List<String> additionalAdvisors { get; set; }
  @AuraEnabled
  public List<AMBTimeSlotReservationInformation> advisorReservationKeys {
    get;
    set;
  }
  @AuraEnabled
  public Boolean ignoreTimeSlotConflicts { get; set; }
  @AuraEnabled
  public String recordTypeName { get; set; }
  @AuraEnabled
  public String location { get; set; }
  @AuraEnabled
  public String meetingTitle { get; set; }

  @AuraEnabled
  public AMBAddressDto startAddress { get; set; }
  @AuraEnabled
  public AMBAddressDto endAddress { get; set; }

  // #endregion

  // #region From backend
  public Id eventDetailsId { get; set; }
  public Id eventId { get; set; }

  public AMBAdvisor advisor { get; set; }
  public List<AMBAdvisor> advisors { get; set; }
  public string roomName { get; set; }
  public string onlineMeetingLink { get; set; }
  public string configId { get; set; }
  // #endregion

  public AMBOperationType operationTypeEnum { private get; set; }

  public String operationType {
    get {
      switch on this.operationTypeEnum {
        when CREATEOP {
          return 'CREATE';
        }
        when READOP {
          return 'READ';
        }
        when UPDATEOP {
          return 'UPDATE';
        }
        when DELETEOP {
          return 'DELETE';
        }
        when RESCHEDULEOP {
          return 'RESCHEDULE';
        }
        when CANCELOP {
          return 'CANCEL';
        }
        when else {
          return 'UNKNOWN';
        }
      }
    }
  }

  public String cancelledBy { get; set; }
  public String cancelComment { get; set; }

  public Object call(String action, Map<String, Object> args) {
    switch on action {
      when 'recordId' {
        return this.relatedRecordId;
      }
      when 'bookingId' {
        return this.bookingId;
      }
      when 'accountId' {
        return this.accountId;
      }
      when 'contactIds' {
        return this.contactIds;
      }
      when 'contacts' {
        return this.contacts;
      }
      when 'participants' {
        return this.participants;
      }
      when 'meetingTypeId' {
        return this.meetingTypeId;
      }
      when 'meetingTypeLabel' {
        return this.meetingTypeLabel;
      }
      when 'description' {
        return this.description;
      }
      when 'bookedByCustomer' {
        return this.bookedByCustomer;
      }
      when 'roomId' {
        return this.roomId;
      }
      when 'startDate' {
        return this.startDate;
      }
      when 'endDate' {
        return this.endDate;
      }
      when 'sendMeetingInvites' {
        return this.sendMeetingInvites;
      }
      when 'meetingOwner' {
        return this.meetingOwner;
      }
      when 'additionalAdvisors' {
        return this.additionalAdvisors;
      }
      when 'advisorReservationKeys' {
        return this.advisorReservationKeys;
      }
      when 'ignoreTimeSlotConflicts' {
        return this.ignoreTimeSlotConflicts;
      }
      when 'recordTypeName' {
        return this.recordTypeName;
      }
      when 'location' {
        return this.location;
      }
      when 'meetingTitle' {
        return this.meetingTitle;
      }
      when 'eventDetailsId' {
        return this.eventDetailsId;
      }
      when 'eventId' {
        return this.eventId;
      }
      when 'advisor' {
        return this.advisor;
      }
      when 'advisors' {
        return this.advisors;
      }
      when 'roomName' {
        return this.roomName;
      }
      when 'onlineMeetingLink' {
        return this.onlineMeetingLink;
      }
      when 'configId' {
        return this.configId;
      }
      when 'operationType' {
        return this.operationType;
      }
      when 'cancelledBy' {
        return this.cancelledBy;
      }
      when 'cancelComment' {
        return this.cancelComment;
      }
      when 'startAddress' {
        return this.startAddress;
      }
      when 'endAddress' {
        return this.endAddress;
      }
      when else {
        throw new AMBNotImplementedException(
          'Callable method "' + action + '" not implemented'
        );
      }
    }
  }

  public Set<String> getAttributes() {
    String serializedClass = JSON.serialize(this);

    Map<String, Object> attributeValueMap = (Map<String, Object>) JSON.deserializeUntyped(
      serializedClass
    );

    return attributeValueMap.keyset().clone();
  }

  public Map<String, Object> getAttributeValueMap() {
    String serializedClass = JSON.serialize(this);

    Map<String, Object> attributeValueMap = (Map<String, Object>) JSON.deserializeUntyped(
      serializedClass
    );

    // Handle Datetime deserializations
    if (attributeValueMap.get('startDate') != null) {
      String formattedStartDate = ((String) attributeValueMap.get('startDate'))
        .replace('T', ' ')
        .replace('.000Z', '');
      attributeValueMap.put(
        'startDate',
        Datetime.valueOfGmt(formattedStartDate)
      );
    }

    if (attributeValueMap.get('endDate') != null) {
      String formattedEndDate = ((String) attributeValueMap.get('endDate'))
        .replace('T', ' ')
        .replace('.000Z', '');
      attributeValueMap.put('endDate', Datetime.valueOfGmt(formattedEndDate));
    }

    return attributeValueMap;
  }
}
