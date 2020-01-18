public with sharing class WeatherControllerBack {
    private static Id      currentUserId   = UserInfo.getUserId();
    private static User    currentUser     = [SELECT City  FROM User WHERE Id = :currentUserId];
    private static weathwidget__Weather_widget__mdt metaSet = [SELECT weathwidget__DefaultCity__c FROM weathwidget__Weather_widget__mdt];

    @AuraEnabled
    public static Map<String, String> getWeather() {
        Map<String, String> weatherMap = WeatherCallouts.getWeather(cityCountry());

        return weatherMap;
    }

    private static String cityCountry(){
        String city;
        // From sObject
        if( [SELECT count() FROM weathwidget__Weather_set__c] > 0 ){
            weathwidget__Weather_set__c customSet = [SELECT weathwidget__City__c 
                                                     FROM weathwidget__Weather_set__c];
            city = customSet.weathwidget__City__c;
        // From USER
        } else if ( !String.isBlank(currentUser.City) ) {
            city = currentUser.City;
        // From METADATA    
        } else {
            city = metaSet.weathwidget__DefaultCity__c;
        }

        return city;
    }
}