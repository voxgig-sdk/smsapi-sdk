import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { Blacklist, BlacklistLoadMatch, BlacklistCreateData, BlacklistRemoveMatch } from '../SmsapiTypes';
declare class BlacklistEntity extends SmsapiEntityBase<Blacklist> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: BlacklistEntity): BlacklistEntity;
    load(this: any, reqmatch?: BlacklistLoadMatch, ctrl?: Control): Promise<BlacklistEntity>;
    create(this: any, reqdata?: BlacklistCreateData, ctrl?: Control): Promise<BlacklistEntity>;
    remove(this: any, reqmatch?: BlacklistRemoveMatch, ctrl?: Control): Promise<BlacklistEntity>;
}
export { BlacklistEntity };
