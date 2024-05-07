@isTest
public class AMBAdvisorCompetencesDTOTest {
  @isTest
  static void testCall() {
    AMBAdvisorCompetencesDTO dto = new AMBAdvisorCompetencesDTO();
    dto.email = 'test@test.com';
    dto.meetingCompetences = new List<String>{ 'test' };
    dto.customerCategoryCompetences = new List<String>{ 'test' };

    System.assertEquals(
      dto.email,
      dto.call('email', new Map<String, Object>()),
      'email should be called'
    );
    System.assertEquals(
      dto.meetingCompetences,
      dto.call('meetingCompetences', new Map<String, Object>()),
      'meetingCompetences should be called'
    );
    System.assertEquals(
      dto.customerCategoryCompetences,
      dto.call('customerCategoryCompetences', new Map<String, Object>()),
      'customerCategoryCompetences should be called'
    );

    try {
      dto.call('test', new Map<String, Object>());
    } catch (AMBNotImplementedException ex) {
      System.assertEquals(
        'Callable action "test" not implemented',
        ex.getMessage(),
        'Should throw AMBNotImplementedException'
      );
    }
  }
}
