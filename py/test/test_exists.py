# Smsapi SDK exists test

import pytest
from smsapi_sdk import SmsapiSDK


class TestExists:

    def test_should_create_test_sdk(self):
        testsdk = SmsapiSDK.test(None, None)
        assert testsdk is not None
