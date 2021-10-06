trigger AppointmentTrigger on Appointment__c (after insert,before insert,after delete) {
        AppointmentTriggerHandler handler =new AppointmentTriggerHandler();
        if(Trigger.isbefore && Trigger.isInsert){
          handler.beforeInsert(Trigger.new);
        }
        
       
        if(Trigger.isAfter && Trigger.isInsert){
          handler.afterInsert(Trigger.new);
        }
        
        if(Trigger.isAfter && Trigger.isdelete){
          handler.afterDelete(Trigger.old);
        }
    }