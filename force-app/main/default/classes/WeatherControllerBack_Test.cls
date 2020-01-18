@isTEst
public class WeatherControllerBack_Test {
    @isTest
    public static void city_Test(){
        User currentUser = [SELECT Id, City FROM User WHERE Id = :UserInfo.getUserId()];

        currentUser.City = 'lida';
        WeatherControllerBack.currentUser = currentUser;
        String city = WeatherControllerBack.city();
        System.assertEquals('lida', city);

        currentUser.City = null;
        WeatherControllerBack.currentUser = currentUser;
        city = WeatherControllerBack.city();
        System.assertEquals('Brest', city);

        weathwidget__Weather_set__c weatherSet = new weathwidget__Weather_set__c(
            Name = 'Test',
            weathwidget__City__c = 'London'
        );
        Database.insert(weatherSet);
        city = WeatherControllerBack.city();
        System.assertEquals('London', city);
    }
    @isTEst
    public static void getWeather_Test(){
        Test.setMock(HttpCalloutMock.class, new WeatherCallouts_Mock());

        Object weather = WeatherControllerBack.getWeather();
        System.assertEquals('{"coord": {"lon": 23.7, "lat": 52.1}}', String.valueOf(weather));
    }
}