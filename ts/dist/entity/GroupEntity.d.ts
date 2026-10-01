import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { Group, GroupLoadMatch, GroupUpdateData } from '../SmsapiTypes';
declare class GroupEntity extends SmsapiEntityBase<Group> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: GroupEntity): GroupEntity;
    load(this: any, reqmatch?: GroupLoadMatch, ctrl?: Control): Promise<GroupEntity>;
    update(this: any, reqdata?: GroupUpdateData, ctrl?: Control): Promise<GroupEntity>;
}
export { GroupEntity };
