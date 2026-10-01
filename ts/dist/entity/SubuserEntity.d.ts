import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { Subuser, SubuserLoadMatch, SubuserListMatch, SubuserCreateData, SubuserUpdateData, SubuserRemoveMatch } from '../SmsapiTypes';
declare class SubuserEntity extends SmsapiEntityBase<Subuser> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: SubuserEntity): SubuserEntity;
    load(this: any, reqmatch?: SubuserLoadMatch, ctrl?: Control): Promise<SubuserEntity>;
    list(this: any, reqmatch?: SubuserListMatch, ctrl?: Control): Promise<SubuserEntity[]>;
    create(this: any, reqdata?: SubuserCreateData, ctrl?: Control): Promise<SubuserEntity>;
    update(this: any, reqdata?: SubuserUpdateData, ctrl?: Control): Promise<SubuserEntity>;
    remove(this: any, reqmatch?: SubuserRemoveMatch, ctrl?: Control): Promise<SubuserEntity>;
}
export { SubuserEntity };
