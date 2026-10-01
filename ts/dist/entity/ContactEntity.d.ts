import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { Contact, ContactLoadMatch, ContactListMatch, ContactCreateData, ContactUpdateData, ContactRemoveMatch } from '../SmsapiTypes';
declare class ContactEntity extends SmsapiEntityBase<Contact> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: ContactEntity): ContactEntity;
    load(this: any, reqmatch?: ContactLoadMatch, ctrl?: Control): Promise<ContactEntity>;
    list(this: any, reqmatch?: ContactListMatch, ctrl?: Control): Promise<ContactEntity[]>;
    create(this: any, reqdata?: ContactCreateData, ctrl?: Control): Promise<ContactEntity>;
    update(this: any, reqdata?: ContactUpdateData, ctrl?: Control): Promise<ContactEntity>;
    remove(this: any, reqmatch?: ContactRemoveMatch, ctrl?: Control): Promise<ContactEntity>;
}
export { ContactEntity };
