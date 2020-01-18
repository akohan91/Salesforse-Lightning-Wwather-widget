@isTest
public class WeatherCallouts_Mock implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest request){
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-type', 'aplication/JSON');
        response.setStatusCode(200);
        response.setBody('{"coord": {"lon": 23.7, "lat": 52.1}}');

        return response;
    } 
}