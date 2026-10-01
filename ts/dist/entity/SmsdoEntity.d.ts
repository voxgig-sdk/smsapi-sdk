import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { Smsdo, SmsdoCreateData } from '../SmsapiTypes';
declare class SmsdoEntity extends SmsapiEntityBase<Smsdo> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: SmsdoEntity): SmsdoEntity;
    create(this: any, reqdata?: SmsdoCreateData, ctrl?: Control): Promise<SmsdoEntity>;
}
export { SmsdoEntity };
