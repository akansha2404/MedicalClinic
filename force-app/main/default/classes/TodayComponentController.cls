public  class TodayComponentController {
    @AuraEnabled 
    public static List<wrapSlot>   appointmentDetails(){
        List<wrapSlot>  wrapSlotList= new List<wrapSlot>();
        for(Event ap:[Select EndDateTime,What.Name,CreatedDate__c,Appointment__c,StartDateTime,Subject,Id,Physician__c from Event  where CreatedById=:userInfo.getUserId() and Physician__c!=null]){
            Date startdate=Date.newInstance(ap.StartDateTime.year(),ap.StartDateTime.month(),ap.StartDateTime.day());
            wrapSlot wrap=new wrapSlot();
            wrap.startDate=startdate;
            wrap.timing=String.valueOf(ap.StartDateTime.format('hh:mm a'));
            wrap.appointmentId=ap.Appointment__c;
            wrap.physicianId=ap.Physician__c;
            wrap.eventId=ap.Id;
            if(startdate==system.today()){
                wrap.isTodays=true;
                wrapSlotList.add(wrap);
            }else{
                if(startdate>system.today()){
                    wrap.isTodays=false;
                    wrapSlotList.add(wrap);
                }
            }
        }
        system.debug(wrapSlotList);
        return wrapSlotList;
        
    }
    @AuraEnabled 
    public static boolean cancelEvent(String eventId){
        List<Event> listOfEvent= new List<Event>();
        set<Id> setOfAppointmentId= new set<Id>();
        for(Event ap:[Select Id,Appointment__c,Appointment__r.GoogleEventId__c,Appointment__r.CalendarId__c from Event  where Id=:eventId ]){
            setOfAppointmentId.add(ap.Appointment__c);
            listOfEvent.add(ap);
            GoogleWebService.deleteCalendarEvent(ap.Appointment__r.CalendarId__c,ap.Appointment__r.GoogleEventId__c);
        }
        List<Appointment__c> listOfAppointment= new List<Appointment__c>([Select Id from Appointment__c where Id IN:setOfAppointmentId]);
        if(!listOfAppointment.isEmpty()){delete listOfAppointment;}
        if(!listOfEvent.isEmpty()){delete listOfEvent;}
        return true;
        
    }
    public class wrapSlot {
        @AuraEnabled
        public Date startDate {get; set;}
        @AuraEnabled
        public String timing {get; set;}
        @AuraEnabled
        public Id appointmentId {get; set;}
        @AuraEnabled
        public Id physicianId {get; set;}
        
        @AuraEnabled
        public Id eventId {get; set;}
        
        @AuraEnabled
        public boolean isTodays {get; set;}
        
        public wrapSlot() {
            startDate = startDate;
            timing=timing;
            appointmentId=appointmentId;
            physicianId=physicianId;
            eventId=eventId;
            isTodays = isTodays;
        }
    }
    
}