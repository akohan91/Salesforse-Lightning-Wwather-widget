@isTEst
public class WeatherControllerBack_Test {
    @isTEst
    public static void getWeather_Test(){
        Test.setMock(HttpCalloutMock.class, new WeatherCallouts_Mock());

        Object weather = WeatherControllerBack.getWeather('Sity');
        System.assertEquals('{"coord": {"lon": 23.7, "lat": 52.1}}', String.valueOf(weather));
    }

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
    }
}