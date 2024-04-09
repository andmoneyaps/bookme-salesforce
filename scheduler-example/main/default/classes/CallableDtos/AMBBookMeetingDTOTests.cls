@IsTest
public with sharing class AMBBookMeetingDTOTests {
  @IsTest
  public static void testBookMeetingDTO() {

    AMBBookMeetingDTO dto = new AMBBookMeetingDTO();
    dto.relatedRecordId = '';
    dto.bookingId = 'TEST_BOOKING_ID';
    dto.accountId = null;
    dto.themeId = 'BookingId__c';
    dto.contactIds = new List<String>{ 'CONTACT_ID' };
    dto.contacts = new List<AMBCustomParticipant>{
      new AMBCustomParticipant(null, 'ID', 'EMAIL', 'FIRST_NAME')
    };
    dto.participants = new List<AMBCustomParticipant>();
    dto.meetingTypeId = 'TEST_MEETING_TYPE_ID';
    dto.meetingTypeLabel = 'TEST_MEETING_TYPE_LABEL';
    dto.description = 'TEST_DESCRIPTION';
    dto.bookedByCustomer = false;
    dto.roomId = 'TEST_ROOM_ID';
    dto.startDate = Datetime.now().addDays(1);
    dto.endDate = Datetime.now().addDays(1).addHours(1);
    dto.sendMeetingInvites = false;
    dto.meetingOwner = 'ADVISOR_ID';
    dto.additionalAdvisors = new List<String>();
    dto.advisorReservationKeys = new List<AMBTimeSlotReservationInformation>
    {

    };
    dto.ignoreTimeSlotConflicts = true;
    dto.recordTypeName = 'Opportunity';
    dto.location = 'TEST_LOCATION';
    dto.meetingTitle = 'TEST_MEETING_TITLE';
    dto.eventDetailsId = null;
    dto.eventId = null;
    dto.advisor = new AMBAdvisor(
      'ID',
      'FIRST_NAME',
      'EMAIL',
      'TEST_ADVISOR_INITIALS',
      'TEST_ADVISOR_LOCATION'
    );
    dto.advisors = new List<AMBAdvisor>();
    dto.roomName = 'TEST_ROOM_NAME';
    dto.onlineMeetingLink = 'TEST_ONLINE_MEETING_LINK';
    dto.startAddress = new AMBAddressDto();
    dto.startAddress.displayName = 'TEST_DISPLAY_NAME';
    dto.startAddress.street = 'TEST_STREET';
    dto.startAddress.city = 'TEST_CITY';
    dto.startAddress.state = 'TEST_STATE';
    dto.startAddress.postalCode = 'TEST_POSTAL_CODE';
    dto.startAddress.countryOrRegion = 'TEST_COUNTRY_OR_REGION';
    dto.startAddress.latitude = 0.0;
    dto.startAddress.longitude = 0.0;
    dto.endAddress = new AMBAddressDto();
    dto.endAddress.displayName = 'TEST_DISPLAY_NAME';
    dto.endAddress.street = 'TEST_STREET';
    dto.endAddress.city = 'TEST_CITY';
    dto.endAddress.state = 'TEST_STATE';
    dto.endAddress.postalCode = 'TEST_POSTAL_CODE';
    dto.endAddress.countryOrRegion = 'TEST_COUNTRY_OR_REGION';
    dto.endAddress.latitude = 0.0;
    dto.endAddress.longitude = 0.0;
    dto.configId = 'TEST_CONFIG_ID';
    dto.operationTypeEnum = AMBOperationType.CANCELOP;

    String opTypeString = dto.operationType;

    dto.cancelledBy = 'TEST_CANCELLED_BY';
    dto.cancelComment = 'TEST_CANCEL_COMMENT';


    Callable c = (Callable) dto;

    c.call('recordId', new Map<String,Object>());
    c.call('bookingId', new Map<String,Object>());
    c.call('accountId', new Map<String,Object>());
    c.call('contactIds', new Map<String,Object>());
    c.call('contacts', new Map<String,Object>());
    c.call('participants', new Map<String,Object>());
    c.call('meetingTypeId', new Map<String,Object>());
    c.call('meetingTypeLabel', new Map<String,Object>());
    c.call('description', new Map<String,Object>());
    c.call('bookedByCustomer', new Map<String,Object>());
    c.call('roomId', new Map<String,Object>());
    c.call('startDate', new Map<String,Object>());
    c.call('endDate', new Map<String,Object>());
    c.call('sendMeetingInvites', new Map<String,Object>());
    c.call('meetingOwner', new Map<String,Object>());
    c.call('additionalAdvisors', new Map<String,Object>());
    c.call('advisorReservationKeys', new Map<String,Object>());
    c.call('ignoreTimeSlotConflicts', new Map<String,Object>());
    c.call('recordTypeName', new Map<String,Object>());
    c.call('location', new Map<String,Object>());
    c.call('meetingTitle', new Map<String,Object>());
    c.call('eventDetailsId', new Map<String,Object>());
    c.call('eventId', new Map<String,Object>());
    c.call('advisor', new Map<String,Object>());
    c.call('advisors', new Map<String,Object>());
    c.call('roomName', new Map<String,Object>());
    c.call('onlineMeetingLink', new Map<String,Object>());
    c.call('startAddress', new Map<String,Object>());
    c.call('endAddress', new Map<String,Object>());
    c.call('configId', new Map<String,Object>());
    c.call('operationType', new Map<String,Object>());
    c.call('cancelledBy', new Map<String,Object>());
    c.call('cancelComment', new Map<String,Object>());

    dto.getAttributes();
    dto.getAttributeValueMap();
  }
}