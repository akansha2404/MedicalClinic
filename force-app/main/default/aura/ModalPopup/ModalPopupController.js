({
 closeModal : function(component, event, helper) {
 // when a component is dynamically created in lightning, we use destroy() method to destroy it.
 component.destroy();
 },
 
 // action to execute when save button is clicked
 handleSave : function(component, event, helper) {
 // We are showing an alert box here, you can perform any stuff here.
 alert('Do Some action on me');
 component.destroy();
 }
})