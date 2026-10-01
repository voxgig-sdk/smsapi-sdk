
const { test, describe } = require('node:test')
const { equal } = require('node:assert')


const { SmsapiSDK } = require('..')


describe('exists', async () => {

  test('test-mode', async () => {
    const testsdk = await SmsapiSDK.test()
    equal(null !== testsdk, true)
  })

})
