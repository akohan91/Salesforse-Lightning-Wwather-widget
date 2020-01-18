({
	setWeather : function(component, weatherInfo) {
		var weatherInfo = weatherInfo;

		weatherInfo.weather = weatherInfo.weather[0];
		weatherInfo.dt = weatherInfo.dt.toString() + '000';
		weatherInfo.weather.icon = 'http://openweathermap.org/img/wn/' + weatherInfo.weather.icon + '@2x.png';
		weatherInfo.main.temp = Math.round(weatherInfo.main.temp - 273.15);
		weatherInfo.main.pressure = Math.round(weatherInfo.main.pressure / 1.333);
		component.set("v.weather", weatherInfo);
	}
})