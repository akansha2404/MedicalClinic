({
    appointmentData: function( component ) {
        var action = component.get( "c.appointmentDetails" );
        action.setCallback( this, function( response ) {
            component.set('v.timings',response.getReturnValue())
            console.log(response.getReturnValue());
        });
        $A.enqueueAction( action );
    },
    deleteAppointmenthelper: function( component,idx ) {
        var actionRecord = component.get( "c.cancelEvent" );
        actionRecord.setParams({
            eventId: idx,
        });
        actionRecord.setCallback( this, function( response1 ) {
            console.log(response1.getReturnValue());
            $A.get('e.force:refreshView').fire();
        });
        $A.enqueueAction( actionRecord );
    }
})