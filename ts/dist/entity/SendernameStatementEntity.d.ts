import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { SendernameStatement, SendernameStatementListMatch } from '../SmsapiTypes';
declare class SendernameStatementEntity extends SmsapiEntityBase<SendernameStatement> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: SendernameStatementEntity): SendernameStatementEntity;
    list(this: any, reqmatch?: SendernameStatementListMatch, ctrl?: Control): Promise<SendernameStatementEntity[]>;
}
export { SendernameStatementEntity };
