import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { SentRcsMessage, SentRcsMessageCreateData } from '../SmsapiTypes';
declare class SentRcsMessageEntity extends SmsapiEntityBase<SentRcsMessage> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: SentRcsMessageEntity): SentRcsMessageEntity;
    create(this: any, reqdata?: SentRcsMessageCreateData, ctrl?: Control): Promise<SentRcsMessageEntity>;
}
export { SentRcsMessageEntity };
