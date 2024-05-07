public class AMBAdvisorCompetencesDTO implements Callable {
  public string email { get; set; }
  public list<string> meetingCompetences { get; set; }
  public list<string> customerCategoryCompetences { get; set; }

  public Object call(String action, Map<String, Object> args) {
    switch on action {
      when 'email' {
        return this.email;
      }
      when 'meetingCompetences' {
        return this.meetingCompetences;
      }
      when 'customerCategoryCompetences' {
        return this.customerCategoryCompetences;
      }
      when else {
        throw new AMBNotImplementedException(
          'Callable action "' + action + '" not implemented'
        );
      }
    }
  }
}
