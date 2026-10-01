import { SmsapiEntityBase } from '../SmsapiEntityBase';
import type { SmsapiSDK } from '../SmsapiSDK';
import type { Control } from '../types';
import type { ShipmentCountryVolume, ShipmentCountryVolumeListMatch } from '../SmsapiTypes';
declare class ShipmentCountryVolumeEntity extends SmsapiEntityBase<ShipmentCountryVolume> {
    constructor(client: SmsapiSDK, entopts: any);
    make(this: ShipmentCountryVolumeEntity): ShipmentCountryVolumeEntity;
    list(this: any, reqmatch?: ShipmentCountryVolumeListMatch, ctrl?: Control): Promise<ShipmentCountryVolumeEntity[]>;
}
export { ShipmentCountryVolumeEntity };
