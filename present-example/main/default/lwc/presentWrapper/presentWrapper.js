import getCustomerTypeFromEvent from "@salesforce/apex/PresentCustomerTypeController.getCustomerTypeFromEvent";
import { LightningElement, api, wire } from "lwc";

export default class PresentWrapper extends LightningElement {
  @api recordId;

  customerType;
  _getCustomerTypeResponse;

  @wire(getCustomerTypeFromEvent, { eventId: "$recordId" })
  async wiredGetCustomerTypeFromEvents(response) {
    this._getCustomerTypeResponse = response;

    const { data, error } = response;

    if (data) {
      this.customerType = data.value;
    } else if (error) {
      this.customerType = "PRIVATE";
    }
  }
}
