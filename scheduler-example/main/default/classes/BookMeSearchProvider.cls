global with sharing class BookMeSearchProvider implements Callable {
    private List<Contact> findContacts(
      String searchQuery
    ) {

      List<contact> contacts = [
        SELECT Salutation, Name, Email, Id
        FROM Contact
        WHERE
          Email LIKE :searchQuery
          OR Name LIKE :searchQuery
          OR Salutation LIKE :searchQuery
        WITH SECURITY_ENFORCED
        ORDER BY Name ASC
        LIMIT 5
      ];
  
      return contacts;
    }

    public class BookMeCloseContactTuple implements Callable  {
        public String relation;
        public Contact contact;
        public Boolean isSelected;

        public Object call(String action, Map<String, Object> args) {
          switch on action {
            when 'relation' {
              return this.relation;
            }
            when 'contact' {
              return this.contact;
            }
            when 'isSelected' {
              return this.isSelected;
            }
            when else {
              throw new AuraHandledException(
                'Callable method "' + action + '" not implemented'
              );
            }
          }
        }
    }
  
    /** Returns a list of close contacts based on an account id. The first result provided will be the default contact on the meeting */
    private List<BookMeCloseContactTuple> getCloseContactRelations(
      string accountId
    ) {
      List<BookMeCloseContactTuple> results = new List<BookMeCloseContactTuple>();
  
      List<Contact> contacts = [
        SELECT Id, Name, Email
        FROM Contact
        WHERE AccountId = :accountId
        WITH SECURITY_ENFORCED
      ];
      if (contacts.size() < 1) {
        return results;
      }
  
      BookMeCloseContactTuple t = new BookMeCloseContactTuple();
  
      t.relation = 'Ejer';
      t.contact = contacts[0];
      t.isSelected = null;
  
      results.add(t);
      return results;
    }

    public Object call(String action, Map<String, Object> args) {
        switch on action {
          when 'findContacts' {
            return findContacts(
              (String) args.get('searchQuery')
            );
          }
          when 'getCloseContactRelations' {
            Object bookMeDto = args.get('dto');
            // get account id from dto
            Callable c = (Callable) bookMeDto;

            String accountId = (String) c.call('accountId', new Map<String, object>());

            return getCloseContactRelations(accountId);
          }
          when else {
            return null;
          }
        }
      }
  }