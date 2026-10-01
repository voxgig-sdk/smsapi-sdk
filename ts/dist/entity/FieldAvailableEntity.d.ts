import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { FieldAvailable, FieldAvailableListMatch } from '../SmsapiTypes';
declare class FieldAvailableEntity extends SmsapiEntityBase<FieldAvailable> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: FieldAvailableEntity): FieldAvailableEntity;
    list(this: any, reqmatch?: FieldAvailableListMatch, ctrl?: Control): Promise<FieldAvailableEntity[]>;
}
export { FieldAvailableEntity };
