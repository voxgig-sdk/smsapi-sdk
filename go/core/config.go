package core

import (
	"sync"
)

// MakeConfig builds a fresh, fully materialised config map. Every call
// rebuilds the whole structure, so prefer SharedConfig unless you need a
// private copy you intend to mutate.
func MakeConfig() map[string]any {
	return map[string]any{
		"main": map[string]any{
			"name": "Smsapi",
			"slug": "smsapi",
			"version": "0.0.1",
			"target": "go",
		},
		"feature": map[string]any{
			"audit": map[string]any{
				"options": map[string]any{
					"active": false,
					"actor": "anonymous",
					"max": 1000,
				},
				"optspec": map[string]any{
					"now": "`$FUNCTION`",
					"sink": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "none",
			},
			"cache": map[string]any{
				"options": map[string]any{
					"active": false,
					"max": 256,
					"methods": []any{
						"GET",
					},
					"ttl": 5000,
				},
				"optspec": map[string]any{
					"now": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "wrap",
			},
			"clienttrack": map[string]any{
				"options": map[string]any{
					"active": false,
					"clientVersion": "0.0.1",
				},
				"optspec": map[string]any{
					"clientName": "`$STRING`",
					"clientVersion": "`$STRING`",
					"headers": "`$MAP`",
					"idgen": "`$FUNCTION`",
					"sessionId": "`$STRING`",
				},
				"strict": false,
				"transport": "none",
			},
			"cost": map[string]any{
				"options": map[string]any{
					"active": false,
					"budget": 0,
					"currency": "USD",
					"header": "",
					"onBudget": "warn",
					"path": "",
					"perUnit": 0,
					"rates": map[string]any{},
					"unit": 0,
				},
				"optspec": map[string]any{
					"actor": "`$STRING`",
					"sink": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "wrap",
			},
			"debug": map[string]any{
				"options": map[string]any{
					"active": false,
					"max": 100,
					"redact": []any{
						"authorization",
						"cookie",
						"set-cookie",
						"api-key",
						"apikey",
						"x-api-key",
						"idempotency-key",
					},
				},
				"optspec": map[string]any{
					"now": "`$FUNCTION`",
					"onEntry": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "none",
			},
			"idempotency": map[string]any{
				"options": map[string]any{
					"active": false,
					"header": "Idempotency-Key",
					"methods": []any{
						"POST",
						"PUT",
						"PATCH",
						"DELETE",
					},
					"ops": []any{
						"create",
						"update",
						"remove",
					},
				},
				"optspec": map[string]any{
					"keygen": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "none",
			},
			"log": map[string]any{
				"options": map[string]any{
					"active": true,
				},
				"optspec": map[string]any{
					"level": "`$STRING`",
					"logger": "`$ANY`",
				},
				"strict": false,
				"transport": "none",
			},
			"metrics": map[string]any{
				"options": map[string]any{
					"active": false,
				},
				"optspec": map[string]any{
					"now": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "none",
			},
			"netsim": map[string]any{
				"options": map[string]any{
					"active": false,
					"errorTimes": 0,
					"failEvery": 0,
					"failRate": 0,
					"failStatus": 503,
					"failTimes": 0,
					"latency": 0,
					"offline": false,
					"rateLimitTimes": 0,
					"retryAfter": 0,
					"seed": 1,
				},
				"optspec": map[string]any{
					"latency": []any{
						"`$ONE`",
						"`$NUMBER`",
						"`$MAP`",
					},
					"sleep": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "wrap",
			},
			"paging": map[string]any{
				"options": map[string]any{
					"active": false,
					"afterVar": "after",
					"cursorParam": "cursor",
					"firstVar": "first",
					"limitParam": "limit",
					"pageParam": "page",
					"startPage": 1,
				},
				"optspec": map[string]any{
					"limit": "`$NUMBER`",
					"ops": "`$LIST`",
				},
				"strict": false,
				"transport": "none",
			},
			"proxy": map[string]any{
				"options": map[string]any{
					"active": false,
					"fromEnv": false,
					"noProxy": []any{},
					"url": "",
				},
				"optspec": map[string]any{
					"agent": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "wrap",
			},
			"ratelimit": map[string]any{
				"options": map[string]any{
					"active": false,
					"burst": 5,
					"rate": 5,
				},
				"optspec": map[string]any{
					"now": "`$FUNCTION`",
					"sleep": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "wrap",
			},
			"rbac": map[string]any{
				"options": map[string]any{
					"active": false,
					"deny": false,
					"permissions": []any{},
					"rules": map[string]any{},
				},
				"optspec": map[string]any{},
				"strict": false,
				"transport": "none",
			},
			"retry": map[string]any{
				"options": map[string]any{
					"active": false,
					"factor": 2,
					"maxDelay": 2000,
					"minDelay": 50,
					"retries": 2,
					"statuses": []any{
						408,
						425,
						429,
						500,
						502,
						503,
						504,
					},
				},
				"optspec": map[string]any{
					"jitter": "`$BOOLEAN`",
					"sleep": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "wrap",
			},
			"secrets": map[string]any{
				"options": map[string]any{
					"active": false,
					"cache": true,
					"exchange": map[string]any{
						"active": false,
						"method": "POST",
						"path": "auth/token",
						"refresh": "",
						"request": "refresh_token",
						"response": "access_token",
						"retries": 1,
						"statuses": []any{
							401,
						},
					},
					"name": "apikey",
					"providers": []any{},
				},
				"optspec": map[string]any{},
				"strict": false,
				"transport": "wrap",
			},
			"streaming": map[string]any{
				"options": map[string]any{
					"active": false,
					"chunkDelay": 0,
					"chunkSize": 0,
				},
				"optspec": map[string]any{
					"ops": "`$LIST`",
					"sleep": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "none",
			},
			"telemetry": map[string]any{
				"options": map[string]any{
					"active": false,
				},
				"optspec": map[string]any{
					"exporter": "`$FUNCTION`",
					"headers": "`$MAP`",
					"idgen": "`$FUNCTION`",
					"now": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "none",
			},
			"test": map[string]any{
				"options": map[string]any{
					"active": false,
				},
				"optspec": map[string]any{
					"entity": "`$MAP`",
					"net": "`$MAP`",
				},
				"strict": false,
				"transport": "base",
			},
			"timeout": map[string]any{
				"options": map[string]any{
					"active": false,
					"ms": 30000,
				},
				"optspec": map[string]any{
					"clearTimer": "`$FUNCTION`",
					"now": "`$FUNCTION`",
					"setTimer": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "wrap",
			},
			"validate": map[string]any{
				"options": map[string]any{
					"active": false,
					"mode": "throw",
					"request": true,
					"response": false,
					"strict": false,
				},
				"optspec": map[string]any{
					"mode": []any{
						"`$ONE`",
						[]any{
							"`$EXACT`",
							"throw",
						},
						[]any{
							"`$EXACT`",
							"report",
						},
					},
					"onInvalid": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "none",
			},
		},
		"options": map[string]any{
			"base": "https://api.smsapi.com",
			"auth": map[string]any{
				"prefix": "Bearer",
			},
			"headers": map[string]any{
				"content-type": "application/json",
			},
			"entity": map[string]any{
				"available": map[string]any{},
				"blacklist": map[string]any{},
				"callback": map[string]any{},
				"contact": map[string]any{},
				"contacts_field": map[string]any{},
				"contacts_field_option": map[string]any{},
				"contactsgroup": map[string]any{},
				"contactstrash": map[string]any{},
				"field_available": map[string]any{},
				"group": map[string]any{},
				"mfa_code": map[string]any{},
				"opt_out": map[string]any{},
				"opt_out_setting": map[string]any{},
				"permission": map[string]any{},
				"ping": map[string]any{},
				"profile": map[string]any{},
				"rcs": map[string]any{},
				"sendername": map[string]any{},
				"sendername_statement": map[string]any{},
				"sent_rcs_message": map[string]any{},
				"shipment_country_volume": map[string]any{},
				"short_url": map[string]any{},
				"smsdo": map[string]any{},
				"smssendername": map[string]any{},
				"smstemplate": map[string]any{},
				"subuser": map[string]any{},
				"template": map[string]any{},
				"user_rcs_sender_collection": map[string]any{},
			},
		},
		"entity": map[string]any{
			"available": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "name",
						"title": "Name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "normalize",
						"title": "Normalize",
						"type": "`$BOOLEAN`",
					},
					map[string]any{
						"name": "template",
						"title": "Template",
						"type": "`$STRING`",
					},
				},
				"name": "available",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/sms/templates/available",
								"segments": []any{
									map[string]any{
										"lit": "sms",
									},
									map[string]any{
										"lit": "templates",
									},
									map[string]any{
										"lit": "available",
									},
								},
								"parts": []any{
									"sms",
									"templates",
									"available",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.collection`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"blacklist": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "id",
						"title": "Id",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "blacklist",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/blacklist/phone_numbers",
								"segments": []any{
									map[string]any{
										"lit": "blacklist",
									},
									map[string]any{
										"lit": "phone_numbers",
									},
								},
								"parts": []any{
									"blacklist",
									"phone_numbers",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{
									"$action": "phone_number",
								},
								"body": map[string]any{
									"alternatives": []any{
										map[string]any{
											"fields": []any{
												map[string]any{
													"name": "expire_at",
												},
												map[string]any{
													"name": "phone_number",
												},
											},
											"kind": "form",
											"media": "application/x-www-form-urlencoded",
										},
									},
									"kind": "json",
									"media": "application/json",
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/blacklist/phone_numbers/imports",
								"segments": []any{
									map[string]any{
										"lit": "blacklist",
									},
									map[string]any{
										"lit": "phone_numbers",
									},
									map[string]any{
										"lit": "imports",
									},
								},
								"parts": []any{
									"blacklist",
									"phone_numbers",
									"imports",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"body": map[string]any{
									"alternatives": []any{
										map[string]any{
											"kind": "raw",
											"media": "text/csv",
										},
									},
									"fields": []any{
										map[string]any{
											"name": "import",
										},
									},
									"kind": "multipart",
									"media": "multipart/form-data",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/blacklist/phone_numbers",
								"segments": []any{
									map[string]any{
										"lit": "blacklist",
									},
									map[string]any{
										"lit": "phone_numbers",
									},
								},
								"parts": []any{
									"blacklist",
									"phone_numbers",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"header": []any{
										map[string]any{
											"name": "accept",
											"orig": "Accept",
											"type": "`$STRING`",
											"kind": "header",
											"example": "application/json",
										},
										map[string]any{
											"name": "x_async",
											"orig": "x-async",
											"type": "`$BOOLEAN`",
											"kind": "header",
											"example": false,
										},
									},
									"query": []any{
										map[string]any{
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 5,
										},
										map[string]any{
											"name": "offset",
											"orig": "offset",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 0,
										},
										map[string]any{
											"name": "q",
											"orig": "q",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 0,
										},
									},
								},
								"select": map[string]any{
									"$action": "phone_number",
								},
								"response": map[string]any{
									"alternatives": []any{
										map[string]any{
											"kind": "raw",
											"media": "text/csv",
										},
									},
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/blacklist/phone_numbers/{id}",
								"segments": []any{
									map[string]any{
										"lit": "blacklist",
									},
									map[string]any{
										"lit": "phone_numbers",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"blacklist",
									"phone_numbers",
									"{id}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
							},
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/blacklist/phone_numbers",
								"segments": []any{
									map[string]any{
										"lit": "blacklist",
									},
									map[string]any{
										"lit": "phone_numbers",
									},
								},
								"parts": []any{
									"blacklist",
									"phone_numbers",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "phone_number",
											"orig": "phone_number",
											"type": "`$STRING`",
											"kind": "query",
										},
									},
								},
								"select": map[string]any{
									"$action": "phone_number",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"callback": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "active",
						"title": "Active",
						"type": "`$BOOLEAN`",
					},
					map[string]any{
						"name": "api_version",
						"title": "Api Version",
						"type": "`$INTEGER`",
						"short": "Version of the callback output format.",
					},
					map[string]any{
						"name": "id",
						"title": "Id",
						"type": "`$STRING`",
						"short": "Object ID",
						"format": "oid",
					},
					map[string]any{
						"name": "invalid",
						"title": "Invalid",
						"type": "`$BOOLEAN`",
					},
					map[string]any{
						"name": "receiver",
						"title": "Receiver",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "receiver_type",
						"title": "Receiver Type",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "type",
						"title": "Type",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "url",
						"title": "Url",
						"type": "`$STRING`",
						"op": map[string]any{
							"update": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
						},
						"short": "WHATWG URL compliant",
						"format": "url",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "callback",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/callbacks",
								"segments": []any{
									map[string]any{
										"lit": "callbacks",
									},
								},
								"parts": []any{
									"callbacks",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/callbacks",
								"segments": []any{
									map[string]any{
										"lit": "callbacks",
									},
								},
								"parts": []any{
									"callbacks",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.collection`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/callbacks/{id}",
								"segments": []any{
									map[string]any{
										"lit": "callbacks",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"callbacks",
									"{id}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/callbacks/{id}/commands/test",
								"segments": []any{
									map[string]any{
										"lit": "callbacks",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "commands",
									},
									map[string]any{
										"lit": "test",
									},
								},
								"parts": []any{
									"callbacks",
									"{id}",
									"commands",
									"test",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"$action": "command_test",
									"exist": []any{
										"id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/callbacks/{id}",
								"segments": []any{
									map[string]any{
										"lit": "callbacks",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"callbacks",
									"{id}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
							},
						},
					},
					"update": map[string]any{
						"input": "data",
						"name": "update",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "PUT",
								"orig": "/callbacks/{id}",
								"segments": []any{
									map[string]any{
										"lit": "callbacks",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"callbacks",
									"{id}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "PUT",
								"orig": "/callbacks/{id}/commands/activate",
								"segments": []any{
									map[string]any{
										"lit": "callbacks",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "commands",
									},
									map[string]any{
										"lit": "activate",
									},
								},
								"parts": []any{
									"callbacks",
									"{id}",
									"commands",
									"activate",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"$action": "command_activate",
									"exist": []any{
										"id",
									},
								},
							},
							map[string]any{
								"kind": "http",
								"method": "PUT",
								"orig": "/callbacks/{id}/commands/deactivate",
								"segments": []any{
									map[string]any{
										"lit": "callbacks",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "commands",
									},
									map[string]any{
										"lit": "deactivate",
									},
								},
								"parts": []any{
									"callbacks",
									"{id}",
									"commands",
									"deactivate",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"$action": "command_deactivate",
									"exist": []any{
										"id",
									},
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"contact": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "birthday_date",
						"title": "Birthday Date",
						"type": "`$STRING`",
						"format": "date",
					},
					map[string]any{
						"name": "city",
						"title": "City",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "collection",
						"title": "Collection",
						"type": "`$ARRAY`",
						"req": true,
					},
					map[string]any{
						"name": "contact_expire_after",
						"title": "Contact Expire After",
						"type": "`$INTEGER`",
						"req": true,
						"short": "Contact expire after days",
					},
					map[string]any{
						"name": "contacts_count",
						"title": "Contacts Count",
						"type": "`$INTEGER`",
						"req": true,
					},
					map[string]any{
						"name": "country",
						"title": "Country",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "created_by",
						"title": "Created By",
						"type": "`$STRING`",
						"req": true,
					},
					map[string]any{
						"name": "date_created",
						"title": "Date Created",
						"type": "`$STRING`",
						"req": true,
						"format": "date-time",
					},
					map[string]any{
						"name": "date_updated",
						"title": "Date Updated",
						"type": "`$STRING`",
						"req": true,
						"format": "date-time",
					},
					map[string]any{
						"name": "description",
						"title": "Description",
						"type": "`$STRING`",
						"op": map[string]any{
							"load": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
						},
					},
					map[string]any{
						"name": "email",
						"title": "Email",
						"type": "`$STRING`",
						"format": "email",
					},
					map[string]any{
						"name": "first_name",
						"title": "First Name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "gender",
						"title": "Gender",
						"type": "`$STRING`",
						"req": true,
					},
					map[string]any{
						"name": "groups",
						"title": "Groups",
						"type": "`$ARRAY`",
						"req": true,
					},
					map[string]any{
						"name": "id",
						"title": "Id",
						"type": "`$STRING`",
						"req": true,
						"short": "Object ID",
						"format": "oid",
					},
					map[string]any{
						"name": "idx",
						"title": "Idx",
						"type": "`$STRING`",
						"short": "User provided resource id",
					},
					map[string]any{
						"name": "last_name",
						"title": "Last Name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "name",
						"title": "Name",
						"type": "`$STRING`",
						"req": true,
						"short": "Group name",
					},
					map[string]any{
						"name": "permissions",
						"title": "Permissions",
						"type": "`$ARRAY`",
					},
					map[string]any{
						"name": "phone_number",
						"title": "Phone Number",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "size",
						"title": "Size",
						"type": "`$INTEGER`",
						"req": true,
					},
					map[string]any{
						"name": "source",
						"title": "Source",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "contact",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/contacts/{contactId}/groups",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "groups",
									},
								},
								"parts": []any{
									"contacts",
									"{id}",
									"groups",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"contactId": "id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "contactId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"$action": "group",
									"exist": []any{
										"id",
									},
								},
								"body": map[string]any{
									"kind": "form",
									"media": "application/x-www-form-urlencoded",
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/contacts",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
								},
								"parts": []any{
									"contacts",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"body": map[string]any{
									"fields": []any{
										map[string]any{
											"name": "birthday_date",
										},
										map[string]any{
											"name": "browser",
										},
										map[string]any{
											"name": "city",
										},
										map[string]any{
											"name": "country",
										},
										map[string]any{
											"name": "description",
										},
										map[string]any{
											"name": "device",
										},
										map[string]any{
											"name": "email",
										},
										map[string]any{
											"name": "first_name",
										},
										map[string]any{
											"name": "gender",
										},
										map[string]any{
											"name": "idx",
										},
										map[string]any{
											"name": "last_name",
										},
										map[string]any{
											"name": "operating_system",
										},
										map[string]any{
											"name": "phone_number",
										},
										map[string]any{
											"name": "source",
										},
										map[string]any{
											"name": "undelivered_messages",
										},
									},
									"kind": "form",
									"media": "application/x-www-form-urlencoded",
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/contacts/{contactId}/groups",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "groups",
									},
								},
								"parts": []any{
									"contacts",
									"{id}",
									"groups",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"contactId": "id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.collection`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "contactId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"$action": "group",
									"exist": []any{
										"id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/contacts",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
								},
								"parts": []any{
									"contacts",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.collection`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "birthday_date",
											"orig": "birthday_date",
											"type": "`$ARRAY`",
											"kind": "query",
											"example": "2022-06-24",
											"field": true,
										},
										map[string]any{
											"name": "email",
											"orig": "email",
											"type": "`$ARRAY`",
											"kind": "query",
											"field": true,
										},
										map[string]any{
											"name": "first_name",
											"orig": "first_name",
											"type": "`$ARRAY`",
											"kind": "query",
											"field": true,
										},
										map[string]any{
											"name": "gender",
											"orig": "gender",
											"type": "`$STRING`",
											"kind": "query",
											"field": true,
										},
										map[string]any{
											"name": "group_id",
											"orig": "group_id",
											"type": "`$ARRAY`",
											"kind": "query",
										},
										map[string]any{
											"name": "last_name",
											"orig": "last_name",
											"type": "`$ARRAY`",
											"kind": "query",
											"field": true,
										},
										map[string]any{
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 5,
										},
										map[string]any{
											"name": "offset",
											"orig": "offset",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 0,
										},
										map[string]any{
											"name": "order_by",
											"orig": "order_by",
											"type": "`$STRING`",
											"kind": "query",
										},
										map[string]any{
											"name": "phone_number",
											"orig": "phone_number",
											"type": "`$ARRAY`",
											"kind": "query",
											"field": true,
										},
										map[string]any{
											"name": "q",
											"orig": "q",
											"type": "`$STRING`",
											"kind": "query",
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/contacts/groups/{groupId}/members/{contactId}",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "groups",
									},
									map[string]any{
										"var": "group_id",
									},
									map[string]any{
										"lit": "members",
									},
									map[string]any{
										"var": "contact_id",
									},
								},
								"parts": []any{
									"contacts",
									"groups",
									"{group_id}",
									"members",
									"{contact_id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"contactId": "contact_id",
										"groupId": "group_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "contact_id",
											"orig": "contactId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
										map[string]any{
											"name": "group_id",
											"orig": "groupId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"contact_id",
										"group_id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/contacts/{contactId}/groups/{groupId}",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "groups",
									},
									map[string]any{
										"var": "group_id",
									},
								},
								"parts": []any{
									"contacts",
									"{id}",
									"groups",
									"{group_id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"contactId": "id",
										"groupId": "group_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "group_id",
											"orig": "groupId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
										map[string]any{
											"name": "id",
											"orig": "contactId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"group_id",
										"id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/contacts/{contactId}",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"contacts",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"contactId": "id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "contactId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/contacts/{contactId}/groups/{groupId}",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "groups",
									},
									map[string]any{
										"var": "group_id",
									},
								},
								"parts": []any{
									"contacts",
									"{id}",
									"groups",
									"{group_id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"contactId": "id",
										"groupId": "group_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "group_id",
											"orig": "groupId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
										map[string]any{
											"name": "id",
											"orig": "contactId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"group_id",
										"id",
									},
								},
							},
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/contacts/{contactId}",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"contacts",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"contactId": "id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "contactId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
							},
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/contacts",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
								},
								"parts": []any{
									"contacts",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
							},
						},
					},
					"update": map[string]any{
						"input": "data",
						"name": "update",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "PUT",
								"orig": "/contacts/groups/{groupId}/members/{contactId}",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "groups",
									},
									map[string]any{
										"var": "group_id",
									},
									map[string]any{
										"lit": "members",
									},
									map[string]any{
										"var": "contact_id",
									},
								},
								"parts": []any{
									"contacts",
									"groups",
									"{group_id}",
									"members",
									"{contact_id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"contactId": "contact_id",
										"groupId": "group_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "contact_id",
											"orig": "contactId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
										map[string]any{
											"name": "group_id",
											"orig": "groupId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"contact_id",
										"group_id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "PUT",
								"orig": "/contacts/{contactId}/groups/{groupId}",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "groups",
									},
									map[string]any{
										"var": "group_id",
									},
								},
								"parts": []any{
									"contacts",
									"{id}",
									"groups",
									"{group_id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"contactId": "id",
										"groupId": "group_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "group_id",
											"orig": "groupId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
										map[string]any{
											"name": "id",
											"orig": "contactId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"group_id",
										"id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "PUT",
								"orig": "/contacts/{contactId}",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"contacts",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"contactId": "id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "contactId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"body": map[string]any{
									"fields": []any{
										map[string]any{
											"name": "birthday_date",
										},
										map[string]any{
											"name": "city",
										},
										map[string]any{
											"name": "description",
										},
										map[string]any{
											"name": "email",
										},
										map[string]any{
											"name": "first_name",
										},
										map[string]any{
											"name": "gender",
										},
										map[string]any{
											"name": "last_name",
										},
										map[string]any{
											"name": "phone_number",
										},
										map[string]any{
											"name": "source",
										},
									},
									"kind": "form",
									"media": "application/x-www-form-urlencoded",
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"$.main.kit.entity.group",
						},
						[]any{
							"$.main.kit.entity.group",
						},
					},
				},
			},
			"contacts_field": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "id",
						"title": "Id",
						"type": "`$STRING`",
						"short": "Object ID",
						"format": "oid",
					},
					map[string]any{
						"name": "name",
						"title": "Name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "type",
						"title": "Type",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "contacts_field",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/contacts/fields",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "fields",
									},
								},
								"parts": []any{
									"contacts",
									"fields",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"body": map[string]any{
									"fields": []any{
										map[string]any{
											"name": "name",
										},
										map[string]any{
											"name": "type",
										},
									},
									"kind": "form",
									"media": "application/x-www-form-urlencoded",
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/contacts/fields",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "fields",
									},
								},
								"parts": []any{
									"contacts",
									"fields",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.collection`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/contacts/fields/{fieldId}",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "fields",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"contacts",
									"fields",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"fieldId": "id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "fieldId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
							},
						},
					},
					"update": map[string]any{
						"input": "data",
						"name": "update",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "PUT",
								"orig": "/contacts/fields/{fieldId}",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "fields",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"contacts",
									"fields",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"fieldId": "id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "fieldId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"body": map[string]any{
									"fields": []any{
										map[string]any{
											"name": "name",
										},
									},
									"kind": "form",
									"media": "application/x-www-form-urlencoded",
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"contacts_field_option": map[string]any{
				"fields": []any{},
				"name": "contacts_field_option",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/contacts/fields/{fieldId}/options",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "fields",
									},
									map[string]any{
										"var": "field_id",
									},
									map[string]any{
										"lit": "options",
									},
								},
								"parts": []any{
									"contacts",
									"fields",
									"{field_id}",
									"options",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"fieldId": "field_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.collection`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "field_id",
											"orig": "fieldId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"field_id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"contactsgroup": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "group_id",
						"title": "Group Id",
						"type": "`$STRING`",
						"req": true,
						"short": "Object ID",
						"format": "oid",
					},
					map[string]any{
						"name": "read",
						"title": "Read",
						"type": "`$BOOLEAN`",
						"req": true,
						"short": "Has read permission",
					},
					map[string]any{
						"name": "send",
						"title": "Send",
						"type": "`$BOOLEAN`",
						"req": true,
						"short": "Has send permission",
					},
					map[string]any{
						"name": "username",
						"title": "Username",
						"type": "`$STRING`",
						"req": true,
					},
					map[string]any{
						"name": "write",
						"title": "Write",
						"type": "`$BOOLEAN`",
						"req": true,
						"short": "Has write permission",
					},
				},
				"name": "contactsgroup",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/contacts/groups/{groupId}/members",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "groups",
									},
									map[string]any{
										"var": "group_id",
									},
									map[string]any{
										"lit": "members",
									},
								},
								"parts": []any{
									"contacts",
									"groups",
									"{group_id}",
									"members",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"groupId": "group_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "group_id",
											"orig": "groupId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"group_id",
									},
								},
								"body": map[string]any{
									"fields": []any{
										map[string]any{
											"list": true,
											"name": "birthday_date",
										},
										map[string]any{
											"list": true,
											"name": "email",
										},
										map[string]any{
											"list": true,
											"name": "first_name",
										},
										map[string]any{
											"name": "gender",
										},
										map[string]any{
											"list": true,
											"name": "group_id",
										},
										map[string]any{
											"list": true,
											"name": "last_name",
										},
										map[string]any{
											"list": true,
											"name": "phone_number",
										},
										map[string]any{
											"name": "q",
										},
									},
									"kind": "form",
									"media": "application/x-www-form-urlencoded",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/contacts/groups",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "groups",
									},
								},
								"parts": []any{
									"contacts",
									"groups",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"body": map[string]any{
									"fields": []any{
										map[string]any{
											"name": "contact_expire_after",
										},
										map[string]any{
											"name": "description",
										},
										map[string]any{
											"name": "idx",
										},
										map[string]any{
											"name": "name",
										},
									},
									"kind": "form",
									"media": "application/x-www-form-urlencoded",
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/contacts/groups/{groupId}/permissions",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "groups",
									},
									map[string]any{
										"var": "group_id",
									},
									map[string]any{
										"lit": "permissions",
									},
								},
								"parts": []any{
									"contacts",
									"groups",
									"{group_id}",
									"permissions",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"groupId": "group_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.collection`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "group_id",
											"orig": "groupId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"group_id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/contacts/groups",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "groups",
									},
								},
								"parts": []any{
									"contacts",
									"groups",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.collection`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "name",
											"orig": "name",
											"type": "`$OBJECT`",
											"kind": "query",
											"example": "{\"name\" : \"group name\"}",
										},
										map[string]any{
											"name": "with",
											"orig": "with",
											"type": "`$ARRAY`",
											"kind": "query",
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/contacts/groups/{groupId}/members/{contactId}",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "groups",
									},
									map[string]any{
										"var": "group_id",
									},
									map[string]any{
										"lit": "members",
									},
									map[string]any{
										"var": "contact_id",
									},
								},
								"parts": []any{
									"contacts",
									"groups",
									"{group_id}",
									"members",
									"{contact_id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"contactId": "contact_id",
										"groupId": "group_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "contact_id",
											"orig": "contactId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
										map[string]any{
											"name": "group_id",
											"orig": "groupId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"contact_id",
										"group_id",
									},
								},
							},
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/contacts/groups/{groupId}/permissions/{username}",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "groups",
									},
									map[string]any{
										"var": "group_id",
									},
									map[string]any{
										"lit": "permissions",
									},
									map[string]any{
										"var": "username",
									},
								},
								"parts": []any{
									"contacts",
									"groups",
									"{group_id}",
									"permissions",
									"{username}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"groupId": "group_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "group_id",
											"orig": "groupId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
										map[string]any{
											"name": "username",
											"orig": "username",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "example_username",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"group_id",
										"username",
									},
								},
							},
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/contacts/groups/{groupId}",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "groups",
									},
									map[string]any{
										"var": "group_id",
									},
								},
								"parts": []any{
									"contacts",
									"groups",
									"{group_id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"groupId": "group_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "group_id",
											"orig": "groupId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"group_id",
									},
								},
								"body": map[string]any{
									"fields": []any{
										map[string]any{
											"name": "delete_contacts",
										},
									},
									"kind": "form",
									"media": "application/x-www-form-urlencoded",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/contacts/groups/{groupId}/members",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "groups",
									},
									map[string]any{
										"var": "group_id",
									},
									map[string]any{
										"lit": "members",
									},
								},
								"parts": []any{
									"contacts",
									"groups",
									"{group_id}",
									"members",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"groupId": "group_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "group_id",
											"orig": "groupId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"group_id",
									},
								},
								"body": map[string]any{
									"fields": []any{
										map[string]any{
											"list": true,
											"name": "birthday_date",
										},
										map[string]any{
											"list": true,
											"name": "email",
										},
										map[string]any{
											"list": true,
											"name": "first_name",
										},
										map[string]any{
											"name": "gender",
										},
										map[string]any{
											"list": true,
											"name": "group_id",
										},
										map[string]any{
											"list": true,
											"name": "last_name",
										},
										map[string]any{
											"list": true,
											"name": "phone_number",
										},
										map[string]any{
											"name": "q",
										},
									},
									"kind": "form",
									"media": "application/x-www-form-urlencoded",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/contacts/groups",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "groups",
									},
								},
								"parts": []any{
									"contacts",
									"groups",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
							},
						},
					},
					"update": map[string]any{
						"input": "data",
						"name": "update",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "PUT",
								"orig": "/contacts/groups/{groupId}/permissions/{username}",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "groups",
									},
									map[string]any{
										"var": "group_id",
									},
									map[string]any{
										"lit": "permissions",
									},
									map[string]any{
										"var": "username",
									},
								},
								"parts": []any{
									"contacts",
									"groups",
									"{group_id}",
									"permissions",
									"{username}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"groupId": "group_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "group_id",
											"orig": "groupId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
										map[string]any{
											"name": "username",
											"orig": "username",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "example_username",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"group_id",
										"username",
									},
								},
								"body": map[string]any{
									"fields": []any{
										map[string]any{
											"name": "read",
										},
										map[string]any{
											"name": "send",
										},
										map[string]any{
											"name": "write",
										},
									},
									"kind": "form",
									"media": "application/x-www-form-urlencoded",
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "PUT",
								"orig": "/contacts/groups/{groupId}/members",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "groups",
									},
									map[string]any{
										"var": "group_id",
									},
									map[string]any{
										"lit": "members",
									},
								},
								"parts": []any{
									"contacts",
									"groups",
									"{group_id}",
									"members",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"groupId": "group_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "group_id",
											"orig": "groupId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"group_id",
									},
								},
								"body": map[string]any{
									"fields": []any{
										map[string]any{
											"list": true,
											"name": "birthday_date",
										},
										map[string]any{
											"list": true,
											"name": "email",
										},
										map[string]any{
											"list": true,
											"name": "first_name",
										},
										map[string]any{
											"name": "gender",
										},
										map[string]any{
											"list": true,
											"name": "group_id",
										},
										map[string]any{
											"list": true,
											"name": "last_name",
										},
										map[string]any{
											"list": true,
											"name": "phone_number",
										},
										map[string]any{
											"name": "q",
										},
									},
									"kind": "form",
									"media": "application/x-www-form-urlencoded",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"$.main.kit.entity.group",
						},
						[]any{
							"$.main.kit.entity.group",
						},
						[]any{
							"$.main.kit.entity.group",
							"$.main.kit.entity.permission",
						},
					},
				},
			},
			"contactstrash": map[string]any{
				"fields": []any{},
				"name": "contactstrash",
				"op": map[string]any{
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/contacts/trash",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "trash",
									},
								},
								"parts": []any{
									"contacts",
									"trash",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
							},
						},
					},
					"update": map[string]any{
						"input": "data",
						"name": "update",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "PUT",
								"orig": "/contacts/trash/restore",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "trash",
									},
									map[string]any{
										"lit": "restore",
									},
								},
								"parts": []any{
									"contacts",
									"trash",
									"restore",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"field_available": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "built_in",
						"title": "Built In",
						"type": "`$BOOLEAN`",
					},
					map[string]any{
						"name": "id",
						"title": "Id",
						"type": "`$STRING`",
						"short": "Object ID",
						"format": "oid",
					},
					map[string]any{
						"name": "name",
						"title": "Name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "options",
						"title": "Options",
						"type": "`$ARRAY`",
					},
					map[string]any{
						"name": "type",
						"title": "Type",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "field_available",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/contacts/fields/available",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "fields",
									},
									map[string]any{
										"lit": "available",
									},
								},
								"parts": []any{
									"contacts",
									"fields",
									"available",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"group": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "contact_expire_after",
						"title": "Contact Expire After",
						"type": "`$INTEGER`",
						"req": true,
						"short": "Contact expire after days",
					},
					map[string]any{
						"name": "contacts_count",
						"title": "Contacts Count",
						"type": "`$INTEGER`",
						"req": true,
					},
					map[string]any{
						"name": "created_by",
						"title": "Created By",
						"type": "`$STRING`",
						"req": true,
					},
					map[string]any{
						"name": "date_created",
						"title": "Date Created",
						"type": "`$STRING`",
						"req": true,
						"format": "date-time",
					},
					map[string]any{
						"name": "date_updated",
						"title": "Date Updated",
						"type": "`$STRING`",
						"req": true,
						"format": "date-time",
					},
					map[string]any{
						"name": "description",
						"title": "Description",
						"type": "`$STRING`",
						"req": true,
					},
					map[string]any{
						"name": "id",
						"title": "Id",
						"type": "`$STRING`",
						"req": true,
						"short": "Object ID",
						"format": "oid",
					},
					map[string]any{
						"name": "idx",
						"title": "Idx",
						"type": "`$STRING`",
						"short": "User provided resource id",
					},
					map[string]any{
						"name": "name",
						"title": "Name",
						"type": "`$STRING`",
						"req": true,
						"short": "Group name",
					},
					map[string]any{
						"name": "permissions",
						"title": "Permissions",
						"type": "`$ARRAY`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "group",
				"op": map[string]any{
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/contacts/groups/{groupId}",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "groups",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"contacts",
									"groups",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"groupId": "id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "groupId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"update": map[string]any{
						"input": "data",
						"name": "update",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "PUT",
								"orig": "/contacts/groups/{groupId}",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "groups",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"contacts",
									"groups",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"groupId": "id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "groupId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"body": map[string]any{
									"fields": []any{
										map[string]any{
											"name": "contact_expire_after",
										},
										map[string]any{
											"name": "description",
										},
										map[string]any{
											"name": "idx",
										},
										map[string]any{
											"name": "name",
										},
									},
									"kind": "form",
									"media": "application/x-www-form-urlencoded",
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"mfa_code": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "content",
						"title": "Content",
						"type": "`$STRING`",
						"short": "Custom content that must contain placeholder [%code%]",
					},
					map[string]any{
						"name": "fast",
						"title": "Fast",
						"type": "`$ANY`",
					},
					map[string]any{
						"name": "from",
						"title": "From",
						"type": "`$STRING`",
						"short": "Sendername",
					},
					map[string]any{
						"name": "phone_number",
						"title": "Phone Number",
						"type": "`$STRING`",
						"req": true,
					},
				},
				"name": "mfa_code",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/mfa/codes",
								"segments": []any{
									map[string]any{
										"lit": "mfa",
									},
									map[string]any{
										"lit": "codes",
									},
								},
								"parts": []any{
									"mfa",
									"codes",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/mfa/codes/verifications",
								"segments": []any{
									map[string]any{
										"lit": "mfa",
									},
									map[string]any{
										"lit": "codes",
									},
									map[string]any{
										"lit": "verifications",
									},
								},
								"parts": []any{
									"mfa",
									"codes",
									"verifications",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{
									"$action": "verification",
								},
								"body": map[string]any{
									"fields": []any{
										map[string]any{
											"name": "code",
										},
										map[string]any{
											"name": "phone_number",
										},
									},
									"kind": "form",
									"media": "application/x-www-form-urlencoded",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"opt_out": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "date",
						"title": "Date",
						"type": "`$STRING`",
						"format": "date-time",
					},
					map[string]any{
						"name": "id",
						"title": "Id",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "links",
						"title": "Links",
						"type": "`$ARRAY`",
					},
					map[string]any{
						"name": "phoneNumber",
						"title": "Phone Number",
						"type": "`$INTEGER`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "opt_out",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/opt_outs",
								"segments": []any{
									map[string]any{
										"lit": "opt_outs",
									},
								},
								"parts": []any{
									"opt_outs",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.collection`",
								},
								"args": map[string]any{
									"header": []any{
										map[string]any{
											"name": "accept",
											"orig": "Accept",
											"type": "`$STRING`",
											"kind": "header",
											"example": "application/json",
										},
										map[string]any{
											"name": "x_async",
											"orig": "x-async",
											"type": "`$BOOLEAN`",
											"kind": "header",
											"example": false,
										},
									},
									"query": []any{
										map[string]any{
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 5,
										},
										map[string]any{
											"name": "offset",
											"orig": "offset",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 0,
										},
										map[string]any{
											"name": "phone_number",
											"orig": "phone_number",
											"type": "`$STRING`",
											"kind": "query",
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"alternatives": []any{
										map[string]any{
											"kind": "raw",
											"media": "text/csv",
										},
									},
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/opt_outs/{optOutId}",
								"segments": []any{
									map[string]any{
										"lit": "opt_outs",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"opt_outs",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"optOutId": "id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "optOutId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"opt_out_setting": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "brand",
						"title": "Brand",
						"type": "`$STRING`",
					},
				},
				"name": "opt_out_setting",
				"op": map[string]any{
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/opt_outs/settings",
								"segments": []any{
									map[string]any{
										"lit": "opt_outs",
									},
									map[string]any{
										"lit": "settings",
									},
								},
								"parts": []any{
									"opt_outs",
									"settings",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"update": map[string]any{
						"input": "data",
						"name": "update",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "PUT",
								"orig": "/opt_outs/settings",
								"segments": []any{
									map[string]any{
										"lit": "opt_outs",
									},
									map[string]any{
										"lit": "settings",
									},
								},
								"parts": []any{
									"opt_outs",
									"settings",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"permission": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "group_id",
						"title": "Group Id",
						"type": "`$STRING`",
						"req": true,
						"short": "Object ID",
						"format": "oid",
					},
					map[string]any{
						"name": "id",
						"title": "Id",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "read",
						"title": "Read",
						"type": "`$BOOLEAN`",
						"req": true,
						"short": "Has read permission",
					},
					map[string]any{
						"name": "send",
						"title": "Send",
						"type": "`$BOOLEAN`",
						"req": true,
						"short": "Has send permission",
					},
					map[string]any{
						"name": "username",
						"title": "Username",
						"type": "`$STRING`",
						"req": true,
					},
					map[string]any{
						"name": "write",
						"title": "Write",
						"type": "`$BOOLEAN`",
						"req": true,
						"short": "Has write permission",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "permission",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/contacts/groups/{groupId}/permissions",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "groups",
									},
									map[string]any{
										"var": "group_id",
									},
									map[string]any{
										"lit": "permissions",
									},
								},
								"parts": []any{
									"contacts",
									"groups",
									"{group_id}",
									"permissions",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"groupId": "group_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "group_id",
											"orig": "groupId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"group_id",
									},
								},
								"body": map[string]any{
									"fields": []any{
										map[string]any{
											"name": "read",
										},
										map[string]any{
											"name": "send",
										},
										map[string]any{
											"name": "username",
										},
										map[string]any{
											"name": "write",
										},
									},
									"kind": "form",
									"media": "application/x-www-form-urlencoded",
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/contacts/groups/{groupId}/permissions/{username}",
								"segments": []any{
									map[string]any{
										"lit": "contacts",
									},
									map[string]any{
										"lit": "groups",
									},
									map[string]any{
										"var": "group_id",
									},
									map[string]any{
										"lit": "permissions",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"contacts",
									"groups",
									"{group_id}",
									"permissions",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"groupId": "group_id",
										"username": "id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "group_id",
											"orig": "groupId",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
										map[string]any{
											"name": "id",
											"orig": "username",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "example_username",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"group_id",
										"id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"$.main.kit.entity.group",
						},
					},
				},
			},
			"ping": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "authorized",
						"title": "Authorized",
						"type": "`$BOOLEAN`",
						"req": true,
					},
					map[string]any{
						"name": "unavailable",
						"title": "Unavailable",
						"type": "`$ARRAY`",
						"req": true,
					},
				},
				"name": "ping",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/ping",
								"segments": []any{
									map[string]any{
										"lit": "ping",
									},
								},
								"parts": []any{
									"ping",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.unavailable`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"profile": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "email",
						"title": "Email",
						"type": "`$STRING`",
						"req": true,
					},
					map[string]any{
						"name": "name",
						"title": "Name",
						"type": "`$STRING`",
						"req": true,
					},
					map[string]any{
						"name": "payment_type",
						"title": "Payment Type",
						"type": "`$STRING`",
						"req": true,
					},
					map[string]any{
						"name": "phone_number",
						"title": "Phone Number",
						"type": "`$INTEGER`",
						"req": true,
					},
					map[string]any{
						"name": "points",
						"title": "Points",
						"type": "`$NUMBER`",
						"format": "float",
					},
					map[string]any{
						"name": "user_type",
						"title": "User Type",
						"type": "`$STRING`",
						"req": true,
					},
					map[string]any{
						"name": "username",
						"title": "Username",
						"type": "`$STRING`",
						"req": true,
					},
				},
				"name": "profile",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/profile/prices",
								"segments": []any{
									map[string]any{
										"lit": "profile",
									},
									map[string]any{
										"lit": "prices",
									},
								},
								"parts": []any{
									"profile",
									"prices",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.collection`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "type",
											"orig": "type",
											"type": "`$STRING`",
											"kind": "query",
											"example": "eco",
										},
									},
								},
								"select": map[string]any{
									"$action": "price",
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/profile",
								"segments": []any{
									map[string]any{
										"lit": "profile",
									},
								},
								"parts": []any{
									"profile",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"rcs": map[string]any{
				"fields": []any{},
				"name": "rcs",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/rcs/messages",
								"segments": []any{
									map[string]any{
										"lit": "rcs",
									},
									map[string]any{
										"lit": "messages",
									},
								},
								"parts": []any{
									"rcs",
									"messages",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.collection`",
								},
								"args": map[string]any{},
								"select": map[string]any{
									"$action": "message",
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"sendername": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "created_at",
						"title": "Created At",
						"type": "`$STRING`",
						"format": "date-time",
					},
					map[string]any{
						"name": "id",
						"title": "Id",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "is_default",
						"title": "Is Default",
						"type": "`$BOOLEAN`",
					},
					map[string]any{
						"name": "sender",
						"title": "Sender",
						"type": "`$STRING`",
						"short": "Sendername",
					},
					map[string]any{
						"name": "status",
						"title": "Status",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "sendername",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/sms/sendernames",
								"segments": []any{
									map[string]any{
										"lit": "sms",
									},
									map[string]any{
										"lit": "sendernames",
									},
								},
								"parts": []any{
									"sms",
									"sendernames",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"body": map[string]any{
									"fields": []any{
										map[string]any{
											"name": "sender",
										},
									},
									"kind": "form",
									"media": "application/x-www-form-urlencoded",
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/sms/sendernames",
								"segments": []any{
									map[string]any{
										"lit": "sms",
									},
									map[string]any{
										"lit": "sendernames",
									},
								},
								"parts": []any{
									"sms",
									"sendernames",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.collection`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/sms/sendernames/{sender}",
								"segments": []any{
									map[string]any{
										"lit": "sms",
									},
									map[string]any{
										"lit": "sendernames",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"sms",
									"sendernames",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"sender": "id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "sender",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"sendername_statement": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "content",
						"title": "Content",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "statements",
						"title": "Statements",
						"type": "`$ARRAY`",
					},
					map[string]any{
						"name": "title",
						"title": "Title",
						"type": "`$STRING`",
					},
				},
				"name": "sendername_statement",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/sms/sendernames/statement",
								"segments": []any{
									map[string]any{
										"lit": "sms",
									},
									map[string]any{
										"lit": "sendernames",
									},
									map[string]any{
										"lit": "statement",
									},
								},
								"parts": []any{
									"sms",
									"sendernames",
									"statement",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.sections`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"sent_rcs_message": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "content",
						"title": "Content",
						"type": "`$OBJECT`",
						"short": "RCS message content in RCS JSON format.",
					},
					map[string]any{
						"name": "phone_number",
						"title": "Phone Number",
						"type": "`$STRING`",
						"req": true,
						"short": "Recipient phone number (e.g.",
					},
					map[string]any{
						"name": "sender",
						"title": "Sender",
						"type": "`$STRING`",
						"req": true,
						"short": "RCS sender ID (object ID of the agent/sender the user has access to).",
						"format": "oid",
					},
					map[string]any{
						"name": "text",
						"title": "Text",
						"type": "`$STRING`",
						"short": "Plain text message content.",
					},
				},
				"name": "sent_rcs_message",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/rcs/messages",
								"segments": []any{
									map[string]any{
										"lit": "rcs",
									},
									map[string]any{
										"lit": "messages",
									},
								},
								"parts": []any{
									"rcs",
									"messages",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"body": map[string]any{
									"alternatives": []any{
										map[string]any{
											"fields": []any{
												map[string]any{
													"name": "content",
												},
												map[string]any{
													"name": "phone_number",
												},
												map[string]any{
													"name": "sender",
												},
												map[string]any{
													"name": "text",
												},
											},
											"kind": "form",
											"media": "application/x-www-form-urlencoded",
										},
									},
									"kind": "json",
									"media": "application/json",
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"shipment_country_volume": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "country_code",
						"title": "Country Code",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "country_limit",
						"title": "Country Limit",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "country_name",
						"title": "Country Name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "usage",
						"title": "Usage",
						"type": "`$INTEGER`",
					},
				},
				"name": "shipment_country_volume",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/shipment/country_volumes",
								"segments": []any{
									map[string]any{
										"lit": "shipment",
									},
									map[string]any{
										"lit": "country_volumes",
									},
								},
								"parts": []any{
									"shipment",
									"country_volumes",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.collection`",
								},
								"args": map[string]any{
									"header": []any{
										map[string]any{
											"name": "accept",
											"orig": "Accept",
											"type": "`$STRING`",
											"kind": "header",
											"example": "application/json",
										},
									},
									"query": []any{
										map[string]any{
											"name": "month",
											"orig": "month",
											"type": "`$STRING`",
											"kind": "query",
										},
										map[string]any{
											"name": "year",
											"orig": "year",
											"type": "`$STRING`",
											"kind": "query",
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"alternatives": []any{
										map[string]any{
											"kind": "raw",
											"media": "text/csv",
										},
									},
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"short_url": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "description",
						"title": "Description",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "expire",
						"title": "Expire",
						"type": "`$STRING`",
						"format": "date-time",
					},
					map[string]any{
						"name": "filename",
						"title": "Filename",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "hits",
						"title": "Hits",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "hits_unique",
						"title": "Hits Unique",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "id",
						"title": "Id",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "name",
						"title": "Name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "short_url",
						"title": "Short Url",
						"type": "`$STRING`",
						"short": "WHATWG URL compliant",
						"format": "url",
					},
					map[string]any{
						"name": "type",
						"title": "Type",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "url",
						"title": "Url",
						"type": "`$STRING`",
						"short": "WHATWG URL compliant",
						"format": "url",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "short_url",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/short_url/links",
								"segments": []any{
									map[string]any{
										"lit": "short_url",
									},
									map[string]any{
										"lit": "links",
									},
								},
								"parts": []any{
									"short_url",
									"links",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{
									"$action": "link",
								},
								"body": map[string]any{
									"alternatives": []any{
										map[string]any{
											"kind": "form",
											"media": "application/x-www-form-urlencoded",
										},
									},
									"kind": "json",
									"media": "application/json",
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/short_url/links",
								"segments": []any{
									map[string]any{
										"lit": "short_url",
									},
									map[string]any{
										"lit": "links",
									},
								},
								"parts": []any{
									"short_url",
									"links",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.collection`",
								},
								"args": map[string]any{},
								"select": map[string]any{
									"$action": "link",
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/short_url/links/{id}",
								"segments": []any{
									map[string]any{
										"lit": "short_url",
									},
									map[string]any{
										"lit": "links",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"short_url",
									"links",
									"{id}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "123",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/short_url/links/{id}",
								"segments": []any{
									map[string]any{
										"lit": "short_url",
									},
									map[string]any{
										"lit": "links",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"short_url",
									"links",
									"{id}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "123",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
							},
						},
					},
					"update": map[string]any{
						"input": "data",
						"name": "update",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "PUT",
								"orig": "/short_url/links/{id}",
								"segments": []any{
									map[string]any{
										"lit": "short_url",
									},
									map[string]any{
										"lit": "links",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"short_url",
									"links",
									"{id}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "123",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"body": map[string]any{
									"fields": []any{
										map[string]any{
											"name": "description",
										},
										map[string]any{
											"name": "name",
										},
										map[string]any{
											"name": "url",
										},
									},
									"kind": "form",
									"media": "application/x-www-form-urlencoded",
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"smsdo": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "allow_duplicates",
						"title": "Allow Duplicates",
						"type": "`$INTEGER`",
						"short": "When parameter allow_duplicates is set to \"1\" allows to send message to duplicated numbers in one request (useful i.e.",
					},
					map[string]any{
						"name": "check_idx",
						"title": "Check Idx",
						"type": "`$ANY`",
						"short": "When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h.",
					},
					map[string]any{
						"name": "date",
						"title": "Date",
						"type": "`$ANY`",
						"short": "Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110).",
					},
					map[string]any{
						"name": "date_validate",
						"title": "Date Validate",
						"type": "`$INTEGER`",
						"short": "When parameter date_validate is set to \"1\" checks if date if given in proper format.",
					},
					map[string]any{
						"name": "details",
						"title": "Details",
						"type": "`$ANY`",
						"short": "When details parameter is set to \"1\" more details in response will be displayed (message length and sms count).",
					},
					map[string]any{
						"name": "encoding",
						"title": "Encoding",
						"type": "`$STRING`",
						"short": "This parameter describes the encoding of the message text.",
					},
					map[string]any{
						"name": "expiration_date",
						"title": "Expiration Date",
						"type": "`$ANY`",
						"short": "Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet.",
					},
					map[string]any{
						"name": "fallback",
						"title": "Fallback",
						"type": "`$ARRAY`",
						"short": "Enable fallback in case sms sending fails",
					},
					map[string]any{
						"name": "fast",
						"title": "Fast",
						"type": "`$INTEGER`",
						"short": "Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery.",
					},
					map[string]any{
						"name": "flash",
						"title": "Flash",
						"type": "`$INTEGER`",
						"short": "Sending a message in flash mode can be activated by setting this parameter to \"1\".",
					},
					map[string]any{
						"name": "format",
						"title": "Format",
						"type": "`$STRING`",
						"short": "Parameter &format=json causes, that response is sending in JSON format.",
					},
					map[string]any{
						"name": "from",
						"title": "From",
						"type": "`$STRING`",
						"short": "Name of the sender.",
					},
					map[string]any{
						"name": "group",
						"title": "Group",
						"type": "`$STRING`",
						"short": "Name of the group from the contacts database to which message should be sent to.",
					},
					map[string]any{
						"name": "idx",
						"title": "Idx",
						"type": "`$STRING`",
						"short": "Optional custom value sent with SMS and sent back in CALLBACK.",
					},
					map[string]any{
						"name": "max_parts",
						"title": "Max Parts",
						"type": "`$INTEGER`",
						"short": "Defines maximum message parts allowed, maximum value allowed is 6.",
					},
					map[string]any{
						"name": "message",
						"title": "Message",
						"type": "`$STRING`",
						"short": "The message text.",
					},
					map[string]any{
						"name": "normalize",
						"title": "Normalize",
						"type": "`$INTEGER`",
						"short": "When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...).",
					},
					map[string]any{
						"name": "notify_url",
						"title": "Notify Url",
						"type": "`$STRING`",
						"short": "Parameter allows to set CALLBACK URL for message from request.",
					},
					map[string]any{
						"name": "test",
						"title": "Test",
						"type": "`$ANY`",
						"short": "When parameter test is set to \"1\" message won't be sent but response will be displayed, there is no charge for such test messages.",
					},
					map[string]any{
						"name": "time_restriction",
						"title": "Time Restriction",
						"type": "`$STRING`",
						"short": "Sets the behavior when you try to ship in hours / dates that do not match the settings in your account.",
					},
					map[string]any{
						"name": "to",
						"title": "To",
						"type": "`$STRING`",
						"short": "Recipients' mobile phone numbers (i.e.",
					},
				},
				"name": "smsdo",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/sms.do",
								"segments": []any{
									map[string]any{
										"lit": "sms.do",
									},
								},
								"parts": []any{
									"sms.do",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"body": map[string]any{
									"alternatives": []any{
										map[string]any{
											"fields": []any{
												map[string]any{
													"name": "allow_duplicates",
												},
												map[string]any{
													"name": "check_idx",
												},
												map[string]any{
													"name": "date",
												},
												map[string]any{
													"name": "date_validate",
												},
												map[string]any{
													"name": "details",
												},
												map[string]any{
													"name": "encoding",
												},
												map[string]any{
													"name": "expiration_date",
												},
												map[string]any{
													"list": true,
													"name": "fallback",
												},
												map[string]any{
													"name": "fast",
												},
												map[string]any{
													"name": "flash",
												},
												map[string]any{
													"name": "format",
												},
												map[string]any{
													"name": "from",
												},
												map[string]any{
													"name": "group",
												},
												map[string]any{
													"name": "idx",
												},
												map[string]any{
													"name": "max_parts",
												},
												map[string]any{
													"name": "message",
												},
												map[string]any{
													"name": "normalize",
												},
												map[string]any{
													"name": "notify_url",
												},
												map[string]any{
													"name": "test",
												},
												map[string]any{
													"name": "time_restriction",
												},
												map[string]any{
													"name": "to",
												},
											},
											"kind": "form",
											"media": "application/x-www-form-urlencoded",
										},
									},
									"kind": "json",
									"media": "application/json",
								},
								"response": map[string]any{
									"alternatives": []any{
										map[string]any{
											"kind": "raw",
											"media": "text/plain",
										},
									},
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"smssendername": map[string]any{
				"fields": []any{},
				"name": "smssendername",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/sms/sendernames/{sender}/commands/make_default",
								"segments": []any{
									map[string]any{
										"lit": "sms",
									},
									map[string]any{
										"lit": "sendernames",
									},
									map[string]any{
										"var": "sender",
									},
									map[string]any{
										"lit": "commands",
									},
									map[string]any{
										"lit": "make_default",
									},
								},
								"parts": []any{
									"sms",
									"sendernames",
									"{sender}",
									"commands",
									"make_default",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "sender",
											"orig": "sender",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"sender",
									},
								},
							},
						},
					},
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/sms/sendernames/{sender}",
								"segments": []any{
									map[string]any{
										"lit": "sms",
									},
									map[string]any{
										"lit": "sendernames",
									},
									map[string]any{
										"var": "sender",
									},
								},
								"parts": []any{
									"sms",
									"sendernames",
									"{sender}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "sender",
											"orig": "sender",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"sender",
									},
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"$.main.kit.entity.sendername",
						},
					},
				},
			},
			"smstemplate": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "id",
						"title": "Id",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "smstemplate",
				"op": map[string]any{
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/sms/templates/{id}",
								"segments": []any{
									map[string]any{
										"lit": "sms",
									},
									map[string]any{
										"lit": "templates",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"sms",
									"templates",
									"{id}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"subuser": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "active",
						"title": "Active",
						"type": "`$BOOLEAN`",
					},
					map[string]any{
						"name": "credentials",
						"title": "Credentials",
						"type": "`$OBJECT`",
						"req": true,
						"op": map[string]any{
							"update": map[string]any{
								"type": "`$OBJECT`",
							},
						},
					},
					map[string]any{
						"name": "description",
						"title": "Description",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "id",
						"title": "Id",
						"type": "`$STRING`",
						"short": "Object ID",
						"format": "oid",
					},
					map[string]any{
						"name": "points",
						"title": "Points",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "username",
						"title": "Username",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "subuser",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/subusers",
								"segments": []any{
									map[string]any{
										"lit": "subusers",
									},
								},
								"parts": []any{
									"subusers",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/subusers/{id}/shares/sendernames",
								"segments": []any{
									map[string]any{
										"lit": "subusers",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "shares",
									},
									map[string]any{
										"lit": "sendernames",
									},
								},
								"parts": []any{
									"subusers",
									"{id}",
									"shares",
									"sendernames",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.senders`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"$action": "share_sendername",
									"exist": []any{
										"id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/subusers/{id}/shares/templates",
								"segments": []any{
									map[string]any{
										"lit": "subusers",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "shares",
									},
									map[string]any{
										"lit": "templates",
									},
								},
								"parts": []any{
									"subusers",
									"{id}",
									"shares",
									"templates",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.templates`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"$action": "share_template",
									"exist": []any{
										"id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/subusers",
								"segments": []any{
									map[string]any{
										"lit": "subusers",
									},
								},
								"parts": []any{
									"subusers",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.collection`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "q",
											"orig": "q",
											"type": "`$STRING`",
											"kind": "query",
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/subusers/{id}",
								"segments": []any{
									map[string]any{
										"lit": "subusers",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"subusers",
									"{id}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "DELETE",
								"orig": "/subusers/{id}",
								"segments": []any{
									map[string]any{
										"lit": "subusers",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"subusers",
									"{id}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
							},
						},
					},
					"update": map[string]any{
						"input": "data",
						"name": "update",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "PUT",
								"orig": "/subusers/{id}",
								"segments": []any{
									map[string]any{
										"lit": "subusers",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"subusers",
									"{id}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "PUT",
								"orig": "/subusers/{id}/shares/sendernames",
								"segments": []any{
									map[string]any{
										"lit": "subusers",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "shares",
									},
									map[string]any{
										"lit": "sendernames",
									},
								},
								"parts": []any{
									"subusers",
									"{id}",
									"shares",
									"sendernames",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"$action": "share_sendername",
									"exist": []any{
										"id",
									},
								},
							},
							map[string]any{
								"kind": "http",
								"method": "PUT",
								"orig": "/subusers/{id}/shares/templates",
								"segments": []any{
									map[string]any{
										"lit": "subusers",
									},
									map[string]any{
										"var": "id",
									},
									map[string]any{
										"lit": "shares",
									},
									map[string]any{
										"lit": "templates",
									},
								},
								"parts": []any{
									"subusers",
									"{id}",
									"shares",
									"templates",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "0f0f0f0f0f0f0f0f0f0f0f0f",
										},
									},
								},
								"select": map[string]any{
									"$action": "share_template",
									"exist": []any{
										"id",
									},
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"template": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "id",
						"title": "Id",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "name",
						"title": "Name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "normalize",
						"title": "Normalize",
						"type": "`$BOOLEAN`",
					},
					map[string]any{
						"name": "template",
						"title": "Template",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "template",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "POST",
								"orig": "/sms/templates",
								"segments": []any{
									map[string]any{
										"lit": "sms",
									},
									map[string]any{
										"lit": "templates",
									},
								},
								"parts": []any{
									"sms",
									"templates",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"body": map[string]any{
									"fields": []any{
										map[string]any{
											"name": "name",
										},
										map[string]any{
											"name": "normalize",
										},
										map[string]any{
											"name": "template",
										},
									},
									"kind": "form",
									"media": "application/x-www-form-urlencoded",
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/sms/templates",
								"segments": []any{
									map[string]any{
										"lit": "sms",
									},
									map[string]any{
										"lit": "templates",
									},
								},
								"parts": []any{
									"sms",
									"templates",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.collection`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/sms/templates/{id}",
								"segments": []any{
									map[string]any{
										"lit": "sms",
									},
									map[string]any{
										"lit": "templates",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"sms",
									"templates",
									"{id}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"update": map[string]any{
						"input": "data",
						"name": "update",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "PUT",
								"orig": "/sms/templates/{id}",
								"segments": []any{
									map[string]any{
										"lit": "sms",
									},
									map[string]any{
										"lit": "templates",
									},
									map[string]any{
										"var": "id",
									},
								},
								"parts": []any{
									"sms",
									"templates",
									"{id}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "id",
											"orig": "id",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"id",
									},
								},
								"body": map[string]any{
									"fields": []any{
										map[string]any{
											"name": "name",
										},
										map[string]any{
											"name": "normalize",
										},
										map[string]any{
											"name": "template",
										},
									},
									"kind": "form",
									"media": "application/x-www-form-urlencoded",
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"user_rcs_sender_collection": map[string]any{
				"fields": []any{},
				"name": "user_rcs_sender_collection",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/rcs/senders",
								"segments": []any{
									map[string]any{
										"lit": "rcs",
									},
									map[string]any{
										"lit": "senders",
									},
								},
								"parts": []any{
									"rcs",
									"senders",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.collection`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
		},
	}
}

// The plugin definitions the model selected per feature, as []any so a
// feature package can consume them without core naming its types. Empty
// when no active feature declares active plugin groups for this target.
var featurePlugins = map[string][]any{
}

// FeaturePlugins is the definitions list for one feature's chain.
func FeaturePlugins(name string) []any {
	return featurePlugins[name]
}

var (
	sharedConfigOnce sync.Once
	sharedConfigVal  map[string]any
)

// SharedConfig returns the process-wide config, built once on first use.
// The SDK reads the config on every request and never writes to it, so one
// instance is shared by every client rather than rebuilt per client.
//
// The returned map is shared: treat it as read-only. Callers that need to
// mutate should use MakeConfig, which always returns a fresh copy.
func SharedConfig() map[string]any {
	sharedConfigOnce.Do(func() {
		sharedConfigVal = MakeConfig()
	})
	return sharedConfigVal
}

func makeFeature(name string) Feature {
	switch name {
	case "audit":
		if NewAuditFeatureFunc != nil {
			return NewAuditFeatureFunc()
		}
	case "cache":
		if NewCacheFeatureFunc != nil {
			return NewCacheFeatureFunc()
		}
	case "clienttrack":
		if NewClienttrackFeatureFunc != nil {
			return NewClienttrackFeatureFunc()
		}
	case "cost":
		if NewCostFeatureFunc != nil {
			return NewCostFeatureFunc()
		}
	case "debug":
		if NewDebugFeatureFunc != nil {
			return NewDebugFeatureFunc()
		}
	case "idempotency":
		if NewIdempotencyFeatureFunc != nil {
			return NewIdempotencyFeatureFunc()
		}
	case "log":
		if NewLogFeatureFunc != nil {
			return NewLogFeatureFunc()
		}
	case "metrics":
		if NewMetricsFeatureFunc != nil {
			return NewMetricsFeatureFunc()
		}
	case "netsim":
		if NewNetsimFeatureFunc != nil {
			return NewNetsimFeatureFunc()
		}
	case "paging":
		if NewPagingFeatureFunc != nil {
			return NewPagingFeatureFunc()
		}
	case "proxy":
		if NewProxyFeatureFunc != nil {
			return NewProxyFeatureFunc()
		}
	case "ratelimit":
		if NewRatelimitFeatureFunc != nil {
			return NewRatelimitFeatureFunc()
		}
	case "rbac":
		if NewRbacFeatureFunc != nil {
			return NewRbacFeatureFunc()
		}
	case "retry":
		if NewRetryFeatureFunc != nil {
			return NewRetryFeatureFunc()
		}
	case "secrets":
		if NewSecretsFeatureFunc != nil {
			return NewSecretsFeatureFunc()
		}
	case "streaming":
		if NewStreamingFeatureFunc != nil {
			return NewStreamingFeatureFunc()
		}
	case "telemetry":
		if NewTelemetryFeatureFunc != nil {
			return NewTelemetryFeatureFunc()
		}
	case "test":
		if NewTestFeatureFunc != nil {
			return NewTestFeatureFunc()
		}
	case "timeout":
		if NewTimeoutFeatureFunc != nil {
			return NewTimeoutFeatureFunc()
		}
	case "validate":
		if NewValidateFeatureFunc != nil {
			return NewValidateFeatureFunc()
		}
	default:
		if NewBaseFeatureFunc != nil {
			return NewBaseFeatureFunc()
		}
	}
	return nil
}
