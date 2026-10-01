import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { ShortUrl, ShortUrlLoadMatch, ShortUrlListMatch, ShortUrlCreateData, ShortUrlUpdateData, ShortUrlRemoveMatch } from '../SmsapiTypes';
declare class ShortUrlEntity extends SmsapiEntityBase<ShortUrl> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: ShortUrlEntity): ShortUrlEntity;
    load(this: any, reqmatch?: ShortUrlLoadMatch, ctrl?: Control): Promise<ShortUrlEntity>;
    list(this: any, reqmatch?: ShortUrlListMatch, ctrl?: Control): Promise<ShortUrlEntity[]>;
    create(this: any, reqdata?: ShortUrlCreateData, ctrl?: Control): Promise<ShortUrlEntity>;
    update(this: any, reqdata?: ShortUrlUpdateData, ctrl?: Control): Promise<ShortUrlEntity>;
    remove(this: any, reqmatch?: ShortUrlRemoveMatch, ctrl?: Control): Promise<ShortUrlEntity>;
}
export { ShortUrlEntity };
