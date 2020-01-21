public with sharing class WeatherControllerBack {
    private static Id      currentUserId   = UserInfo.getUserId();
    @TestVisible
    private static User    currentUser     = [SELECT City  FROM User WHERE Id = :currentUserId];
    @TestVisible
    private static weathwidget__Weather_widget__mdt metaSet = [SELECT weathwidget__DefaultCity__c FROM weathwidget__Weather_widget__mdt];

    @AuraEnabled
    public static Object getWeather(String customCity) {
        String city = customCity != null ? customCity : city();
        Object weather;
        HTTPResponse weatherRes = WeatherCallouts.getWeatherCallout(city);
        weather = weatherRes.getBody();
        return weather;
    }

    @TestVisible
    private static String city(){
        String city;

        // From USER
        if ( !String.isBlank(currentUser.City) ) {
            city = currentUser.City;
        // From METADATA default   
        } else {
            city = metaSet.weathwidget__DefaultCity__c;
        }

        return city;
    }
}