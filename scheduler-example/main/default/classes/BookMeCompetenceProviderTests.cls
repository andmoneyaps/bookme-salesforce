@isTest
public with sharing class BookMeCompetenceProviderTests {

    @isTest
    public static void getAssignedCompetence_returnsUsersAssignedCompetences() {
        // insert test data
        andmoney__AMB_Taxonomy__c meetingTaxonomy = new andmoney__AMB_Taxonomy__c(
            andmoney__BookingId__c = 'BookingId1',
            andmoney__Group__c = 'Meeting'
        );

        andmoney__AMB_Taxonomy__c customerTaxonomy = new andmoney__AMB_Taxonomy__c(
            andmoney__BookingId__c = 'BookingId2',
            andmoney__Group__c = 'Customer'
        );

        insert new List<andmoney__AMB_Taxonomy__c> {
            meetingTaxonomy,
            customerTaxonomy
        };

        // get current user id and email
        User currentUser = [SELECT Id, Email FROM User WHERE Id = :UserInfo.getUserId()];

        andmoney__AMBAdvisorCompetence__c meetingCompetence = new andmoney__AMBAdvisorCompetence__c(
            andmoney__AMB_Taxonomy__c = meetingTaxonomy.Id,
            andmoney__User__c = currentUser.Id
        );

        andmoney__AMBAdvisorCompetence__c customerCompetence = new andmoney__AMBAdvisorCompetence__c(
            andmoney__AMB_Taxonomy__c = customerTaxonomy.Id,
            andmoney__User__c = currentUser.Id
        );

        insert new List<andmoney__AMBAdvisorCompetence__c> {
            meetingCompetence,
            customerCompetence
        };

        // test
        BookMeCompetenceProvider competenceProvider = new BookMeCompetenceProvider();
        List<BookMeCompetenceProvider.AdvisorCompetencesDTO> assignedCompetences = competenceProvider.getAssignedCompetence(new List<String>{ currentUser.Email });

        System.assertEquals(1, assignedCompetences.size());
        System.assertEquals(1, assignedCompetences[0].customerCategoryCompetences.size());
        System.assertEquals(1, assignedCompetences[0].meetingCompetences.size());
    }

    @isTest
    public static void getAllCompetencesForEachAdvisor_getsAllTaxonomiesAsCompetencesForEachAdvisor() {
        // insert test data
        andmoney__AMB_Taxonomy__c meetingTaxonomy = new andmoney__AMB_Taxonomy__c(
            andmoney__BookingId__c = 'BookingId1',
            andmoney__Group__c = 'Meeting'
        );

        andmoney__AMB_Taxonomy__c customerTaxonomy = new andmoney__AMB_Taxonomy__c(
            andmoney__BookingId__c = 'BookingId2',
            andmoney__Group__c = 'Customer'
        );

        insert new List<andmoney__AMB_Taxonomy__c> {
            meetingTaxonomy,
            customerTaxonomy
        };

        // get current user id and email
        User currentUser = [SELECT Id, Email FROM User WHERE Id = :UserInfo.getUserId()];

        // Test
        BookMeCompetenceProvider competenceProvider = new BookMeCompetenceProvider();
        List<BookMeCompetenceProvider.AdvisorCompetencesDTO> allCompetences = competenceProvider.getAllCompetencesForEachAdvisor(new List<String>{ currentUser.Email });

        System.assertEquals(1, allCompetences.size());
        System.assertEquals(1, allCompetences[0].customerCategoryCompetences.size());
        System.assertEquals(1, allCompetences[0].meetingCompetences.size());
    }
}