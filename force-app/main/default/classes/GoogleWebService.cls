public with sharing class GoogleWebService {
    /*Class to get calendar details
     * create calendar
     * create event
     * delete event*/
    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
    public static void getMyCalendar() {
        
        request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:Google_Connect/calendar/v3/users/me/calendarList');
        
        response = http.send(request); 
        
        System.debug(response.getBody());
    }
    public static void CreateCalender(String Summary) {
        String requestBody = '{'+
            '"summary":'+'"'+ Summary+'"'+
            '}';
        System.debug('#### requestBody '+requestBody);
        
        request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:Google_Connect/calendar/v3/calendars');
        request.setBody(requestBody);        
        response = http.send(request); 
        
        System.debug(response.getBody());
    }
    @future(callout=true)
    public static void doCreateNewEvent(set<Id> appointmentId) {
        String calendarId=System.Label.CalendarId;
        
        List<Appointment__c> appointList=[Select Id,PhysicianEmail__c,PatientEmail__c,Booking_Channel__c,Start_Date_Time__c,StartTime__c,Start_Time__c,Physician__c,End_Time__c from Appointment__c where Id IN:appointmentId ];
        for(Appointment__c app:appointList){
            String requestBody1 = '{'+
                '"end":'+'{'+
                '"dateTime":'+'"'+app.End_Time__c.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'')+'"'+','+
                '"timeZone":'+'"'+UserInfo.getTimeZone()+'"'+
                '},'+
                '"start": '+'{'+
                '"dateTime":'+'"'+app.Start_Date_Time__c.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'')+'"'+','+
                '"timeZone":'+ '"'+UserInfo.getTimeZone()+'"'+
                '}'+','+
                '"summary":'+'"'+ app.Booking_Channel__c+'"'+','+
                '"attendees":'+'['+
                '{'+'"email":'+ '"'+app.PhysicianEmail__c+'"'+'}'+','+
                '{'+'"email":'+ '"'+app.PatientEmail__c+'"'+'}'+
                ']'+
                '}';
            System.debug('#### requestBody1 '+requestBody1);
            
            request = new HttpRequest();
            request.setMethod('POST');
            request.setEndpoint('callout:Google_Connect/calendar/v3/calendars/gd8hiinn5lncjud972bpjncgj0@group.calendar.google.com/events');
            request.setBody(requestBody1);        
            response = http.send(request); 
        	Map<String, Object> mapOfString = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
          	app.GoogleEventId__c=(String)mapOfString.get('id');
          	app.CalendarId__c=calendarId;
            System.debug(response.getBody()); 
        }
        update appointList;
        
    }
     public static void deleteCalendarEvent(String calendarId,String eventId) {
            request = new HttpRequest();
            request.setMethod('DELETE');
            request.setEndpoint('callout:Google_Connect/calendar/v3/calendars/gd8hiinn5lncjud972bpjncgj0@group.calendar.google.com/events/'+eventId);
            response = http.send(request); 
            
            System.debug(response.getBody()); 
        }
        
    
}