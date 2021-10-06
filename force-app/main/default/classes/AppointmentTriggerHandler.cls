public class AppointmentTriggerHandler {
    public  void beforeInsert(List<Appointment__c> newAppointmentList){
        for(Appointment__c appointment:newAppointmentList){
            Time myTime = Time.newInstance(integer.valueof(appointment.StartTiming__c.substring(0,2)),Integer.valueof(appointment.StartTiming__c.substring(3,5)),00,00);
            appointment.StartTime__c=myTime;
            Datetime dt = Datetime.newInstance(appointment.Start_Time__c,appointment.StartTime__c);
            appointment.End_Time__c=dt.addMinutes(15);
            appointment.Start_Date_Time__c=dt;
            appointment.Physician_Email__c=appointment.PhysicianEmail__c;
            appointment.Patient_Email__c=appointment.PatientEmail__c;
            system.debug(appointment.Patient__c);
        }  
    }
    public void afterInsert(List<Appointment__c> newAppointmentList){
        set<Id> apppointmentData=new  set<Id>();
        List<Event> listOfEvent=new List<Event>();
        for(Appointment__c appointment:newAppointmentList){
            Event event=new Event();
            event.Physician__c=appointment.Physician__c;
            event.WhatId=appointment.Patient__c;
            event.Subject=appointment.Booking_Channel__c;
            event.StartDateTime=appointment.Start_Date_Time__c;
            event.EndDateTime=appointment.End_Time__c;
            event.Appointment__c=appointment.Id;
            listOfEvent.add(event);
            apppointmentData.add(appointment.Id);
        }  
        if(!listOfEvent.isEmpty()){
            insert listOfEvent;   
        }
        if(!apppointmentData.isEmpty()){
            GoogleWebService.doCreateNewEvent(apppointmentData);   
        }
    }
    public  void afterDelete(List<Appointment__c> oldAppointmentList){
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for(Appointment__c opp: oldAppointmentList)
        {
            if(opp.PatientEmail__c!=null){
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new String[] {opp.PatientEmail__c});
                email.setSubject('Appointment Cancelled Notification');
                email.setPlainTextBody('As per your unavailability for ' + opp.Booking_Channel__c + ' on'+opp.StartTime__c+' '+opp.StartTiming__c+'has been cancelled.');
                emails.add(email);      
            }
            
        }
        if(!emails.isEmpty()){
            Messaging.sendEmail(emails);
        }
        
    }
    
}