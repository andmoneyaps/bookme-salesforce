@isTest
private class AMBAddressDtoTests {
  @isTest
  static void testAMBAddressDto() {
    AMBAddressDto addressDto = new AMBAddressDto();
    addressDto.displayName = 'TEST_DISPLAY_NAME';
    addressDto.street = 'TEST_STREET';
    addressDto.city = 'TEST_CITY';
    addressDto.state = 'TEST_STATE';
    addressDto.postalCode = 'TEST_POSTAL_CODE';
    addressDto.countryOrRegion = 'TEST_COUNTRY_OR_REGION';
    addressDto.latitude = 0.0;
    addressDto.longitude = 0.0;

    Callable c = (Callable) addressDto;

    c.call('displayName', new Map<string,Object>());
    c.call('street', new Map<string,Object>());
    c.call('city', new Map<string,Object>());
    c.call('state', new Map<string,Object>());
    c.call('postalCode', new Map<string,Object>());
    c.call('countryOrRegion', new Map<string,Object>());
    c.call('latitude', new Map<string,Object>());
    c.call('longitude', new Map<string,Object>());
  }
}
