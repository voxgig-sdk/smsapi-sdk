import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { Smstemplate, SmstemplateRemoveMatch } from '../SmsapiTypes';
declare class SmstemplateEntity extends SmsapiEntityBase<Smstemplate> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: SmstemplateEntity): SmstemplateEntity;
    remove(this: any, reqmatch?: SmstemplateRemoveMatch, ctrl?: Control): Promise<SmstemplateEntity>;
}
export { SmstemplateEntity };
