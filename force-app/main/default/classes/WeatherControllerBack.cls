public with sharing class WeatherControllerBack {
    private static Id      currentUserId   = UserInfo.getUserId();
    @TestVisible
    private static User    currentUser     = [SELECT City  FROM User WHERE Id = :currentUserId];
    @TestVisible
    private static weathwidget__Weather_widget__mdt metaSet = [SELECT weathwidget__DefaultCity__c, weathwidget__CustomCity__c FROM weathwidget__Weather_widget__mdt];

    @AuraEnabled
    public static Object getWeather(String customCity) {
        String city = customCity != null ? customCity : city();
        Object weather;
        HTTPResponse weatherRes = WeatherCallouts.getWeatherCallout(city);
        weather = weatherRes.getBody();
        return weather;
    }

    @AuraEnabled
    public static Id setWeatherCity(String city){
        Metadata.DeployContainer mdContainer = createDeployContainer(city);
        Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, null);
        return jobId;
    }

    public static Metadata.DeployContainer createDeployContainer (String city){
        Metadata.CustomMetadata customMetadata =  new Metadata.CustomMetadata();
        customMetadata.fullName = 'weathwidget__Weather_widget.City_Settings';
        customMetadata.label    = 'City Settings';
        
        Metadata.CustomMetadataValue customCity = new Metadata.CustomMetadataValue();
        customCity.field = 'weathwidget__CustomCity__c';
        customCity.value = city; 
        customMetadata.values.add(customCity);
        
        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        mdContainer.addMetadata(customMetadata);

        return mdContainer;
    }

    @TestVisible
    private static String city(){
        String city;
        // From METADATA custom 
        if( !String.isBlank(metaSet.weathwidget__CustomCity__c) ){
            city = metaSet.weathwidget__CustomCity__c;
        // From USER
        } else if ( !String.isBlank(currentUser.City) ) {
            city = currentUser.City;
        // From METADATA default   
        } else {
            city = metaSet.weathwidget__DefaultCity__c;
        }

        return city;
    }
}