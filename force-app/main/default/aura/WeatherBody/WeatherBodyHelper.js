({
	editWeather : function(weatherInfo) {
		var weatherInfo = weatherInfo;
		if(weatherInfo.cod == 200){
			weatherInfo.weather = weatherInfo.weather[0];
			weatherInfo.dt = weatherInfo.dt.toString() + '000';
			weatherInfo.weather.icon = 'http://openweathermap.org/img/wn/' + weatherInfo.weather.icon + '@2x.png';
			weatherInfo.main.temp = Math.round(weatherInfo.main.temp - 273.15);
			weatherInfo.main.pressure = Math.round(weatherInfo.main.pressure / 1.333);
		} else {
			weatherInfo.name = weatherInfo.message;
		}
		
		return weatherInfo;
	},

	waiting : function (component) {
		component.set("v.spinner", true);
	},

	doneWaiting : function (component) {
		component.set("v.spinner", false);
	},

	getWetherInfo : function(component, city) {
		this.waiting(component);
		var action = component.get("c.getWeather");
		action.setParams({
			"customCity": city
		});
		action.setCallback(this, function(response) {
			var state = response.getState();
			if (state === "SUCCESS") {
				var weatherInfo = JSON.parse(response.getReturnValue());
				component.set("v.weather", this.editWeather(weatherInfo));
				component.set("v.City", null);
				this.doneWaiting(component);
			}
		});
		$A.enqueueAction(action);
	},

	setDefaultCity : function (component, city) {
		var action = component.get("c.setWeatherCity");
		action.setParams({
			"city": city
		});
		action.setCallback(this, function(response){
			var state = response.getState();
			if (state === "SUCCESS") {
				this.getWetherInfo(component);
				component.set("v.showForm", false);
			}
		});
		
		$A.enqueueAction(action);
	}

})