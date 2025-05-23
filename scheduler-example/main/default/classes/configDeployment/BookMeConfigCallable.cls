global without sharing class BookMeConfigCallable implements Callable {
  private String getAdvisorUserIdFromEmail(String email) {
    List<User> users = [
      SELECT Id
      FROM User
      WHERE Email = :email
      LIMIT 1
    ];
    if (users.isEmpty()) {
      return null;
    }
    return users[0].Id;
  }

  private String getShowAsValue(String operationType) {
    switch on operationType {
      when 'CREATE', 'UPDATE', 'READ', 'RESCHEDULE' {
        return 'Busy';
      }
      when 'DELETE', 'CANCEL' {
        return 'Free';
      }
      when else {
        return 'Busy';
      }
    }
  }

  private Boolean getIsAllDayEvent() {
    return false;
  }

  private Date getOpportunityCloseDate(DateTime dt) {
    return dt.date().addDays(this.defaultDaysToClose());
  }

  private String getOpportunityStageName() {
    return 'Open';
  }

  private String getContactId(Callable dto, String sourceName) {
    List<String> contactIds = (List<String>) dto.call(
      sourceName,
      new Map<String, Object>()
    );
    if (contactIds.isEmpty()) {
      return null;
    }
    return contactIds[0];
  }

  private Integer defaultDaysToClose() {
    andmoney__AMB_Booking_Limit__mdt[] implementationSettings = [
      SELECT DeveloperName, andmoney__Limit__c
      FROM andmoney__AMB_Booking_Limit__mdt
      WHERE DeveloperName = 'Opportunity_Close_Default_Days'
      LIMIT 1
    ];

    if (implementationSettings.size() == 0) {
      return 0;
    }

    return Integer.valueOf(implementationSettings[0].andmoney__Limit__c);
  }

  private String getCompanyName() {
    // TODO: Implement specific lookup for company name
    // currently returns default unique company name
    return 'Company Name' + appendRandomNumber();
  }

  private String appendRandomNumber() {
    Integer randomNumber = Math.round(Math.random() * 10000);
    return '_' + String.valueOf(randomNumber);
  }

  // Dispatch actual methods
  // that actions must match what is defined in the config metadata Util Methods
  public Object call(String action, Map<String, Object> args) {
    Callable dto = (Callable) args.get('dto');

    switch on action {
      when 'getAdvisorUserIdFromEmail' {
        Callable advisorDto = (Callable) dto.call(
          (String) args.get('sourceName'),
          new Map<String, Object>()
        );

        String advisorEmail = (String) advisorDto.call(
          'email',
          new Map<String, Object>()
        );

        return this.getAdvisorUserIdFromEmail(advisorEmail);
      }

      when 'getShowAsValue' {
        String operationType = (String) dto.call(
          'operationType',
          new Map<String, Object>()
        );
        return this.getShowAsValue(operationType);
      }

      when 'getIsAllDayEvent' {
        return this.getIsAllDayEvent();
      }
      
      when 'getOpportunityCloseDate' {
        String sourceName = (String) args.get('sourceName');

        Datetime dt = (Datetime) dto.call(
          sourceName,
          new Map<String, Object>()
        );

        return this.getOpportunityCloseDate(dt);
      }

      when 'getOpportunityStageName' {
        return this.getOpportunityStageName();
      }

      when 'getContactId' {
        String sourceName = (String) args.get('sourceName');

        return this.getContactId(dto, sourceName);
      }

      when 'getAdvisorEmail' {
        Callable adv = (Callable) dto.call(
          (String) args.get('sourceName'),
          new Map<String, Object>()
        );
        String advisorEmail = (String) adv.call(
          'email',
          new Map<String, Object>()
        );
        return advisorEmail;
      }

      when 'getAdvisorFirstName' {
        Callable adv = (Callable) dto.call(
          (String) args.get('sourceName'),
          new Map<String, Object>()
        );
        String name = (String) adv.call(
          'name',
          new Map<String, Object>()
        );

        List<String> splitName = name?.split(' ');

        return splitName[0];
      }

      when 'getAdvisorLastName' {
        Callable adv = (Callable) dto.call(
          (String) args.get('sourceName'),
          new Map<String, Object>()
        );

        String name = (String) adv.call(
          'name',
          new Map<String, Object>()
        );

        List<String> splitName = name?.split(' ');

        return splitName[1];
      }

      when 'getCompanyName' {
        return this.getCompanyName();
      }
      
      when else {
        System.debug(
          'Callable method "' + action + '" not implemented'
        );
        throw new UnsupportedOperationException(
          'Callable method "' + action + '" not implemented'
        );
      }
    }
  }
}
