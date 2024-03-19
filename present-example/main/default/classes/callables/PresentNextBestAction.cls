global without sharing class PresentNextBestAction implements Callable {
  Map<Id, String> getRecommendations(Id recordId, List<String> sections) {
    Map<Id, String> recommendations = new Map<Id, String>();

    // Recommend 1 random section a master template
    Integer randomIndex = Integer.valueof((Math.random() * sections.size()));

    recommendations.put(
      sections[randomIndex],
      'Demo: This section is chosen at random' + recordId
    );

    return recommendations;
  }

  public Object call(String action, Map<String, Object> args) {
    switch on action {
      when 'getRecommendations' {
        Map<Id, String> result = this.getRecommendations(
          (Id) args.get('recordId'),
          (List<String>) args.get('sections')
        );
        return result;
      }
      when else {
        throw new NextBestActionMalformedCallException(
          'Called method is not implemented'
        );
      }
    }
  }

  public class NextBestActionMalformedCallException extends Exception {
  }
}