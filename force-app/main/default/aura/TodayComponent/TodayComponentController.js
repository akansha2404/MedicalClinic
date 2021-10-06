({
    init : function(component, event, helper) {
        var today = new Date();
        component.set('v.today', today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate());
        helper.appointmentData( component );
    },
    deleteAppointment : function(component, event, helper) {	
        var idx = event.target.id;
        helper.deleteAppointmenthelper( component ,idx);
    },
    navigate:function(component){
        var idx= event.currentTarget.id;
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": idx,
            "slideDevName": "detail"
            
        });
        navEvt.fire(); 
    }   
})