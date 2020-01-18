public with sharing class WeatherCallouts {
    private static final String E_P_BASE    = 'http://api.openweathermap.org/data/2.5/weather?q=';
    private static final String E_P_KEY     = '&APPID=72b00121df4248c63ed3d4eef63544f1';
    private static 		String E_P;


    public static Map<String, String> getWeather(String city){
        E_P = E_P_BASE + city + E_P_KEY;
        Map<String, String> finalRes = new Map<String, String>();

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(E_P);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        Map<String, Object> result = new Map<String, Object>();
        if(response.getStatusCode() == 200){
            result = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());

            List<Object>        weatherList = (List<Object>)result.get('weather');
            Map<String, Object> weather     = (Map<String, Object>)weatherList[0];
            Map<String, Object> main        = (Map<String, Object>)result.get('main');
            Map<String, Object> wind        = (Map<String, Object>)result.get('wind');

            Integer temp    = ((Double)main.get('temp') - 273).intValue();
            Integer press   = ((Double)main.get('pressure') / 1.333).intValue();

            finalRes.put('City',        (String)result.get('name'));
            finalRes.put('Main',        (String)weather.get('main'));
            finalRes.put('Description', (String)weather.get('description'));
            finalRes.put('Dt',          String.valueOf(result.get('dt') ) + '000');
            finalRes.put('Humidity',    String.valueOf(main.get('humidity')));
            finalRes.put('WinterSpeed', String.valueOf(wind.get('speed')));
            finalRes.put('Temperature', String.valueOf(temp));
            finalRes.put('Pressure',    String.valueOf(press));
            finalRes.put('Icon',        'http://openweathermap.org/img/wn/' + (String)weather.get('icon') + '@2x.png');
        }
            return finalRes;
    }
}