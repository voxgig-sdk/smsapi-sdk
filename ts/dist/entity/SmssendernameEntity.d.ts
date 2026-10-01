import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { Smssendername, SmssendernameCreateData, SmssendernameRemoveMatch } from '../SmsapiTypes';
declare class SmssendernameEntity extends SmsapiEntityBase<Smssendername> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: SmssendernameEntity): SmssendernameEntity;
    create(this: any, reqdata?: SmssendernameCreateData, ctrl?: Control): Promise<SmssendernameEntity>;
    remove(this: any, reqmatch?: SmssendernameRemoveMatch, ctrl?: Control): Promise<SmssendernameEntity>;
}
export { SmssendernameEntity };
