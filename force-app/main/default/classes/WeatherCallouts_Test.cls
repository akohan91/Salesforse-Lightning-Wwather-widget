@isTEst
public class WeatherCallouts_Test {
    @isTEst
    public static void getWeatherCallout_Test(){
        Test.setMock(HttpCalloutMock.class, new WeatherCallouts_Mock());

        HttpResponse response = WeatherCallouts.getWeatherCallout('Brest');

        System.assertEquals('{"coord": {"lon": 23.7, "lat": 52.1}}',  response.getBody());
        System.assertEquals('aplication/JSON', response.getHeader('Content-type'));
        System.assertEquals(200, response.getStatusCode());

    }
}