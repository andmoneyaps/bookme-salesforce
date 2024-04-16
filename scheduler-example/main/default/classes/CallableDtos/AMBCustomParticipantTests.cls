
@isTest
private class AMBCustomParticipantTests {

    @isTest
    static void testCustomParticipantDTO() {
        AMBCustomParticipant customParticipant = new AMBCustomParticipant();
        customParticipant.meetingContactId = 'MEETING_CONTACT_ID';
        customParticipant.id = 'ID';
        customParticipant.email = 'EMAIL';
        customParticipant.name = 'NAME';
        customParticipant.isSelected = true;

        Callable c = (Callable) customParticipant;

        c.call('meetingContactId', new Map<String,Object>());
        c.call('id', new Map<String,Object>());
        c.call('email', new Map<String,Object>());
        c.call('name', new Map<String,Object>());
        c.call('isSelected', new Map<String,Object>());
    }
}