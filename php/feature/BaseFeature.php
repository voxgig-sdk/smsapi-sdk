<?php
declare(strict_types=1);

// Smsapi SDK base feature

class SmsapiBaseFeature
{
    public string $version;
    public string $name;
    public bool $active;

    // Positions this feature when added via the client `extend` option:
    // "__before__" / "__after__" / "__replace__" name an already-added
    // feature (mirrors the ts feature `_options`). Declared so setting it
    // on an extension instance avoids the dynamic-property deprecation.
    public ?array $_options = null;

    public function __construct()
    {
        $this->version = '0.0.1';
        $this->name = 'base';
        $this->active = true;
    }

    public function get_version(): string { return $this->version; }
    public function get_name(): string { return $this->name; }
    public function get_active(): bool { return $this->active; }

    public function init(SmsapiContext $ctx, array $options): void {}
    public function PostConstruct(SmsapiContext $ctx): void {}
    public function PostConstructEntity(SmsapiContext $ctx): void {}
    public function SetData(SmsapiContext $ctx): void {}
    public function GetData(SmsapiContext $ctx): void {}
    public function GetMatch(SmsapiContext $ctx): void {}
    public function SetMatch(SmsapiContext $ctx): void {}
    public function PrePoint(SmsapiContext $ctx): void {}
    public function PreSpec(SmsapiContext $ctx): void {}
    public function PreRequest(SmsapiContext $ctx): void {}
    public function PreResponse(SmsapiContext $ctx): void {}
    public function PreResult(SmsapiContext $ctx): void {}
    public function PreDone(SmsapiContext $ctx): void {}
    public function PreUnexpected(SmsapiContext $ctx): void {}
}
