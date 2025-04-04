
@isTest
private class AMBAdvisorTests {

    @isTest
    static void testAMBAdvisorDTO() {
        AMBAdvisor advisor = new AMBAdvisor(
            'ID',
            'Name',
            'Email',
            'Initials',
            'Location'
        );

        Callable c = (Callable) advisor;
        c.call('id', new Map<String,Object>());
        c.call('name', new Map<String,Object>());
        c.call('email', new Map<String,Object>());
        c.call('initials', new Map<String,Object>());
        c.call('location', new Map<String,Object>());

        System.assertEquals('ID', c.call('id', new Map<String,Object>()), 'ID does not match');
        System.assertEquals('Name', c.call('name', new Map<String,Object>()), 'Name does not match');
        System.assertEquals('Email', c.call('email', new Map<String,Object>()), 'Email does not match');
        System.assertEquals('Initials', c.call('initials', new Map<String,Object>()), 'Initials do not match');
        System.assertEquals('Location', c.call('location', new Map<String,Object>()), 'Location does not match');
    }
}