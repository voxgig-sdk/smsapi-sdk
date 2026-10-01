import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { Contactstrash, ContactstrashUpdateData, ContactstrashRemoveMatch } from '../SmsapiTypes';
declare class ContactstrashEntity extends SmsapiEntityBase<Contactstrash> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: ContactstrashEntity): ContactstrashEntity;
    update(this: any, reqdata?: ContactstrashUpdateData, ctrl?: Control): Promise<ContactstrashEntity>;
    remove(this: any, reqmatch?: ContactstrashRemoveMatch, ctrl?: Control): Promise<ContactstrashEntity>;
}
export { ContactstrashEntity };
