global without sharing class PresentNextBestAction implements Callable {
  Map<Id, String> getRecommendations(
    String customerType,
    List<String> sections
  ) {
    Map<Id, String> recommendations = new Map<Id, String>();

    for (String section : sections) {
      recommendations.put(
        section,
        'This is a demo implementation - Next best action for ' + customerType
      );
    }

    return recommendations;
  }

  public Object call(String action, Map<String, Object> args) {
    switch on action {
      when 'getRecommendations' {
        Map<Id, String> result = this.getRecommendations(
          (String) args.get('customerType'),
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
