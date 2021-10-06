({
    doInit : function(component, event, helper) {
        var today = new Date();
        component.set('v.today', today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate());
        helper.getPicklistValues(component, event);
    },
    
    bookAppointment: function(component, event, helper) {
        component.set('v.isModalOpen',true);
        var idx = event.target.id;
        helper.handleDates( component,idx );
        helper.physicianData( component,idx);
    },
    bookSlot: function(component, event, helper) {
        var physicianRecord = component.get('v.physicianRecord');
        helper.handleDates( component,physicianRecord.Id );
        
    },
    
    handleChange: function (component, event) {
        var selPickListValue = event.getSource().get("v.value");
        var action = component.get( "c.physicianBySpec" );
        action.setParams({
            specialization: selPickListValue
        });
        action.setCallback( this, function( response ) {
            component.set('v.physician',response.getReturnValue())
        });
        $A.enqueueAction( action );  
    },
    bookAppointmentSlot : function(component, event, helper) {
        var timing = event.target.id;
        helper.bookAppointmentSlothelper(component, event, helper,timing);
    },
    
    handleCancel : function(component, event, helper) {
        component.set('v.isModalOpen', false);
    }
    
})