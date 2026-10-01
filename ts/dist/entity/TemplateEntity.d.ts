import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { Template, TemplateLoadMatch, TemplateListMatch, TemplateCreateData, TemplateUpdateData } from '../SmsapiTypes';
declare class TemplateEntity extends SmsapiEntityBase<Template> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: TemplateEntity): TemplateEntity;
    load(this: any, reqmatch?: TemplateLoadMatch, ctrl?: Control): Promise<TemplateEntity>;
    list(this: any, reqmatch?: TemplateListMatch, ctrl?: Control): Promise<TemplateEntity[]>;
    create(this: any, reqdata?: TemplateCreateData, ctrl?: Control): Promise<TemplateEntity>;
    update(this: any, reqdata?: TemplateUpdateData, ctrl?: Control): Promise<TemplateEntity>;
}
export { TemplateEntity };
