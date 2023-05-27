import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import duplicateRecordA from '@salesforce/apex/duplicate.duplicateRecordA';

export default class ToastNotificationExampleLWC extends LightningElement {

    @api msg
    @api recordId

    showInfoToast2() {
        const evt = new ShowToastEvent({
            message: 'It looks as if duplicates exist for this Account.',
            variant: 'info',
            mode: 'sticky'
        });
        this.dispatchEvent(evt);
    }

    showSuccessToast() {
        const evt = new ShowToastEvent({
            title: 'It looks as if duplicates does not exist for this Record.',
            variant: 'success',
            mode: 'sticky'
        });
        this.dispatchEvent(evt);
    }

    @wire(duplicateRecordA , { idString: '$recordId' })
    wiredRecordsMethod({ error, data }) {
        console.log('Hello'+data);
        if (data) {
            this.showInfoToast2();
        } else if (error) {
            this.error = error;
            this.data  = undefined;
        }
    }

}