import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import duplicateContact from '@salesforce/apex/duplicate.duplicateContact';

export default class ToastNotificationExampleLWC extends LightningElement {

    @api msg
    @api recordId

    showInfoToast() {
        const evt = new ShowToastEvent({
            message: 'It looks as if duplicates exits for this Contact.',
            variant: 'info',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }

    showSuccessToast() {
        const evt = new ShowToastEvent({
            title: 'It looks as if duplicates does not exits for this Contact.',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }

    @wire(duplicateContact , { ConId: '$recordId' })
    wiredRecordsMethod({ error, data }) {
        console.log('Hello'+data);
        if (data) {
            this.showInfoToast();
        } else if (error) {
            this.error = error;
            this.data  = undefined;
        }
    }

}