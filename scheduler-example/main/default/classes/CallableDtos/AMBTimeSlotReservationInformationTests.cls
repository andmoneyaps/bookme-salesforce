
@isTest
private class AMBTimeSlotReservationInformationTests {

    @isTest
    static void testAMBTimeSlotReservationInformationDTO() {
        AMBTimeSlotReservationInformation timeSlotReservationInformation = new AMBTimeSlotReservationInformation();
        timeSlotReservationInformation.advisorId = 'advisorId';
        timeSlotReservationInformation.reservationKey = 'reservationKey';
        timeSlotReservationInformation.reservedTimeSlotId = 'reservedTimeSlotId';

        Callable c = (Callable)timeSlotReservationInformation;
        c.call('advisorId', new Map<String,Object>());
        c.call('reservationKey', new Map<String,Object>());
        c.call('reservedTimeSlotId', new Map<String,Object>());
    }
}