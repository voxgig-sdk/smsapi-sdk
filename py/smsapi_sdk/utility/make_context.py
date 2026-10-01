# Smsapi SDK utility: make_context

from smsapi_sdk.core.context import SmsapiContext


def make_context_util(ctxmap, basectx):
    return SmsapiContext(ctxmap, basectx)
