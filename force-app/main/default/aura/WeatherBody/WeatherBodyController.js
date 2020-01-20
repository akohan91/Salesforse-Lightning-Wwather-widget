({
	refresh : function (component, event, helper) {
		helper.getWetherInfo(component);
	},

	setCity: function (component, event, helper) {
		var validField 		= component.find("cityForm").get("v.validity").valid;
		var isCityDefault 	= component.find("cityDefault").get("v.checked");
		var city = component.get("v.City");

		if (validField && isCityDefault){
			helper.setDefaultCity(component, city);
		} else if(validField && !isCityDefault){
			helper.getWetherInfo(component, city);
			component.set("v.showForm", false);
		}
	},

	showForm : function (component) {
		var isShowForm = component.get("v.showForm");
		
		component.set("v.showForm", isShowForm ? false : true);

	},
})