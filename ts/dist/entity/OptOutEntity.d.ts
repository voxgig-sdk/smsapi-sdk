import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { OptOut, OptOutListMatch, OptOutRemoveMatch } from '../SmsapiTypes';
declare class OptOutEntity extends SmsapiEntityBase<OptOut> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: OptOutEntity): OptOutEntity;
    list(this: any, reqmatch?: OptOutListMatch, ctrl?: Control): Promise<OptOutEntity[]>;
    remove(this: any, reqmatch?: OptOutRemoveMatch, ctrl?: Control): Promise<OptOutEntity>;
}
export { OptOutEntity };
