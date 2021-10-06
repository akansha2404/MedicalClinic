public class BookPatientAppointmentController {
    @AuraEnabled 
    public static Appointment__c searchLatestPatientAppointment(String searchTerm){   
        return [Select Physician__r.Specialization_Price__c,Patient__r.Name,Patient__r.Last_Name__c,Patient__r.Email__c,Patient__r.Street__c,Patient__r.City__c,Patient__r.Picture__c,Patient__r.Contact_Number__c,Id from Appointment__c
                where Patient__r.Name=:searchTerm OR Patient__r.Last_Name__c =:searchTerm OR Patient__r.Contact_Number__c=:searchTerm order by createdDate Desc limit 1];

    }
  
    
    @AuraEnabled 
    public static Map<String, String> specializationFieldValue(){
        Map<String, String> options = new Map<String, String>();
        
        Schema.DescribeFieldResult fieldResult = Physician__c.Specializations__c.getDescribe();
        
        List<Schema.PicklistEntry> pValues = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pValues) {
            
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
    @AuraEnabled
    public static  List<Physician__c> physicianBySpec(String specialization ) {
        List<Physician__c> physician = new  List<Physician__c>();
        physician= [Select Name,Last_Name__c,Email__c,Clinic__c,Specializations__c,Practicing_From__c,Picture_URL__c,Specialization_Price__c,Id from Physician__c where Specializations__c=:specialization];
        return physician;
    }
    @AuraEnabled
    public static  Physician__c physicianData(String Id ) {
        return [Select Name,Last_Name__c,Clinic__c,Specializations__c,Practicing_From__c,Picture_URL__c,Specialization_Price__c,Id from Physician__c where Id=:Id];
    }
    @AuraEnabled
    public static  List<wrapSlot> selectPhysicianTime(String physicianId,String selectedDate) {
        system.debug(selectedDate);
        List<String> physiciantimings = new  List<String>();
        Physician_Timing__c p= [Select Id,Timings__c from Physician_Timing__c where Physician__c=:physicianId and Active__c=true order by createdDate Desc];
        physiciantimings.addAll(p.Timings__c.split(';'));
        Date todaysDate=Date.valueOf(selectedDate);
        system.debug('todaysDate----'+todaysDate);
        List<wrapSlot>  wrapSlotList= new List<wrapSlot>();
        List<wrapSlot>  wrapSlotList1= new List<wrapSlot>();
        set<String>  timedata= new  set<String>();
        for(Event a: [Select Id,StartDateTime,EndDateTime,Physician__c from Event where Physician__c=:physicianId ]) {
            system.debug('------'+a);
            Date startdate=Date.newInstance(a.StartDateTime.year(),a.StartDateTime.month(),a.StartDateTime.day());
            system.debug(startdate);
            if(startdate==todaysDate){
                String times=String.valueOf(a.StartDateTime.format('hh:mm a'));
                System.debug(times);
                if(physiciantimings.contains(times)){
                    wrapSlotList.add(new wrapSlot(times,true));
                    timedata.add(times);
                }  
            }
            
        }
        for(String timings:physiciantimings){
            if(!timedata.contains(timings)){
                wrapSlotList.add(new wrapSlot(timings,false));
            }
        }
        system.debug(wrapSlotList);
        return wrapSlotList;
    }
    public class wrapSlot {
        @AuraEnabled
        public String Timing {get; set;}
        @AuraEnabled
        public Boolean isBooked {get; set;}
        
        public wrapSlot(String t,boolean booking) {
            Timing = t;
            isBooked = booking;
        }
    }
    
}