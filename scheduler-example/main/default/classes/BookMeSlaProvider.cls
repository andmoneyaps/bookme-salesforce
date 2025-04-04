global without sharing class BookMeSlaProvider implements Callable {
  /** Returns the bookingId of a customer category in the AMBtaxonomy */
  private string getCustomerCategoryId(String accountId) {
    if (accountId == null) {
      throw new IllegalArgumentException('AccountId must not be null');
    }
    
    List<Account> accounts = [
      SELECT andmoney__AMB_Customer_Category__r.andmoney__bookingId__c
      
      FROM Account
      WHERE Id = :accountId
    ];
    if (accounts.size() < 1) {
      return null;
    }
    
    return accounts[0].andmoney__AMB_Customer_Category__r.andmoney__bookingId__c;
  }

  /** Returns a location string which must match the provided locations by the SCIM endpoint in azure for advisors and rooms.*/
  private string getAccountLocation(String accountId) {
    if (accountId == null) {
      throw new IllegalArgumentException('AccountId must not be null');
    }

    List<Account> accounts = [
      SELECT andmoney__AMB_Location__c
      FROM Account
      WHERE Id = :accountId
      WITH SECURITY_ENFORCED
    ];
    if (accounts.size() < 1) {
      return null;
    }
    System.debug(accounts[0].andmoney__AMB_Location__c);
    return accounts[0].andmoney__AMB_Location__c;
  }

  public Object call(String action, Map<String, Object> args) {
    switch on action {
      when 'getCustomerCategoryId' {
        String accountId = (String) args.get('accountId');
        return this.getCustomerCategoryId(accountId);
      }
      when 'getAccountLocation' {
        String accountId = (String) args.get('accountId');
        return this.getAccountLocation(accountId);
      }
      when else {
        return null;
      }
    }
  }
}