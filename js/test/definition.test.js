const { describe, test } = require('node:test')
const { SDK } = require('..')
const { runDefinitionPoint } = require('./definition-runner')
const { isControlSkipped } = require('./utility')


// Generated from the API definition, not from the model this SDK was built
// from: the route, the declared query parameters, the credential the security
// scheme names, and the definition's own response example.
const PLAN = [
  {
    "entity": "available",
    "accessor": "Available",
    "op": "list",
    "method": "GET",
    "path": "/sms/templates/available",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "size": 1,
      "collection": [
        {
          "name": "x",
          "normalize": true,
          "template": "x"
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "blacklist",
    "accessor": "Blacklist",
    "op": "create",
    "method": "POST",
    "path": "/blacklist/phone_numbers",
    "action": "phone_number",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 201,
    "sample": {
      "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "phone_number": "48327201200",
      "expire_at": "2017-07-21",
      "created_at": "2017-07-21T17:32:28Z"
    },
    "idField": "id"
  },
  {
    "entity": "blacklist",
    "accessor": "Blacklist",
    "op": "create",
    "method": "POST",
    "path": "/blacklist/phone_numbers/imports",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 202,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "blacklist",
    "accessor": "Blacklist",
    "op": "load",
    "method": "GET",
    "path": "/blacklist/phone_numbers",
    "action": "phone_number",
    "args": [],
    "select": {
      "limit": "v1",
      "offset": "v1",
      "q": "v1"
    },
    "headers": [
      {
        "name": "accept",
        "wire": "Accept",
        "value": "application/json"
      },
      {
        "name": "x_async",
        "wire": "x-async",
        "value": "h2"
      }
    ],
    "query": [
      "q",
      "offset",
      "limit"
    ],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "size": 1,
      "collection": [
        {
          "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "phone_number": "48327201200",
          "expire_at": "2017-07-21",
          "created_at": "2017-07-21T17:32:28Z"
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "blacklist",
    "accessor": "Blacklist",
    "op": "remove",
    "method": "DELETE",
    "path": "/blacklist/phone_numbers/{id}",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 204,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "blacklist",
    "accessor": "Blacklist",
    "op": "remove",
    "method": "DELETE",
    "path": "/blacklist/phone_numbers",
    "action": "phone_number",
    "args": [],
    "select": {
      "phone_number": "v1"
    },
    "headers": [],
    "query": [
      "phone_number"
    ],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 204,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "callback",
    "accessor": "Callback",
    "op": "create",
    "method": "POST",
    "path": "/callbacks",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 201,
    "sample": {
      "id": 0,
      "active": true,
      "invalid": false,
      "type": "sms_mo",
      "url": "http://example.com",
      "api_version": 1,
      "receiver_type": "all"
    },
    "idField": "id"
  },
  {
    "entity": "callback",
    "accessor": "Callback",
    "op": "list",
    "method": "GET",
    "path": "/callbacks",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "size": 1,
      "collection": [
        {
          "active": true,
          "api_version": 1,
          "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "invalid": true,
          "receiver": {
            "number": "123123123",
            "type": "number"
          },
          "type": "sms_mo",
          "url": "https://smsapi.pl"
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "callback",
    "accessor": "Callback",
    "op": "load",
    "method": "GET",
    "path": "/callbacks/{id}",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "active": true,
      "invalid": true,
      "url": "https://smsapi.pl",
      "api_version": 1,
      "type": "sms_mo",
      "receiver": {
        "number": "123123123",
        "type": "number"
      }
    },
    "idField": "id"
  },
  {
    "entity": "callback",
    "accessor": "Callback",
    "op": "load",
    "method": "GET",
    "path": "/callbacks/{id}/commands/test",
    "action": "command_test",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "test_result": true,
      "connection_failed": true,
      "invalid_encoding": true,
      "http_response_status": 1,
      "http_response_body": "x"
    },
    "idField": "id"
  },
  {
    "entity": "callback",
    "accessor": "Callback",
    "op": "remove",
    "method": "DELETE",
    "path": "/callbacks/{id}",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 204,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "callback",
    "accessor": "Callback",
    "op": "update",
    "method": "PUT",
    "path": "/callbacks/{id}",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "active": true,
      "invalid": true,
      "url": "https://smsapi.pl",
      "api_version": 1,
      "type": "sms_mo",
      "receiver": {
        "number": "123123123",
        "type": "number"
      }
    },
    "idField": "id"
  },
  {
    "entity": "callback",
    "accessor": "Callback",
    "op": "update",
    "method": "PUT",
    "path": "/callbacks/{id}/commands/activate",
    "action": "command_activate",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 202,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "callback",
    "accessor": "Callback",
    "op": "update",
    "method": "PUT",
    "path": "/callbacks/{id}/commands/deactivate",
    "action": "command_deactivate",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 202,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "contact",
    "accessor": "Contact",
    "op": "create",
    "method": "POST",
    "path": "/contacts/{contactId}/groups",
    "action": "group",
    "args": [
      {
        "name": "id",
        "wire": "contactId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "size": 1,
      "collection": [
        {}
      ]
    },
    "idField": "id"
  },
  {
    "entity": "contact",
    "accessor": "Contact",
    "op": "create",
    "method": "POST",
    "path": "/contacts",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "first_name": "John",
      "last_name": "Doe",
      "phone_number": "x",
      "email": "john.doe@example.com",
      "gender": "undefined",
      "birthday_date": "2017-07-21",
      "description": "Resource description",
      "city": "Example City",
      "country": "Example Country",
      "source": "Example Source",
      "date_created": "2017-07-21T17:32:28Z",
      "date_updated": "2017-07-21T17:32:28Z",
      "groups": [
        {
          "contact_expire_after": 1,
          "contacts_count": 1,
          "created_by": "example_username",
          "date_created": "2017-07-21T17:32:28Z",
          "date_updated": "2017-07-21T17:32:28Z",
          "description": "Resource description",
          "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "idx": "example-user-provided-id-123",
          "name": "Example Group",
          "permissions": [
            {
              "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
              "read": false,
              "send": false,
              "username": "example_username",
              "write": false
            }
          ]
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "contact",
    "accessor": "Contact",
    "op": "list",
    "method": "GET",
    "path": "/contacts",
    "args": [],
    "select": {
      "birthday_date": "v1",
      "email": "v1",
      "first_name": "v1",
      "gender": "v1",
      "group_id": "v1",
      "last_name": "v1",
      "limit": "v1",
      "offset": "v1",
      "order_by": "v1",
      "phone_number": "v1",
      "q": "v1"
    },
    "headers": [],
    "query": [
      "q",
      "offset",
      "limit",
      "order_by",
      "phone_number",
      "email",
      "first_name",
      "last_name",
      "group_id",
      "gender",
      "birthday_date"
    ],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "size": 1,
      "collection": [
        {
          "birthday_date": "2017-07-21",
          "city": "Example City",
          "contact_expire_after": 1,
          "contacts_count": 1,
          "country": "Example Country",
          "created_by": "example_username",
          "date_created": "2017-07-21T17:32:28Z",
          "date_updated": "2017-07-21T17:32:28Z",
          "description": "Resource description",
          "email": "john.doe@example.com",
          "first_name": "John",
          "gender": "undefined",
          "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "groups": [
            {
              "contact_expire_after": 1,
              "contacts_count": 1,
              "created_by": "example_username",
              "date_created": "2017-07-21T17:32:28Z",
              "date_updated": "2017-07-21T17:32:28Z",
              "description": "Resource description",
              "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
              "idx": "example-user-provided-id-123",
              "name": "Example Group",
              "permissions": []
            }
          ],
          "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "idx": "example-user-provided-id-123",
          "last_name": "Doe",
          "name": "Example Group",
          "permissions": [
            {
              "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
              "read": false,
              "send": false,
              "username": "example_username",
              "write": false
            }
          ],
          "phone_number": "x",
          "read": false,
          "send": false,
          "source": "Example Source",
          "type": "text",
          "username": "example_username",
          "value": "x",
          "write": false
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "contact",
    "accessor": "Contact",
    "op": "list",
    "method": "GET",
    "path": "/contacts/{contactId}/groups",
    "action": "group",
    "args": [
      {
        "name": "id",
        "wire": "contactId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "size": 1,
      "collection": [
        {
          "birthday_date": "2017-07-21",
          "city": "Example City",
          "contact_expire_after": 1,
          "contacts_count": 1,
          "country": "Example Country",
          "created_by": "example_username",
          "date_created": "2017-07-21T17:32:28Z",
          "date_updated": "2017-07-21T17:32:28Z",
          "description": "Resource description",
          "email": "john.doe@example.com",
          "first_name": "John",
          "gender": "undefined",
          "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "groups": [
            {
              "contact_expire_after": 1,
              "contacts_count": 1,
              "created_by": "example_username",
              "date_created": "2017-07-21T17:32:28Z",
              "date_updated": "2017-07-21T17:32:28Z",
              "description": "Resource description",
              "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
              "idx": "example-user-provided-id-123",
              "name": "Example Group",
              "permissions": []
            }
          ],
          "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "idx": "example-user-provided-id-123",
          "last_name": "Doe",
          "name": "Example Group",
          "permissions": [
            {
              "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
              "read": false,
              "send": false,
              "username": "example_username",
              "write": false
            }
          ],
          "phone_number": "x",
          "read": false,
          "send": false,
          "source": "Example Source",
          "type": "text",
          "username": "example_username",
          "value": "x",
          "write": false
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "contact",
    "accessor": "Contact",
    "op": "load",
    "method": "GET",
    "path": "/contacts/groups/{groupId}/members/{contactId}",
    "args": [
      {
        "name": "contact_id",
        "wire": "contactId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      },
      {
        "name": "group_id",
        "wire": "groupId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "first_name": "John",
      "last_name": "Doe",
      "phone_number": "x",
      "email": "john.doe@example.com",
      "gender": "undefined",
      "birthday_date": "2017-07-21",
      "description": "Resource description",
      "city": "Example City",
      "country": "Example Country",
      "source": "Example Source",
      "date_created": "2017-07-21T17:32:28Z",
      "date_updated": "2017-07-21T17:32:28Z",
      "groups": [
        {
          "contact_expire_after": 1,
          "contacts_count": 1,
          "created_by": "example_username",
          "date_created": "2017-07-21T17:32:28Z",
          "date_updated": "2017-07-21T17:32:28Z",
          "description": "Resource description",
          "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "idx": "example-user-provided-id-123",
          "name": "Example Group",
          "permissions": [
            {
              "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
              "read": false,
              "send": false,
              "username": "example_username",
              "write": false
            }
          ]
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "contact",
    "accessor": "Contact",
    "op": "load",
    "method": "GET",
    "path": "/contacts/{contactId}/groups/{groupId}",
    "args": [
      {
        "name": "group_id",
        "wire": "groupId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      },
      {
        "name": "id",
        "wire": "contactId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "name": "Example Group",
      "description": "Resource description",
      "contacts_count": 1,
      "date_created": "2017-07-21T17:32:28Z",
      "date_updated": "2017-07-21T17:32:28Z",
      "created_by": "example_username",
      "idx": "example-user-provided-id-123",
      "contact_expire_after": 1,
      "permissions": [
        {
          "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "read": false,
          "send": false,
          "username": "example_username",
          "write": false
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "contact",
    "accessor": "Contact",
    "op": "load",
    "method": "GET",
    "path": "/contacts/{contactId}",
    "args": [
      {
        "name": "id",
        "wire": "contactId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "first_name": "John",
      "last_name": "Doe",
      "phone_number": "x",
      "email": "john.doe@example.com",
      "gender": "undefined",
      "birthday_date": "2017-07-21",
      "description": "Resource description",
      "city": "Example City",
      "country": "Example Country",
      "source": "Example Source",
      "date_created": "2017-07-21T17:32:28Z",
      "date_updated": "2017-07-21T17:32:28Z",
      "groups": [
        {
          "contact_expire_after": 1,
          "contacts_count": 1,
          "created_by": "example_username",
          "date_created": "2017-07-21T17:32:28Z",
          "date_updated": "2017-07-21T17:32:28Z",
          "description": "Resource description",
          "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "idx": "example-user-provided-id-123",
          "name": "Example Group",
          "permissions": [
            {
              "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
              "read": false,
              "send": false,
              "username": "example_username",
              "write": false
            }
          ]
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "contact",
    "accessor": "Contact",
    "op": "remove",
    "method": "DELETE",
    "path": "/contacts/{contactId}/groups/{groupId}",
    "args": [
      {
        "name": "group_id",
        "wire": "groupId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      },
      {
        "name": "id",
        "wire": "contactId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 204,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "contact",
    "accessor": "Contact",
    "op": "remove",
    "method": "DELETE",
    "path": "/contacts/{contactId}",
    "args": [
      {
        "name": "id",
        "wire": "contactId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 204,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "contact",
    "accessor": "Contact",
    "op": "remove",
    "method": "DELETE",
    "path": "/contacts",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 202,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "contact",
    "accessor": "Contact",
    "op": "update",
    "method": "PUT",
    "path": "/contacts/groups/{groupId}/members/{contactId}",
    "args": [
      {
        "name": "contact_id",
        "wire": "contactId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      },
      {
        "name": "group_id",
        "wire": "groupId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "first_name": "John",
      "last_name": "Doe",
      "phone_number": "x",
      "email": "john.doe@example.com",
      "gender": "undefined",
      "birthday_date": "2017-07-21",
      "description": "Resource description",
      "city": "Example City",
      "country": "Example Country",
      "source": "Example Source",
      "date_created": "2017-07-21T17:32:28Z",
      "date_updated": "2017-07-21T17:32:28Z",
      "groups": [
        {
          "contact_expire_after": 1,
          "contacts_count": 1,
          "created_by": "example_username",
          "date_created": "2017-07-21T17:32:28Z",
          "date_updated": "2017-07-21T17:32:28Z",
          "description": "Resource description",
          "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "idx": "example-user-provided-id-123",
          "name": "Example Group",
          "permissions": [
            {
              "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
              "read": false,
              "send": false,
              "username": "example_username",
              "write": false
            }
          ]
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "contact",
    "accessor": "Contact",
    "op": "update",
    "method": "PUT",
    "path": "/contacts/{contactId}/groups/{groupId}",
    "args": [
      {
        "name": "group_id",
        "wire": "groupId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      },
      {
        "name": "id",
        "wire": "contactId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "size": 1,
      "collection": [
        {
          "birthday_date": "2017-07-21",
          "city": "Example City",
          "contact_expire_after": 1,
          "contacts_count": 1,
          "country": "Example Country",
          "created_by": "example_username",
          "date_created": "2017-07-21T17:32:28Z",
          "date_updated": "2017-07-21T17:32:28Z",
          "description": "Resource description",
          "email": "john.doe@example.com",
          "first_name": "John",
          "gender": "undefined",
          "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "groups": [
            {
              "contact_expire_after": 1,
              "contacts_count": 1,
              "created_by": "example_username",
              "date_created": "2017-07-21T17:32:28Z",
              "date_updated": "2017-07-21T17:32:28Z",
              "description": "Resource description",
              "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
              "idx": "example-user-provided-id-123",
              "name": "Example Group",
              "permissions": []
            }
          ],
          "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "idx": "example-user-provided-id-123",
          "last_name": "Doe",
          "name": "Example Group",
          "permissions": [
            {
              "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
              "read": false,
              "send": false,
              "username": "example_username",
              "write": false
            }
          ],
          "phone_number": "x",
          "read": false,
          "send": false,
          "source": "Example Source",
          "type": "text",
          "username": "example_username",
          "value": "x",
          "write": false
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "contact",
    "accessor": "Contact",
    "op": "update",
    "method": "PUT",
    "path": "/contacts/{contactId}",
    "args": [
      {
        "name": "id",
        "wire": "contactId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "first_name": "John",
      "last_name": "Doe",
      "phone_number": "x",
      "email": "john.doe@example.com",
      "gender": "undefined",
      "birthday_date": "2017-07-21",
      "description": "Resource description",
      "city": "Example City",
      "country": "Example Country",
      "source": "Example Source",
      "date_created": "2017-07-21T17:32:28Z",
      "date_updated": "2017-07-21T17:32:28Z",
      "groups": [
        {
          "contact_expire_after": 1,
          "contacts_count": 1,
          "created_by": "example_username",
          "date_created": "2017-07-21T17:32:28Z",
          "date_updated": "2017-07-21T17:32:28Z",
          "description": "Resource description",
          "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "idx": "example-user-provided-id-123",
          "name": "Example Group",
          "permissions": [
            {
              "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
              "read": false,
              "send": false,
              "username": "example_username",
              "write": false
            }
          ]
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "contacts_field",
    "accessor": "ContactsField",
    "op": "create",
    "method": "POST",
    "path": "/contacts/fields",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 201,
    "sample": {
      "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "name": "x",
      "type": "text"
    },
    "idField": "id"
  },
  {
    "entity": "contacts_field",
    "accessor": "ContactsField",
    "op": "list",
    "method": "GET",
    "path": "/contacts/fields",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "size": 1,
      "collection": [
        {
          "birthday_date": "2017-07-21",
          "city": "Example City",
          "contact_expire_after": 1,
          "contacts_count": 1,
          "country": "Example Country",
          "created_by": "example_username",
          "date_created": "2017-07-21T17:32:28Z",
          "date_updated": "2017-07-21T17:32:28Z",
          "description": "Resource description",
          "email": "john.doe@example.com",
          "first_name": "John",
          "gender": "undefined",
          "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "groups": [
            {
              "contact_expire_after": 1,
              "contacts_count": 1,
              "created_by": "example_username",
              "date_created": "2017-07-21T17:32:28Z",
              "date_updated": "2017-07-21T17:32:28Z",
              "description": "Resource description",
              "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
              "idx": "example-user-provided-id-123",
              "name": "Example Group",
              "permissions": []
            }
          ],
          "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "idx": "example-user-provided-id-123",
          "last_name": "Doe",
          "name": "Example Group",
          "permissions": [
            {
              "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
              "read": false,
              "send": false,
              "username": "example_username",
              "write": false
            }
          ],
          "phone_number": "x",
          "read": false,
          "send": false,
          "source": "Example Source",
          "type": "text",
          "username": "example_username",
          "value": "x",
          "write": false
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "contacts_field",
    "accessor": "ContactsField",
    "op": "remove",
    "method": "DELETE",
    "path": "/contacts/fields/{fieldId}",
    "args": [
      {
        "name": "id",
        "wire": "fieldId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 204,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "contacts_field",
    "accessor": "ContactsField",
    "op": "update",
    "method": "PUT",
    "path": "/contacts/fields/{fieldId}",
    "args": [
      {
        "name": "id",
        "wire": "fieldId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "name": "x",
      "type": "text"
    },
    "idField": "id"
  },
  {
    "entity": "contacts_field_option",
    "accessor": "ContactsFieldOption",
    "op": "list",
    "method": "GET",
    "path": "/contacts/fields/{fieldId}/options",
    "args": [
      {
        "name": "field_id",
        "wire": "fieldId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "size": 1,
      "collection": [
        {
          "birthday_date": "2017-07-21",
          "city": "Example City",
          "contact_expire_after": 1,
          "contacts_count": 1,
          "country": "Example Country",
          "created_by": "example_username",
          "date_created": "2017-07-21T17:32:28Z",
          "date_updated": "2017-07-21T17:32:28Z",
          "description": "Resource description",
          "email": "john.doe@example.com",
          "first_name": "John",
          "gender": "undefined",
          "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "groups": [
            {
              "contact_expire_after": 1,
              "contacts_count": 1,
              "created_by": "example_username",
              "date_created": "2017-07-21T17:32:28Z",
              "date_updated": "2017-07-21T17:32:28Z",
              "description": "Resource description",
              "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
              "idx": "example-user-provided-id-123",
              "name": "Example Group",
              "permissions": []
            }
          ],
          "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "idx": "example-user-provided-id-123",
          "last_name": "Doe",
          "name": "Example Group",
          "permissions": [
            {
              "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
              "read": false,
              "send": false,
              "username": "example_username",
              "write": false
            }
          ],
          "phone_number": "x",
          "read": false,
          "send": false,
          "source": "Example Source",
          "type": "text",
          "username": "example_username",
          "value": "x",
          "write": false
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "contactsgroup",
    "accessor": "Contactsgroup",
    "op": "create",
    "method": "POST",
    "path": "/contacts/groups/{groupId}/members",
    "args": [
      {
        "name": "group_id",
        "wire": "groupId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 202,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "contactsgroup",
    "accessor": "Contactsgroup",
    "op": "create",
    "method": "POST",
    "path": "/contacts/groups",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 201,
    "sample": {
      "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "name": "Example Group",
      "description": "Resource description",
      "contacts_count": 1,
      "date_created": "2017-07-21T17:32:28Z",
      "date_updated": "2017-07-21T17:32:28Z",
      "created_by": "example_username",
      "idx": "example-user-provided-id-123",
      "contact_expire_after": 1,
      "permissions": [
        {
          "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "read": false,
          "send": false,
          "username": "example_username",
          "write": false
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "contactsgroup",
    "accessor": "Contactsgroup",
    "op": "list",
    "method": "GET",
    "path": "/contacts/groups",
    "args": [],
    "select": {
      "name": "v1",
      "with": "v1"
    },
    "headers": [],
    "query": [
      "with",
      "name"
    ],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "size": 1,
      "collection": [
        {
          "birthday_date": "2017-07-21",
          "city": "Example City",
          "contact_expire_after": 1,
          "contacts_count": 1,
          "country": "Example Country",
          "created_by": "example_username",
          "date_created": "2017-07-21T17:32:28Z",
          "date_updated": "2017-07-21T17:32:28Z",
          "description": "Resource description",
          "email": "john.doe@example.com",
          "first_name": "John",
          "gender": "undefined",
          "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "groups": [
            {
              "contact_expire_after": 1,
              "contacts_count": 1,
              "created_by": "example_username",
              "date_created": "2017-07-21T17:32:28Z",
              "date_updated": "2017-07-21T17:32:28Z",
              "description": "Resource description",
              "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
              "idx": "example-user-provided-id-123",
              "name": "Example Group",
              "permissions": []
            }
          ],
          "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "idx": "example-user-provided-id-123",
          "last_name": "Doe",
          "name": "Example Group",
          "permissions": [
            {
              "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
              "read": false,
              "send": false,
              "username": "example_username",
              "write": false
            }
          ],
          "phone_number": "x",
          "read": false,
          "send": false,
          "source": "Example Source",
          "type": "text",
          "username": "example_username",
          "value": "x",
          "write": false
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "contactsgroup",
    "accessor": "Contactsgroup",
    "op": "list",
    "method": "GET",
    "path": "/contacts/groups/{groupId}/permissions",
    "args": [
      {
        "name": "group_id",
        "wire": "groupId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "size": 1,
      "collection": [
        {
          "birthday_date": "2017-07-21",
          "city": "Example City",
          "contact_expire_after": 1,
          "contacts_count": 1,
          "country": "Example Country",
          "created_by": "example_username",
          "date_created": "2017-07-21T17:32:28Z",
          "date_updated": "2017-07-21T17:32:28Z",
          "description": "Resource description",
          "email": "john.doe@example.com",
          "first_name": "John",
          "gender": "undefined",
          "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "groups": [
            {
              "contact_expire_after": 1,
              "contacts_count": 1,
              "created_by": "example_username",
              "date_created": "2017-07-21T17:32:28Z",
              "date_updated": "2017-07-21T17:32:28Z",
              "description": "Resource description",
              "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
              "idx": "example-user-provided-id-123",
              "name": "Example Group",
              "permissions": []
            }
          ],
          "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "idx": "example-user-provided-id-123",
          "last_name": "Doe",
          "name": "Example Group",
          "permissions": [
            {
              "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
              "read": false,
              "send": false,
              "username": "example_username",
              "write": false
            }
          ],
          "phone_number": "x",
          "read": false,
          "send": false,
          "source": "Example Source",
          "type": "text",
          "username": "example_username",
          "value": "x",
          "write": false
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "contactsgroup",
    "accessor": "Contactsgroup",
    "op": "remove",
    "method": "DELETE",
    "path": "/contacts/groups/{groupId}/members/{contactId}",
    "args": [
      {
        "name": "contact_id",
        "wire": "contactId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      },
      {
        "name": "group_id",
        "wire": "groupId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 204,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "contactsgroup",
    "accessor": "Contactsgroup",
    "op": "remove",
    "method": "DELETE",
    "path": "/contacts/groups/{groupId}/permissions/{username}",
    "args": [
      {
        "name": "group_id",
        "wire": "groupId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      },
      {
        "name": "username",
        "wire": "username",
        "value": "p2"
      }
    ],
    "select": {
      "username": "example_username"
    },
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 204,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "contactsgroup",
    "accessor": "Contactsgroup",
    "op": "remove",
    "method": "DELETE",
    "path": "/contacts/groups",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 204,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "contactsgroup",
    "accessor": "Contactsgroup",
    "op": "update",
    "method": "PUT",
    "path": "/contacts/groups/{groupId}/permissions/{username}",
    "args": [
      {
        "name": "group_id",
        "wire": "groupId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      },
      {
        "name": "username",
        "wire": "username",
        "value": "p2"
      }
    ],
    "select": {
      "username": "example_username"
    },
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "username": "example_username",
      "write": false,
      "read": false,
      "send": false
    },
    "idField": "id"
  },
  {
    "entity": "contactsgroup",
    "accessor": "Contactsgroup",
    "op": "update",
    "method": "PUT",
    "path": "/contacts/groups/{groupId}/members",
    "args": [
      {
        "name": "group_id",
        "wire": "groupId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 202,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "contactstrash",
    "accessor": "Contactstrash",
    "op": "remove",
    "method": "DELETE",
    "path": "/contacts/trash",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 202,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "contactstrash",
    "accessor": "Contactstrash",
    "op": "update",
    "method": "PUT",
    "path": "/contacts/trash/restore",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 202,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "field_available",
    "accessor": "FieldAvailable",
    "op": "list",
    "method": "GET",
    "path": "/contacts/fields/available",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": [
      {
        "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
        "name": "x",
        "type": "text",
        "built_in": true,
        "options": [
          "x"
        ]
      }
    ],
    "idField": "id"
  },
  {
    "entity": "group",
    "accessor": "Group",
    "op": "load",
    "method": "GET",
    "path": "/contacts/groups/{groupId}",
    "args": [
      {
        "name": "id",
        "wire": "groupId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "name": "Example Group",
      "description": "Resource description",
      "contacts_count": 1,
      "date_created": "2017-07-21T17:32:28Z",
      "date_updated": "2017-07-21T17:32:28Z",
      "created_by": "example_username",
      "idx": "example-user-provided-id-123",
      "contact_expire_after": 1,
      "permissions": [
        {
          "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "read": false,
          "send": false,
          "username": "example_username",
          "write": false
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "group",
    "accessor": "Group",
    "op": "update",
    "method": "PUT",
    "path": "/contacts/groups/{groupId}",
    "args": [
      {
        "name": "id",
        "wire": "groupId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "name": "Example Group",
      "description": "Resource description",
      "contacts_count": 1,
      "date_created": "2017-07-21T17:32:28Z",
      "date_updated": "2017-07-21T17:32:28Z",
      "created_by": "example_username",
      "idx": "example-user-provided-id-123",
      "contact_expire_after": 1,
      "permissions": [
        {
          "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "read": false,
          "send": false,
          "username": "example_username",
          "write": false
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "mfa_code",
    "accessor": "MfaCode",
    "op": "create",
    "method": "POST",
    "path": "/mfa/codes",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 201,
    "sample": {
      "id": "x",
      "code": "x",
      "phone_number": "48327201200",
      "from": {}
    },
    "idField": "id"
  },
  {
    "entity": "mfa_code",
    "accessor": "MfaCode",
    "op": "create",
    "method": "POST",
    "path": "/mfa/codes/verifications",
    "action": "verification",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 204,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "opt_out",
    "accessor": "OptOut",
    "op": "list",
    "method": "GET",
    "path": "/opt_outs",
    "args": [],
    "select": {
      "limit": "v1",
      "offset": "v1",
      "phone_number": "v1"
    },
    "headers": [
      {
        "name": "accept",
        "wire": "Accept",
        "value": "application/json"
      },
      {
        "name": "x_async",
        "wire": "x-async",
        "value": "h2"
      }
    ],
    "query": [
      "phone_number",
      "offset",
      "limit"
    ],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "size": 1,
      "collection": [
        {
          "_links": [
            {
              "href": "https://smsapi.pl",
              "method": "GET",
              "name": "x"
            }
          ],
          "date": "2026-01-01T00:00:00Z",
          "id": "x",
          "phoneNumber": 1
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "opt_out",
    "accessor": "OptOut",
    "op": "remove",
    "method": "DELETE",
    "path": "/opt_outs/{optOutId}",
    "args": [
      {
        "name": "id",
        "wire": "optOutId",
        "value": "p1"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 204,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "opt_out_setting",
    "accessor": "OptOutSetting",
    "op": "load",
    "method": "GET",
    "path": "/opt_outs/settings",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "brand": "x"
    },
    "idField": "id"
  },
  {
    "entity": "opt_out_setting",
    "accessor": "OptOutSetting",
    "op": "update",
    "method": "PUT",
    "path": "/opt_outs/settings",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "brand": "x"
    },
    "idField": "id"
  },
  {
    "entity": "permission",
    "accessor": "Permission",
    "op": "create",
    "method": "POST",
    "path": "/contacts/groups/{groupId}/permissions",
    "args": [
      {
        "name": "group_id",
        "wire": "groupId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 201,
    "sample": {
      "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "username": "example_username",
      "write": false,
      "read": false,
      "send": false
    },
    "idField": "id"
  },
  {
    "entity": "permission",
    "accessor": "Permission",
    "op": "load",
    "method": "GET",
    "path": "/contacts/groups/{groupId}/permissions/{username}",
    "args": [
      {
        "name": "group_id",
        "wire": "groupId",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      },
      {
        "name": "id",
        "wire": "username",
        "value": "p2"
      }
    ],
    "select": {
      "username": "example_username"
    },
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "group_id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "username": "example_username",
      "write": false,
      "read": false,
      "send": false
    },
    "idField": "id"
  },
  {
    "entity": "ping",
    "accessor": "Ping",
    "op": "list",
    "method": "GET",
    "path": "/ping",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "authorized": true,
      "unavailable": [
        "x"
      ]
    },
    "idField": "id"
  },
  {
    "entity": "profile",
    "accessor": "Profile",
    "op": "list",
    "method": "GET",
    "path": "/profile/prices",
    "action": "price",
    "args": [],
    "select": {
      "type": "eco"
    },
    "headers": [],
    "query": [
      "type"
    ],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "collection": [
        {
          "_embedded": {
            "services": {
              "alphanumeric_sendernames": true,
              "details": "x",
              "receiving_numbers": true
            }
          },
          "changed_at": "2026-01-01",
          "country": {
            "mcc": 1,
            "name": "x"
          },
          "network": {
            "mnc": 1,
            "name": "x"
          },
          "price": {
            "amount": 1,
            "currency": "x"
          }
        }
      ],
      "size": 1
    },
    "idField": "id"
  },
  {
    "entity": "profile",
    "accessor": "Profile",
    "op": "load",
    "method": "GET",
    "path": "/profile",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "name": "x",
      "email": "x",
      "username": "x",
      "phone_number": "48327201200",
      "payment_type": "prepaid",
      "user_type": "native",
      "points": 1
    },
    "idField": "id"
  },
  {
    "entity": "rcs",
    "accessor": "Rcs",
    "op": "list",
    "method": "GET",
    "path": "/rcs/messages",
    "action": "message",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "size": 1,
      "collection": [
        {
          "deliveredAt": "2026-01-01T00:00:00Z",
          "expiredAt": "2026-01-01T00:00:00Z",
          "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "interface": "x",
          "messageType": "x",
          "readAt": "2026-01-01T00:00:00Z",
          "recipient": "48500100100",
          "sender": "x",
          "senderId": "x",
          "sentAt": "2026-01-01T00:00:00Z"
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "sendername",
    "accessor": "Sendername",
    "op": "create",
    "method": "POST",
    "path": "/sms/sendernames",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 201,
    "sample": {
      "created_at": "2026-01-01T00:00:00Z",
      "is_default": true,
      "sender": "x",
      "status": "ACTIVE"
    },
    "idField": "id"
  },
  {
    "entity": "sendername",
    "accessor": "Sendername",
    "op": "list",
    "method": "GET",
    "path": "/sms/sendernames",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "size": 1,
      "collection": [
        {
          "created_at": "2026-01-01T00:00:00Z",
          "is_default": true,
          "sender": "x",
          "status": "ACTIVE"
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "sendername",
    "accessor": "Sendername",
    "op": "load",
    "method": "GET",
    "path": "/sms/sendernames/{sender}",
    "args": [
      {
        "name": "id",
        "wire": "sender",
        "value": "p1"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "created_at": "2026-01-01T00:00:00Z",
      "is_default": true,
      "sender": "x",
      "status": "ACTIVE"
    },
    "idField": "id"
  },
  {
    "entity": "sendername_statement",
    "accessor": "SendernameStatement",
    "op": "list",
    "method": "GET",
    "path": "/sms/sendernames/statement",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "content": "x",
      "sections": [
        {
          "content": "x",
          "statements": [
            {
              "content": "x",
              "type": "sendername_usage_rights"
            }
          ],
          "title": "x"
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "sent_rcs_message",
    "accessor": "SentRcsMessage",
    "op": "create",
    "method": "POST",
    "path": "/rcs/messages",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 201,
    "sample": {
      "id": {}
    },
    "idField": "id"
  },
  {
    "entity": "shipment_country_volume",
    "accessor": "ShipmentCountryVolume",
    "op": "list",
    "method": "GET",
    "path": "/shipment/country_volumes",
    "args": [],
    "select": {
      "month": "v1",
      "year": "v1"
    },
    "headers": [
      {
        "name": "accept",
        "wire": "Accept",
        "value": "application/json"
      }
    ],
    "query": [
      "year",
      "month"
    ],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "size": 1,
      "collection": [
        {
          "country_code": "PL",
          "country_limit": 1,
          "country_name": "x",
          "usage": 1
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "short_url",
    "accessor": "ShortUrl",
    "op": "create",
    "method": "POST",
    "path": "/short_url/links",
    "action": "link",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 201,
    "sample": {
      "id": "123",
      "name": "x",
      "url": "https://smsapi.pl",
      "short_url": "https://smsapi.pl",
      "filename": "x",
      "type": "x",
      "expire": "2017-07-21T17:32:28Z",
      "hits": 1,
      "hits_unique": 1,
      "description": "x"
    },
    "idField": "id"
  },
  {
    "entity": "short_url",
    "accessor": "ShortUrl",
    "op": "list",
    "method": "GET",
    "path": "/short_url/links",
    "action": "link",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "size": 1,
      "collection": [
        {
          "description": "x",
          "expire": "2017-07-21T17:32:28Z",
          "filename": "x",
          "hits": 1,
          "hits_unique": 1,
          "id": "123",
          "name": "x",
          "short_url": "https://smsapi.pl",
          "type": "x",
          "url": "https://smsapi.pl"
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "short_url",
    "accessor": "ShortUrl",
    "op": "load",
    "method": "GET",
    "path": "/short_url/links/{id}",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "123"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "id": "123",
      "name": "x",
      "url": "https://smsapi.pl",
      "short_url": "https://smsapi.pl",
      "filename": "x",
      "type": "x",
      "expire": "2017-07-21T17:32:28Z",
      "hits": 1,
      "hits_unique": 1,
      "description": "x"
    },
    "idField": "id"
  },
  {
    "entity": "short_url",
    "accessor": "ShortUrl",
    "op": "remove",
    "method": "DELETE",
    "path": "/short_url/links/{id}",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "123"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 204,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "short_url",
    "accessor": "ShortUrl",
    "op": "update",
    "method": "PUT",
    "path": "/short_url/links/{id}",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "123"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "id": "123",
      "name": "x",
      "url": "https://smsapi.pl",
      "short_url": "https://smsapi.pl",
      "filename": "x",
      "type": "x",
      "expire": "2017-07-21T17:32:28Z",
      "hits": 1,
      "hits_unique": 1,
      "description": "x"
    },
    "idField": "id"
  },
  {
    "entity": "smsdo",
    "accessor": "Smsdo",
    "op": "create",
    "method": "POST",
    "path": "/sms.do",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "count": 1,
      "length": 7,
      "message": "Example Message",
      "parts": 1,
      "list": [
        {
          "id": "7074294081650020450",
          "points": 0.165,
          "number": "48327201200",
          "date_sent": 1712570310,
          "submitted_number": "48327201200",
          "status": "QUEUE",
          "error": "x",
          "idx": "example-user-provided-id-123",
          "parts": 1
        }
      ],
      "fallbacks": {
        "vms": {
          "count": 1,
          "list": [
            {
              "id": "0862688734829233910",
              "idx": "example-user-provided-id-123",
              "date_sent": 1712570310,
              "points": 0.165
            }
          ]
        }
      }
    },
    "idField": "id"
  },
  {
    "entity": "smssendername",
    "accessor": "Smssendername",
    "op": "create",
    "method": "POST",
    "path": "/sms/sendernames/{sender}/commands/make_default",
    "args": [
      {
        "name": "sendername_id",
        "wire": "sender",
        "value": "p1"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 204,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "smssendername",
    "accessor": "Smssendername",
    "op": "remove",
    "method": "DELETE",
    "path": "/sms/sendernames/{sender}",
    "args": [
      {
        "name": "sender",
        "wire": "sender",
        "value": "p1"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 204,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "smstemplate",
    "accessor": "Smstemplate",
    "op": "remove",
    "method": "DELETE",
    "path": "/sms/templates/{id}",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "p1"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 204,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "subuser",
    "accessor": "Subuser",
    "op": "create",
    "method": "POST",
    "path": "/subusers",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 201,
    "sample": {
      "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "username": "example_username",
      "active": true,
      "description": {},
      "points": {
        "from_account": 1,
        "per_month": 1
      }
    },
    "idField": "id"
  },
  {
    "entity": "subuser",
    "accessor": "Subuser",
    "op": "list",
    "method": "GET",
    "path": "/subusers/{id}/shares/sendernames",
    "action": "share_sendername",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "access": "all",
      "senders": [
        "x"
      ]
    },
    "idField": "id"
  },
  {
    "entity": "subuser",
    "accessor": "Subuser",
    "op": "list",
    "method": "GET",
    "path": "/subusers/{id}/shares/templates",
    "action": "share_template",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "access": "all",
      "templates": [
        "x"
      ]
    },
    "idField": "id"
  },
  {
    "entity": "subuser",
    "accessor": "Subuser",
    "op": "list",
    "method": "GET",
    "path": "/subusers",
    "args": [],
    "select": {
      "q": "v1"
    },
    "headers": [],
    "query": [
      "q"
    ],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "size": 1,
      "collection": [
        {
          "active": true,
          "description": {},
          "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "points": {
            "from_account": 1,
            "per_month": 1
          },
          "username": "example_username"
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "subuser",
    "accessor": "Subuser",
    "op": "load",
    "method": "GET",
    "path": "/subusers/{id}",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "username": "example_username",
      "active": true,
      "description": {},
      "points": {
        "from_account": 1,
        "per_month": 1
      }
    },
    "idField": "id"
  },
  {
    "entity": "subuser",
    "accessor": "Subuser",
    "op": "remove",
    "method": "DELETE",
    "path": "/subusers/{id}",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 204,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "subuser",
    "accessor": "Subuser",
    "op": "update",
    "method": "PUT",
    "path": "/subusers/{id}",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
      "username": "example_username",
      "active": true,
      "description": {},
      "points": {
        "from_account": 1,
        "per_month": 1
      }
    },
    "idField": "id"
  },
  {
    "entity": "subuser",
    "accessor": "Subuser",
    "op": "update",
    "method": "PUT",
    "path": "/subusers/{id}/shares/sendernames",
    "action": "share_sendername",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 204,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "subuser",
    "accessor": "Subuser",
    "op": "update",
    "method": "PUT",
    "path": "/subusers/{id}/shares/templates",
    "action": "share_template",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "0f0f0f0f0f0f0f0f0f0f0f0f"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 204,
    "sample": null,
    "idField": "id"
  },
  {
    "entity": "template",
    "accessor": "Template",
    "op": "create",
    "method": "POST",
    "path": "/sms/templates",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 201,
    "sample": {
      "id": "x",
      "name": "x",
      "template": "x",
      "normalize": true
    },
    "idField": "id"
  },
  {
    "entity": "template",
    "accessor": "Template",
    "op": "list",
    "method": "GET",
    "path": "/sms/templates",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "size": 1,
      "collection": [
        {
          "id": "x",
          "name": "x",
          "normalize": true,
          "template": "x"
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "template",
    "accessor": "Template",
    "op": "load",
    "method": "GET",
    "path": "/sms/templates/{id}",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "p1"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "id": "x",
      "name": "x",
      "template": "x",
      "normalize": true
    },
    "idField": "id"
  },
  {
    "entity": "template",
    "accessor": "Template",
    "op": "update",
    "method": "PUT",
    "path": "/sms/templates/{id}",
    "args": [
      {
        "name": "id",
        "wire": "id",
        "value": "p1"
      }
    ],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "id": "x",
      "name": "x",
      "template": "x",
      "normalize": true
    },
    "idField": "id"
  },
  {
    "entity": "user_rcs_sender_collection",
    "accessor": "UserRcsSenderCollection",
    "op": "list",
    "method": "GET",
    "path": "/rcs/senders",
    "args": [],
    "select": {},
    "headers": [],
    "query": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "bearer"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "size": 1,
      "collection": [
        {
          "deliveredAt": "2026-01-01T00:00:00Z",
          "expiredAt": "2026-01-01T00:00:00Z",
          "id": "0f0f0f0f0f0f0f0f0f0f0f0f",
          "interface": "x",
          "messageType": "x",
          "readAt": "2026-01-01T00:00:00Z",
          "recipient": "48500100100",
          "sender": "x",
          "senderId": "x",
          "sentAt": "2026-01-01T00:00:00Z"
        }
      ]
    },
    "idField": "id"
  }
]


describe('definition', () => {
  for (const point of PLAN) {
    test(point.entity + '.' + point.op + ' ' + point.method + ' ' + point.path, async (t) => {
      const control = isControlSkipped('entityOp', point.entity + '.' + point.op, 'definition')
      if (control.skip) {
        t.skip(control.reason || 'skipped via sdk-test-control.json')
        return
      }
      await runDefinitionPoint(SDK, point)
    })
  }
})
