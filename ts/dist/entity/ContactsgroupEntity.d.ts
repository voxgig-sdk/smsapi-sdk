import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { Contactsgroup, ContactsgroupListMatch, ContactsgroupCreateData, ContactsgroupUpdateData, ContactsgroupRemoveMatch } from '../SmsapiTypes';
declare class ContactsgroupEntity extends SmsapiEntityBase<Contactsgroup> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: ContactsgroupEntity): ContactsgroupEntity;
    list(this: any, reqmatch?: ContactsgroupListMatch, ctrl?: Control): Promise<ContactsgroupEntity[]>;
    create(this: any, reqdata?: ContactsgroupCreateData, ctrl?: Control): Promise<ContactsgroupEntity>;
    update(this: any, reqdata?: ContactsgroupUpdateData, ctrl?: Control): Promise<ContactsgroupEntity>;
    remove(this: any, reqmatch?: ContactsgroupRemoveMatch, ctrl?: Control): Promise<ContactsgroupEntity>;
}
export { ContactsgroupEntity };
