({
    getPicklistValues: function(component, event) {
        var action = component.get("c.specializationFieldValue");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                var fieldMap = [];
                for(var key in result){
                    fieldMap.push({key: key, value: result[key]});
                }
                component.set('v.fieldMap', fieldMap);
            }
        });
        $A.enqueueAction(action);
    },
    handleDates: function( component,idx) {
        console.log(idx);
        var action = component.get( "c.selectPhysicianTime" );
        action.setParams({
            physicianId: idx,
            selectedDate :component.get('v.today')
        });
        action.setCallback( this, function( response ) {
            console.log(response.getReturnValue());
            component.set('v.timings',response.getReturnValue())
        });
        $A.enqueueAction( action );
        
    },
    physicianData:function(component,idx){
        var actionRecord = component.get( "c.physicianData" );
        actionRecord.setParams({
            Id: idx,
        });
        actionRecord.setCallback( this, function( response1 ) {
            component.set('v.physicianRecord',response1.getReturnValue())
        });
        $A.enqueueAction( actionRecord );
    },
    bookAppointmentSlothelper : function(component, event, helper,timing) {
        console.log(timing);
        var selectedDate=component.get('v.today');
        var physicianRecord = component.get('v.physicianRecord');
        var createAppointMentEvent = $A.get("e.force:createRecord");
        createAppointMentEvent.setParams({
            "entityApiName": "Appointment__c",
            "defaultFieldValues": {
                'Physician__c' :physicianRecord.Id,
                'Appointment_Status__c':'Booked',
                'Start_Time__c': selectedDate,
                'StartTiming__c': timing,
                'Clinic__c':physicianRecord.Clinic__c,
                'Booking_Channel__c':'Cardiology Appointment'
            }
        });
        createAppointMentEvent.fire();
        component.set('v.isModalOpen', false);
    }
})