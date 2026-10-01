import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { Available, AvailableListMatch } from '../SmsapiTypes';
declare class AvailableEntity extends SmsapiEntityBase<Available> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: AvailableEntity): AvailableEntity;
    list(this: any, reqmatch?: AvailableListMatch, ctrl?: Control): Promise<AvailableEntity[]>;
}
export { AvailableEntity };
