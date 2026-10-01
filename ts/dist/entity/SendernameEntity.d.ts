import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { Sendername, SendernameLoadMatch, SendernameListMatch, SendernameCreateData } from '../SmsapiTypes';
declare class SendernameEntity extends SmsapiEntityBase<Sendername> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: SendernameEntity): SendernameEntity;
    load(this: any, reqmatch?: SendernameLoadMatch, ctrl?: Control): Promise<SendernameEntity>;
    list(this: any, reqmatch?: SendernameListMatch, ctrl?: Control): Promise<SendernameEntity[]>;
    create(this: any, reqdata?: SendernameCreateData, ctrl?: Control): Promise<SendernameEntity>;
}
export { SendernameEntity };
