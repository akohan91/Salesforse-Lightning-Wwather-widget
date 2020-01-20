@isTEst
public class WeatherControllerBack_Test {
    @isTEst
    public static void getWeather_Test(){
        Test.setMock(HttpCalloutMock.class, new WeatherCallouts_Mock());

        Object weather = WeatherControllerBack.getWeather('Sity');
        System.assertEquals('{"coord": {"lon": 23.7, "lat": 52.1}}', String.valueOf(weather));
    }
    @isTest
    public static void createDeployContainer_Test(){
        Metadata.DeployContainer mdContainer = WeatherControllerBack.createDeployContainer('Lida');
        List<Metadata.Metadata> contents = mdContainer.getMetadata();
        Metadata.CustomMetadata customMetadata = (Metadata.CustomMetadata)contents.get(0);
        System.debug(customMetadata.values);
        System.assertEquals('weathwidget__Weather_widget.City_Settings', customMetadata.fullName);
        System.assertEquals('City Settings', customMetadata.label);
        System.assertEquals('weathwidget__CustomCity__c', customMetadata.values[0].field);
        System.assertEquals('Lida', customMetadata.values[0].value);
    }
    @isTest
    public static void city_Test(){
        User currentUser = [SELECT Id, City FROM User WHERE Id = :UserInfo.getUserId()];
        WeatherControllerBack.metaSet.weathwidget__CustomCity__c = null;

        currentUser.City = 'lida';
        WeatherControllerBack.currentUser = currentUser;
        String city = WeatherControllerBack.city();
        System.assertEquals('lida', city);

        currentUser.City = null;
        WeatherControllerBack.currentUser = currentUser;
        city = WeatherControllerBack.city();
        System.assertEquals('Brest', city);

        WeatherControllerBack.metaSet.weathwidget__CustomCity__c = 'London';

        city = WeatherControllerBack.city();
        System.assertEquals('London', city);
    }
}