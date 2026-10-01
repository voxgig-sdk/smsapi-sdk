import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { Rcs, RcsListMatch } from '../SmsapiTypes';
declare class RcsEntity extends SmsapiEntityBase<Rcs> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: RcsEntity): RcsEntity;
    list(this: any, reqmatch?: RcsListMatch, ctrl?: Control): Promise<RcsEntity[]>;
}
export { RcsEntity };
