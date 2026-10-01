import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { OptOutSetting, OptOutSettingLoadMatch, OptOutSettingUpdateData } from '../SmsapiTypes';
declare class OptOutSettingEntity extends SmsapiEntityBase<OptOutSetting> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: OptOutSettingEntity): OptOutSettingEntity;
    load(this: any, reqmatch?: OptOutSettingLoadMatch, ctrl?: Control): Promise<OptOutSettingEntity>;
    update(this: any, reqdata?: OptOutSettingUpdateData, ctrl?: Control): Promise<OptOutSettingEntity>;
}
export { OptOutSettingEntity };
