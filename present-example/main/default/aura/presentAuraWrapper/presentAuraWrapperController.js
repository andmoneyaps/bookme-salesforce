({
  init: function (component, event, helper) {
    // Retrieve recordId from context
    var recordId = component.get("v.recordId");

    // Call server-side action to get customerType
    var action = component.get("c.getCustomerTypeFromEvent");
    action.setParams({ recordId: recordId });

    action.setCallback(this, function (response) {
      var state = response.getState();
      if (state === "SUCCESS") {
        component.set("v.customerType", response.getReturnValue().value);
      } else if (state === "ERROR") {
        // Handle error by setting default value
        component.set("v.customerType", "PRIVATE");
      }
    });

    // Enqueue the action
    $A.enqueueAction(action);
  }
});
