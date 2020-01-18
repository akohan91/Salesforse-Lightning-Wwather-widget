({
	getWetherInfo : function(component, event, helper) {
		var action = component.get("c.getWeather");

		action.setCallback(this, function(response) {
			var state = response.getState();
			if (state === "SUCCESS") {
				var weatherInfo = JSON.parse(response.getReturnValue());
				helper.setWeather(component, weatherInfo);
			}
			else {
				console.log("Failed with state: " + state);
			}
		});

		$A.enqueueAction(action);
	}
})