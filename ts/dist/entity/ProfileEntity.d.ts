import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { Profile, ProfileLoadMatch, ProfileListMatch } from '../SmsapiTypes';
declare class ProfileEntity extends SmsapiEntityBase<Profile> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: ProfileEntity): ProfileEntity;
    load(this: any, reqmatch?: ProfileLoadMatch, ctrl?: Control): Promise<ProfileEntity>;
    list(this: any, reqmatch?: ProfileListMatch, ctrl?: Control): Promise<ProfileEntity[]>;
}
export { ProfileEntity };
