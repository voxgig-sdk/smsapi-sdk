import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { Ping, PingListMatch } from '../SmsapiTypes';
declare class PingEntity extends SmsapiEntityBase<Ping> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: PingEntity): PingEntity;
    list(this: any, reqmatch?: PingListMatch, ctrl?: Control): Promise<PingEntity[]>;
}
export { PingEntity };
