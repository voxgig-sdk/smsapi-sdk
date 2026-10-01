import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { ContactsField, ContactsFieldListMatch, ContactsFieldCreateData, ContactsFieldUpdateData, ContactsFieldRemoveMatch } from '../SmsapiTypes';
declare class ContactsFieldEntity extends SmsapiEntityBase<ContactsField> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: ContactsFieldEntity): ContactsFieldEntity;
    list(this: any, reqmatch?: ContactsFieldListMatch, ctrl?: Control): Promise<ContactsFieldEntity[]>;
    create(this: any, reqdata?: ContactsFieldCreateData, ctrl?: Control): Promise<ContactsFieldEntity>;
    update(this: any, reqdata?: ContactsFieldUpdateData, ctrl?: Control): Promise<ContactsFieldEntity>;
    remove(this: any, reqmatch?: ContactsFieldRemoveMatch, ctrl?: Control): Promise<ContactsFieldEntity>;
}
export { ContactsFieldEntity };
