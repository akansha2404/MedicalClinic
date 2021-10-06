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

# Component Used Model 
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
> The receptionist can search physicians based on specialization.
> And can see detail about physician and appointment fees and then they will get option to book appointment
> Appointment time will appear based on physician available slots.
> Once appointment created email will be sent to Patient .
>  Physician and Patient google calendar will be booked for Appointment  time.
> Recieptionist will have option to cancel appointment.
> once appointment get cancelled,google calender invite will be deleted and cancel notification will be sent to Patient.
> Dashboard to see appointment by Physician and specialization also added to home page.
> Added option to check Patient latest appointment and add medication.









Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
