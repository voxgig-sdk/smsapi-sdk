
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { SmsapiSDK } from '..'


describe('exists', async () => {

  test('test-mode', () => {
    const testsdk = SmsapiSDK.test()
    equal(testsdk instanceof SmsapiSDK, true,
      'SmsapiSDK.test() must return a client synchronously')
  })

})
