public with sharing class WeatherCallouts {
    private static final String E_P_BASE    = 'http://api.openweathermap.org/data/2.5/weather?q=';
    private static final String E_P_KEY     = '&APPID=72b00121df4248c63ed3d4eef63544f1';
    private static 		 String E_P;

    public static HttpResponse getWeatherCallout(String city){
        E_P = E_P_BASE + city + E_P_KEY;

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(E_P);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        return response;
    }
}