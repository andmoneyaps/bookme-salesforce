public with sharing class PresentCustomerTypeController {
  @AuraEnabled(Cacheable=true)
  public static PresentCustomerTypeDto getCustomerTypeFromEvent(
    String eventId
  ) {
    // Get CustomerTypes
    List<PresentCustomerTypeDto> customerTypes = getCustomerTypes();

    List<Event> events = [
      SELECT AccountId
      FROM Event
      WHERE Id = :eventId
      WITH SECURITY_ENFORCED
    ];

    if (events.size() == 0) {
      return new PresentCustomerTypeDto('Privat3', 'PRIVATE', 'PRIVATE');
    }
    Id accountId = events[0].AccountId;

    string ns = 'andmoney';
    if (
      !Account.getSobjectType()
        .getDescribe()
        .fields
        .getMap()
        .containsKey(ns + 'AMB_Customer_Category__c')
    ) {
      return new PresentCustomerTypeDto('Private', 'PRIVATE', 'PRIVATE');
    }

    // Get Account's Customer Category
    List<Account> accounts = Database.query(
      'SELECT ' +
        ns +
        'AMB_Customer_Category__c FROM Account WHERE Id = :accountId'
    );

    if (accounts.size() == 0) {
      return new PresentCustomerTypeDto('Private', 'PRIVATE', 'PRIVATE');
    } else {
      String taxonomyId = (String) accounts[0]
        .get(ns + 'AMB_Customer_Category__c');
      // Query Taxonomy__c
      List<SObject> taxonomies = Database.query(
        'SELECT Name, Id, ' +
          ns +
          'BookingId__c FROM ' +
          ns +
          'AMB_Taxonomy__c WHERE id = :taxonomyId'
      );

      if (taxonomies.size() == 0) {
        return new PresentCustomerTypeDto('Private', 'PRIVATE', 'PRIVATE');
      } else {
        return new PresentCustomerTypeDto(
          (String) taxonomies[0].get('Name'),
          (String) taxonomies[0].get('Id'),
          (String) taxonomies[0].get(ns + 'BookingId__c')
        );
      }
    }
  }

  private static List<PresentCustomerTypeDto> getCustomerTypes() {
    String query = '';
    String ns = 'andmoney';
    List<PresentCustomerTypeDto> customerTypes = new List<PresentCustomerTypeDto>();

    String objectName = ns + 'AMB_Taxonomy__c';
    Schema.SObjectType queriedObjectType = Schema.getGlobalDescribe()
      .get(objectName);

    if (
      queriedObjectType != null &&
      !queriedObjectType.getDescribe().isAccessible()
    ) {
      System.debug('No access to queried object ' + objectName);
    }

    query =
      'SELECT Id, Name, ' +
      ns +
      'BookingId__c FROM ' +
      String.escapeSingleQuotes(ns + 'AMB_Taxonomy__c');
    try {
      List<SObject> result = Database.query(query); // OK to loop since it loops over a constant list
      for (SObject s : result) {
        PresentCustomerTypeDto dto = new PresentCustomerTypeDto(
          (String) s.get('Name'),
          (String) s.get('Id'),
          (String) s.get(ns + 'BookingId__c')
        );
        customerTypes.Add(dto);
      }
    } catch (QueryException e) {
      // If the sobject doesn't exist, we try the next one
      system.debug(e);
    }

    if (customerTypes.size() == 0) {
      customerTypes.Add(
        new PresentCustomerTypeDto('Private', 'PRIVATE', 'PRIVATE')
      );
      customerTypes.Add(
        new PresentCustomerTypeDto('Erhverv', 'BUSINESS', 'BUSINESS')
      );
      customerTypes.Add(
        new PresentCustomerTypeDto(
          'Private Banking',
          'PRIVATEBANKING',
          'PRIVATEBANKING'
        )
      );
      customerTypes.Add(
        new PresentCustomerTypeDto(
          'Private Banking+',
          'PRIVATEBANKINGPLUS',
          'PRIVATEBANKINGPLUS'
        )
      );
    }

    return customerTypes;
  }
}
