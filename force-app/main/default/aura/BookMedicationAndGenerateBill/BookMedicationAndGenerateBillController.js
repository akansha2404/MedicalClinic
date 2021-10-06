({
    onSearchTermChange : function(component, event, helper) {
        var searchTerm=component.get('v.searchTerm');
        helper.handleSearch(component,searchTerm);
    },
    bookMedication : function(component, event, helper) {
        helper.bookMedicationhelper(component, event, helper);
    }
    
})