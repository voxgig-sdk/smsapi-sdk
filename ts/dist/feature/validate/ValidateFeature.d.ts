import type { Context, FeatureOptions } from '../../types';
import type { SmsapiSDK } from '../../SmsapiSDK';
import { BaseFeature } from '../base/BaseFeature';
declare class ValidateFeature extends BaseFeature {
    version: string;
    name: string;
    active: boolean;
    _client?: SmsapiSDK;
    _options: any;
    _spec: Record<string, any>;
    _request: boolean;
    _response: boolean;
    _mode: string;
    init(ctx: Context, options: FeatureOptions): void | Promise<any>;
    PreSpec(this: any, ctx: any): any;
    PreDone(this: any, ctx: any): any;
    _payload(this: any, ctx: any, opname: string): Record<string, any>;
    _entitySpec(this: any, ctx: any): any;
    _check(this: any, ctx: any, data: any, spec: any, direction: string): string[];
}
export { ValidateFeature };
