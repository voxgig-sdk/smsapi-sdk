<?php
declare(strict_types=1);

// Smsapi SDK log feature

require_once __DIR__ . '/BaseFeature.php';

class SmsapiLogFeature extends SmsapiBaseFeature
{
    private mixed $client;
    private ?array $options;
    private mixed $logger;

    public function __construct()
    {
        parent::__construct();
        $this->version = '0.0.1';
        $this->name = 'log';
        $this->active = true;
        $this->client = null;
        $this->options = null;
        $this->logger = null;
    }

    public function init(SmsapiContext $ctx, array $options): void
    {
        $this->client = $ctx->client;
        $this->options = $options;
        $this->active = ($options['active'] ?? null) === true;

        if ($this->active) {
            if (isset($options['logger'])) {
                $this->logger = $options['logger'];
            } else {
                $this->logger = STDERR;
            }
        }
    }

    // A log line leaves the pipeline, so it is cleaned before the logger
    // sees it.
    private function _loghook(string $hook, SmsapiContext $ctx, string $level = 'info'): void
    {
        if (!$this->logger) {
            return;
        }
        $opname = $ctx->op ? $ctx->op->name : '';
        $msg = "hook={$hook} op={$opname}";
        $line = ($ctx->utility->clean)($ctx, "[" . strtoupper($level) . "] {$msg}");
        if (is_resource($this->logger)) {
            fwrite($this->logger, $line . "\n");
        } elseif (is_callable($this->logger)) {
            ($this->logger)($line);
        }
    }

    public function PostConstruct(SmsapiContext $ctx): void { $this->_loghook('PostConstruct', $ctx); }
    public function PostConstructEntity(SmsapiContext $ctx): void { $this->_loghook('PostConstructEntity', $ctx); }
    public function SetData(SmsapiContext $ctx): void { $this->_loghook('SetData', $ctx); }
    public function GetData(SmsapiContext $ctx): void { $this->_loghook('GetData', $ctx); }
    public function SetMatch(SmsapiContext $ctx): void { $this->_loghook('SetMatch', $ctx); }
    public function GetMatch(SmsapiContext $ctx): void { $this->_loghook('GetMatch', $ctx); }
    public function PrePoint(SmsapiContext $ctx): void { $this->_loghook('PrePoint', $ctx); }
    public function PreSpec(SmsapiContext $ctx): void { $this->_loghook('PreSpec', $ctx); }
    public function PreRequest(SmsapiContext $ctx): void { $this->_loghook('PreRequest', $ctx); }
    public function PreResponse(SmsapiContext $ctx): void { $this->_loghook('PreResponse', $ctx); }
    public function PreResult(SmsapiContext $ctx): void { $this->_loghook('PreResult', $ctx); }
}
