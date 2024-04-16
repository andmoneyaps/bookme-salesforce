
@isTest
private class AMBAdvisorTests {

    @isTest
    static void testAMBAdvisorDTO() {
        AMBAdvisor advisor = new AMBAdvisor();
        advisor.id = 'ID';
        advisor.name = 'Name';
        advisor.email = 'Email';
        advisor.initials = 'Initials';
        advisor.location = 'Location';

        Callable c = (Callable) advisor;
        c.call('id', new Map<String,Object>());
        c.call('name', new Map<String,Object>());
        c.call('email', new Map<String,Object>());
        c.call('initials', new Map<String,Object>());
        c.call('location', new Map<String,Object>());
    }
}