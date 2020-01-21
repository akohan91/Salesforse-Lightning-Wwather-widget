({
	refresh : function (component, event, helper) {
		helper.getWetherInfo(component, null)
	},

	chengeCity: function (component, event, helper) {
		var inputValue	= component.find("cityForm").get("v.value");
		var isCityDefault 	= component.find("cityDefault").get("v.checked");
		var city 			= component.get("v.City");
		
		if (inputValue && !isCityDefault){
			helper.getWetherInfo(component, city);
		} else if (inputValue && isCityDefault){
			localStorage.setItem('myCustomSity', city);
			helper.getWetherInfo(component, null);
		}
	},

	showForm : function (component) {
		var isShowForm = component.get("v.showForm");
		component.set("v.showForm", isShowForm ? false : true);
	},

	resetDefault : function (component, event, helper) {
		localStorage.removeItem('myCustomSity');
		helper.getWetherInfo(component, null);
	}
})