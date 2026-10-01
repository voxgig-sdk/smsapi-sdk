import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { MfaCode, MfaCodeCreateData } from '../SmsapiTypes';
declare class MfaCodeEntity extends SmsapiEntityBase<MfaCode> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: MfaCodeEntity): MfaCodeEntity;
    create(this: any, reqdata?: MfaCodeCreateData, ctrl?: Control): Promise<MfaCodeEntity>;
}
export { MfaCodeEntity };
