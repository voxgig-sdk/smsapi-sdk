// Smsapi SDK exists test.

using Xunit;

using SmsapiSdk;

namespace SmsapiSdk.Test;

public class ExistsTest
{
    [Fact]
    public void TestMode()
    {
        var testsdk = SmsapiSDK.TestSDK(null, null);
        Assert.NotNull(testsdk);
    }
}
