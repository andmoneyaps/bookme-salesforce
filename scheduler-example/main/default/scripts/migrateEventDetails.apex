// Fetch AMB Event Details and recreate them as andmoney__AMB_Event_Detail__c
 


List<AMB_Event_Detail__c> eventDetails = [
  SELECT
    Id,
    AdditionalAdvisorCount__c,
    AdvisorEmail__c,
    AdvisorName__c,
    BookingFlowId__c,
    CancellationReason__c,
    CancelledBy__c,
    Comment__c,
    IsCustomerInitiated__c,
    Location__c,
    MeetingTaxonomy__c,
    MeetingTypeLabel__c,
    MeetingType__c,
    RoomId__c,
    RoomName__c,
    SendMeetingInvite__c,
    TeamsMeetingLink__c,
    MeetingTaxonomy__r.BookingId__c
  FROM AMB_Event_Detail__c
];
 
// Create Map event Id to AMB Event Detail Id
List<Id> eventDetailIds = new List<Id>();
for (AMB_Event_Detail__c eventDetail : eventDetails) {
  eventDetailIds.add(eventDetail.Id);
}
 
// Fetch Meeting Contacts
List<AMB_Meeting_Contact__c> meetingContacts = [
  SELECT
    AMB_Event_Detail__c,
    Contact__c,
    Email__c
  FROM AMB_Meeting_Contact__c
  WHERE AMB_Event_Detail__c in :eventDetailIds
];
 
 
// Create a map from Event Detail Id to Meeting Contacts
Map <Id, List<AMB_Meeting_Contact__c>> eventDetailIdToMeetingContactMap = new Map<Id, List<AMB_Meeting_Contact__c>>();
for (AMB_Meeting_Contact__c meetingContact : meetingContacts) {
  if (!eventDetailIdToMeetingContactMap.containsKey(meetingContact.AMB_Event_Detail__c)) {
    eventDetailIdToMeetingContactMap.put(meetingContact.AMB_Event_Detail__c, new List<AMB_Meeting_Contact__c>());
  }
 
  eventDetailIdToMeetingContactMap.get(meetingContact.AMB_Event_Detail__c).add(meetingContact);
}

List<AMB_Taxonomy__c> taxonomies = [
  SELECT
    Id,
    BookingId__c
  FROM AMB_Taxonomy__c
];

// Create Map new Taxonomy Id
List<andmoney__AMB_Taxonomy__c> andmoneyTaxonomies = [
    SELECT
        Id,
        andmoney__BookingId__c
    FROM andmoney__AMB_Taxonomy__c
];
// Create Map event Id to AMB Taxonomy Id
Map<String, Id> eventToTaxonomyMap = new Map<String, Id>();
for (andmoney__AMB_Taxonomy__c taxonomy : andmoneyTaxonomies) {
  eventToTaxonomyMap.put(taxonomy.andmoney__BookingId__c, taxonomy.Id);
}
 
// Recreate the Event Detail as andmoney Event Detail
Map<Id, andmoney__AMB_Event_Detail__c> andmoneyEventDetailsMap = new Map<Id, andmoney__AMB_Event_Detail__c>();
 
for (AMB_Event_Detail__c eventDetail : eventDetails) {
  andmoney__AMB_Event_Detail__c andmoneyEventDetail = new andmoney__AMB_Event_Detail__c();
 
  // map each field
  andmoneyEventDetail.andmoney__AdditionalAdvisorCount__c = eventDetail.AdditionalAdvisorCount__c;
  andmoneyEventDetail.andmoney__AdvisorEmail__c = eventDetail.AdvisorEmail__c;
  andmoneyEventDetail.andmoney__AdvisorName__c = eventDetail.AdvisorName__c;
  andmoneyEventDetail.andmoney__BookingFlowId__c = eventDetail.BookingFlowId__c;
  andmoneyEventDetail.andmoney__CancellationReason__c = eventDetail.CancellationReason__c;
  andmoneyEventDetail.andmoney__CancelledBy__c = eventDetail.CancelledBy__c;
  andmoneyEventDetail.andmoney__Comment__c = eventDetail.Comment__c;
  andmoneyEventDetail.andmoney__IsCustomerInitiated__c = eventDetail.IsCustomerInitiated__c;
  andmoneyEventDetail.andmoney__Location__c = eventDetail.Location__c;
  andmoneyEventDetail.andmoney__MeetingTaxonomy__c = eventToTaxonomyMap.get(eventDetail.MeetingTaxonomy__r.BookingId__c);
  andmoneyEventDetail.andmoney__MeetingTypeLabel__c = eventDetail.MeetingTypeLabel__c;
  andmoneyEventDetail.andmoney__MeetingType__c = eventDetail.MeetingType__c;
  andmoneyEventDetail.andmoney__RoomId__c = eventDetail.RoomId__c;
  andmoneyEventDetail.andmoney__RoomName__c = eventDetail.RoomName__c;
  andmoneyEventDetail.andmoney__SendMeetingInvite__c = eventDetail.SendMeetingInvite__c;
  andmoneyEventDetail.andmoney__TeamsMeetingLink__c = eventDetail.TeamsMeetingLink__c;
 
  andmoneyEventDetailsMap.put(eventDetail.Id, andmoneyEventDetail);
}
 
insert andmoneyEventDetailsMap.values();
 
// Verify tat the andmoneyEventDetailsMap have Ids
 
for (andmoney__AMB_Event_Detail__c andMoneyEventDetail : andmoneyEventDetailsMap.values()) {
  if (andMoneyEventDetail.Id == null) {
    System.debug('Error: No Id on eventDetail');
  }
}
 
// now that we have the andmoney event details, we can recreate the meeting contacts
List<andmoney__AMB_Meeting_Contact__c> andmoneyMeetingContacts = new List<andmoney__AMB_Meeting_Contact__c>();
 
// Loop through Map of eventDetailId to Meeting Contacts
for (Id eventDetailId : eventDetailIdToMeetingContactMap.keySet()) {
  List<AMB_Meeting_Contact__c> meetingContacts = eventDetailIdToMeetingContactMap.get(eventDetailId);
 
  if (!andmoneyEventDetailsMap.containsKey(eventDetailId)) {
    continue;
  }
  andmoney__AMB_Event_Detail__c andMoneyEventDetail = andmoneyEventDetailsMap.get(eventDetailId);
 
  // loop through contacts
  for (AMB_Meeting_Contact__c meetingContact : meetingContacts) {
    andmoney__AMB_Meeting_Contact__c andmoneyMeetingContact = new andmoney__AMB_Meeting_Contact__c();
 
    Id andmoneyEventDetailId = andMoneyEventDetail.Id;
 
    // map each field
    andmoneyMeetingContact.andmoney__AMB_Event_Detail__c = andmoneyEventDetailId;
    andmoneyMeetingContact.andmoney__Contact__c = meetingContact.Contact__c;
    andmoneyMeetingContact.andmoney__Email__c = meetingContact.Email__c;
 
    andmoneyMeetingContacts.add(andmoneyMeetingContact);
  }
}
 
// insert the andmoney meeting contacts
insert andmoneyMeetingContacts;
 
 
// Now find the relevant events that need to be updated with andmoney Event Detail
 
List<Event> events = [
  SELECT
    Id,
    AMB_Event_Detail__c
  FROM Event
  WHERE AMB_Event_Detail__c in :eventDetailIds
];
 
 
for (Event ev : events) {
  if (!andmoneyEventDetailsMap.containsKey(ev.AMB_Event_Detail__c)) {
    continue;
  }
 
  andmoney__AMB_Event_Detail__c andMoneyEventDetail = andmoneyEventDetailsMap.get(ev.AMB_Event_Detail__c);
 
  if (andMoneyEventDetail.Id == null) {
    System.debug('Error: No Id on eventDetail');
    continue;
  }
 
  ev.andmoney__AMB_Event_Detail__c = andMoneyEventDetail.Id;
}
 
update events;
 