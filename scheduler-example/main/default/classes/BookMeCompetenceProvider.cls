// This class is used as a dependency injected implementation of the bookme competence provider interface, exposed through Callable.
// Overrides the default bookme implementation for providing competences to the bookme component.
// Competences, meaning the list of available meeting types and customer categories, available for each employee.
global with sharing class BookMeCompetenceProvider implements Callable {
  public class AdvisorCompetencesDTO {
    public String email;
    public List<String> customerCategoryCompetences;
    public List<String> meetingCompetences;
  }

  private List<AdvisorCompetencesDTO> getCompetenceBatch(List<String> emails) {
    return this.getAllCompetencesForEachAdvisor(emails);

    // TODO: Uncomment this and call instead to use the assigned competences instead of the full list of competences.
    // return this.getAssignedCompetence(emails);
  }

  public Object call(String action, Map<String, Object> args) {
    switch on action {
      when 'getCompetenceBatch' {
        List<String> emails = (List<String>) args.get('emails');
        return this.getCompetenceBatch(emails);
      }
      when else {
        throw new IllegalArgumentException(
          'Callable method "' + action + '" not implemented'
        );
      }
    }
  }

  // returns the full list of every meeting and customer category taxonomy for each advisor.
  // (i.e all advisors have all competences) 
  @TestVisible
  private List<AdvisorCompetencesDTO> getAllCompetencesForEachAdvisor(List<String> emails) {
    List<andmoney__AMB_Taxonomy__c> taxonomies = [SELECT andmoney__BookingId__c, andmoney__Group__c FROM andmoney__AMB_Taxonomy__c];

    List<AdvisorCompetencesDTO> output = new List<AdvisorCompetencesDTO>();

    if (taxonomies == null || taxonomies.size() == 0) {
      return output;
    }

    for (String email : emails) {
      AdvisorCompetencesDTO dto = new AdvisorCompetencesDTO();
      dto.email = email;
      dto.customerCategoryCompetences = new List<string>();
      dto.meetingCompetences = new List<string>();

      for (andmoney__AMB_Taxonomy__c taxonomy : taxonomies) {
        if (taxonomy.andmoney__Group__c == 'Meeting') {
          dto.meetingCompetences.add(taxonomy.andmoney__BookingId__c);
        } else if (taxonomy.andmoney__Group__c == 'Customer') {
          dto.customerCategoryCompetences.add(taxonomy.andmoney__BookingId__c);
        } else {
          System.debug('Unexpected Taxonomy group');
        }
      }

      output.add(dto);
    }

    return output;
  }

  // Gets the competences for each advisor, which has been assigned through the 
  // andmoney__AMBAdvisorCompetence__c object.
  @TestVisible
  private List<AdvisorCompetencesDTO> getAssignedCompetence(List<String> emails) {
    // Read list of userIds from emails
    List<User> users = [
      SELECT Id, Email
      FROM User
      WHERE Email IN :emails
    ];

    // Create map containing userId and email
    Map<string, string> userMap = new Map<string, string>();
    for (User u : users) {
      userMap.put(u.Id, u.Email);
    }

    List<String> userIds = new List<String>();
    userIds.addAll(userMap.keySet());

    // Read assigned competences for each user
    List<andmoney__AMBAdvisorCompetence__c> competences = [
      SELECT
        Id,
        andmoney__User__c,
        andmoney__AMB_Taxonomy__r.andmoney__BookingId__c,
        andmoney__AMB_Taxonomy__r.andmoney__Group__c
      FROM andmoney__AMBAdvisorCompetence__c
      WHERE andmoney__User__c IN :userIds
    ];

    List<AdvisorCompetencesDTO> output = new List<AdvisorCompetencesDTO>();
    Map<String, AdvisorCompetencesDTO> dtoMap = new Map<String, AdvisorCompetencesDTO>();
    
    for (andmoney__AMBAdvisorCompetence__c comp : competences) {
      if (!dtoMap.containsKey(comp.andmoney__User__c)) {
        AdvisorCompetencesDTO dto = new AdvisorCompetencesDTO();
        dto.email = userMap.get(comp.andmoney__User__c);
        dto.customerCategoryCompetences = new List<string>();
        dto.meetingCompetences = new List<string>();
        dtoMap.put(comp.andmoney__User__c, dto);
      }

      AdvisorCompetencesDTO dto = dtoMap.get(comp.andmoney__User__c);
      if (comp.andmoney__AMB_Taxonomy__r.andmoney__Group__c == 'Meeting') {
        dto.meetingCompetences.add(comp.andmoney__AMB_Taxonomy__r.andmoney__BookingId__c);
      } else if (comp.andmoney__AMB_Taxonomy__r.andmoney__Group__c == 'Customer') {
        dto.customerCategoryCompetences.add(comp.andmoney__AMB_Taxonomy__r.andmoney__BookingId__c);
      } else {
        System.debug('Unexpected Taxonomy group');
      }
    }

    return dtoMap.values();
  }
}
