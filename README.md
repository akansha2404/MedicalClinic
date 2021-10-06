# Medical Clinic App
Medical Clinic App Document

# Data Model 
Clinic
Patients 
Physician 
Appointment
Prescribed Test 
Medication
Physician Timing
Event

# Lightning Component 
BookPatientAppointment.cmp
TodayComponent.cmp
BookMedicationandGenerateBill.cmp

# Apex  Classes 
Bookpatientappointmentcontroller.apxc 
TodayComponentController.apxc
GoogleWebService.apxc
AppointmentTriggerHandler.apxc

# Apex  trigger 
Appointmenttrigger.apxt

# Email  template 
Send email notification to the patient

# work flow to send  notification 
Send appointment to the patient

# Flow
> On the home page, the receptionist will see today’s appointment and upcoming appointments.
> The receptionist can search for physicians based on specialization.
> And can see detail about physician and appointment fees and then they will get the option to book an appointment
> Appointment time will appear based on physician available slots.
> Once an appointment is created email will be sent to the Patient.
>  Physician and Patient google calendar will be booked for the Appointment time.
> Receptionist will have the option to cancel the appointment.
> once the appointment gets cancelled, google calendar invite will be deleted and a cancel notification will be sent to the Patient.
> Dashboard to see appointment by Physician and specialization also added to home page.
> Added option to check Patient latest appointment and add medication.








