import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { Permission, PermissionLoadMatch, PermissionCreateData } from '../SmsapiTypes';
declare class PermissionEntity extends SmsapiEntityBase<Permission> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: PermissionEntity): PermissionEntity;
    load(this: any, reqmatch?: PermissionLoadMatch, ctrl?: Control): Promise<PermissionEntity>;
    create(this: any, reqdata?: PermissionCreateData, ctrl?: Control): Promise<PermissionEntity>;
}
export { PermissionEntity };
