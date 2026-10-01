import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { UserRcsSenderCollection, UserRcsSenderCollectionListMatch } from '../SmsapiTypes';
declare class UserRcsSenderCollectionEntity extends SmsapiEntityBase<UserRcsSenderCollection> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: UserRcsSenderCollectionEntity): UserRcsSenderCollectionEntity;
    list(this: any, reqmatch?: UserRcsSenderCollectionListMatch, ctrl?: Control): Promise<UserRcsSenderCollectionEntity[]>;
}
export { UserRcsSenderCollectionEntity };
