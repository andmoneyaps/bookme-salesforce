global with sharing class BookMeMeetingConfiguration implements Callable {
    public Object call(String action, Map<String, Object> args) {
        if (action == 'getMeetingLocation') {
            Object dto = args.get('dto');
            Callable c = (Callable)dto;
            string location = (String)c.call('location', new Map<String,Object>());

            return getMeetingLocation(location);
        }
        if (action == 'getMeetingTitle') {
            Object dto = args.get('dto');
            Callable c = (Callable)dto;

            string title = (String)c.call('meetingTitle', new Map<String,Object>());

            return getMeetingTitle(title);
        }
        return null;
    }

    public String getMeetingLocation(String location) {
        return location;
    }

    public String getMeetingTitle(String title) {
        return title;
    }
}