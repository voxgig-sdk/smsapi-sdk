import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { Callback, CallbackLoadMatch, CallbackListMatch, CallbackCreateData, CallbackUpdateData, CallbackRemoveMatch } from '../SmsapiTypes';
declare class CallbackEntity extends SmsapiEntityBase<Callback> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: CallbackEntity): CallbackEntity;
    load(this: any, reqmatch?: CallbackLoadMatch, ctrl?: Control): Promise<CallbackEntity>;
    list(this: any, reqmatch?: CallbackListMatch, ctrl?: Control): Promise<CallbackEntity[]>;
    create(this: any, reqdata?: CallbackCreateData, ctrl?: Control): Promise<CallbackEntity>;
    update(this: any, reqdata?: CallbackUpdateData, ctrl?: Control): Promise<CallbackEntity>;
    remove(this: any, reqmatch?: CallbackRemoveMatch, ctrl?: Control): Promise<CallbackEntity>;
}
export { CallbackEntity };
