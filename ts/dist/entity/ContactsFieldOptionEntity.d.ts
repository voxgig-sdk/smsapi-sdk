import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { ContactsFieldOption, ContactsFieldOptionListMatch } from '../SmsapiTypes';
declare class ContactsFieldOptionEntity extends SmsapiEntityBase<ContactsFieldOption> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: ContactsFieldOptionEntity): ContactsFieldOptionEntity;
    list(this: any, reqmatch?: ContactsFieldOptionListMatch, ctrl?: Control): Promise<ContactsFieldOptionEntity[]>;
}
export { ContactsFieldOptionEntity };
