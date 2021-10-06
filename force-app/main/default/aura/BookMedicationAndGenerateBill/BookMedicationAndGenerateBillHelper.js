({
    handleSearch: function( component, searchTerm ) {
        console.log(searchTerm);
        var action = component.get( "c.searchLatestPatientAppointment" );
        action.setParams({
            searchTerm: searchTerm
        });
        action.setCallback( this, function( response ) {
            component.set('v.appointmentData',response.getReturnValue())
            console.log(response.getReturnValue());
        });
        $A.enqueueAction( action );
    },
     bookMedicationhelper : function(component, event, helper) {
        var appointmentData = component.get("v.appointmentData");
        var createMedication = $A.get("e.force:createRecord");
        createMedication.setParams({
            "entityApiName": "Medication__c",
            "defaultFieldValues": {
                'Patient__c' :appointmentData.Patient__r.Id,
                'Appointment__c' :appointmentData.Id
            }
        });
        createMedication.fire();
    }
})