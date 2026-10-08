;; Smsapi SDK generated API tests.
(ns sdk.gentest
  (:require [sdk.api :as api]
            [sdk.config :as config]
            [sdk.testutil :as t]
            [clojure.string]
            [voxgig.struct :as vs]
            [sdk.entity.available :as e-available]
            [sdk.entity.blacklist :as e-blacklist]
            [sdk.entity.callback :as e-callback]
            [sdk.entity.contact :as e-contact]
            [sdk.entity.contacts_field :as e-contacts_field]
            [sdk.entity.contacts_field_option :as e-contacts_field_option]
            [sdk.entity.contactsgroup :as e-contactsgroup]
            [sdk.entity.contactstrash :as e-contactstrash]
            [sdk.entity.field_available :as e-field_available]
            [sdk.entity.group :as e-group]
            [sdk.entity.mfa_code :as e-mfa_code]
            [sdk.entity.opt_out :as e-opt_out]
            [sdk.entity.opt_out_setting :as e-opt_out_setting]
            [sdk.entity.permission :as e-permission]
            [sdk.entity.ping :as e-ping]
            [sdk.entity.profile :as e-profile]
            [sdk.entity.rcs :as e-rcs]
            [sdk.entity.sendername :as e-sendername]
            [sdk.entity.sendername_statement :as e-sendername_statement]
            [sdk.entity.sent_rcs_message :as e-sent_rcs_message]
            [sdk.entity.shipment_country_volume :as e-shipment_country_volume]
            [sdk.entity.short_url :as e-short_url]
            [sdk.entity.smsdo :as e-smsdo]
            [sdk.entity.smssendername :as e-smssendername]
            [sdk.entity.smstemplate :as e-smstemplate]
            [sdk.entity.subuser :as e-subuser]
            [sdk.entity.template :as e-template]
            [sdk.entity.user_rcs_sender_collection :as e-user_rcs_sender_collection]))

(defn run [rec]
  (t/run-check rec "gen-exists-available"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/available sdk nil)) "available accessor present"))))
  (t/run-check rec "gen-smoke-available"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/available sdk nil)]
             (let [items (e-available/list ent (vs/jm) nil)]
               ;; list resolves to one entity per record.
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
  (t/run-check rec "gen-list-available"
    (fn [] (let [seed (vs/jm "available" (vs/jm "L1" (vs/jm "id" "L1" "name" "a")
                                                "L2" (vs/jm "id" "L2" "name" "b")))
                 items (e-available/list (api/available (api/test-sdk (vs/jm "entity" seed) nil) nil)
                                         (vs/jm) nil)]
             ;; list resolves to one entity per record; data-get reads the record.
             (t/is-eq (count items) 2 "list answers each seeded record")
             (t/is-true (every? (fn [item] (and (map? item) (vs/ismap ((:data-get item))))) items)
                        "each listed item is an entity carrying its record"))))
  (t/run-check rec "gen-stream-available"
    (fn [] (let [seed (vs/jm "available" (vs/jm "S1" (vs/jm "id" "S1" "name" "a")
                                                "S2" (vs/jm "id" "S2" "name" "b")
                                                "S3" (vs/jm "id" "S3" "name" "c")))]
             ;; Fallback (no streaming feature): materialised items.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   items (vec (e-available/stream (api/available sdk nil) "list" (vs/jm) nil))]
               (t/is-eq (count items) 3 "stream fallback yields materialised items")
               (t/is-true (vs/ismap (first items)) "stream yields bare record maps"))
             ;; signal cancels iteration between yields.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   n (atom 0) sig (fn [] (>= (swap! n inc) 2))
                   items (vec (e-available/stream (api/available sdk nil) "list" (vs/jm) (vs/jm "signal" sig)))]
               (t/is-eq (count items) 1 "stream signal stops after first yield"))
             ;; Streaming feature active: yields from the streaming iterator.
             (when (vs/getpath (config/make-config) "feature.streaming")
               (let [ssdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true))))]
                 (t/is-eq (count (vec (e-available/stream (api/available ssdk nil) "list" (vs/jm) nil))) 3
                          "stream (streaming active) yields all items"))
               (let [csdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true "chunkSize" 2))))
                     batches (vec (e-available/stream (api/available csdk nil) "list" (vs/jm) nil))]
                 (t/is-eq (count batches) 2 "stream chunkSize groups items into 2 batches"))))))
  (t/run-check rec "gen-stream-error-available"
    (fn [] (let [offline (vs/jm "net" (vs/jm "offline" true))
                 err (try (vec (e-available/stream (api/available (api/test-sdk offline nil) nil) "list" (vs/jm) nil)) nil
                          (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "offline"))
                        "the transport failure raises from the stream")
             (t/is-eq (count (vec (e-available/stream (api/available (api/test-sdk offline nil) nil) "list" (vs/jm)
                                                 (vs/jm "ctrl" (vs/jm "throw" false)))))
                      0 "throw false ends the stream quietly")
             (when (vs/getpath (config/make-config) "feature.rbac")
               (let [denied (api/test-sdk nil (vs/jm "feature" (vs/jm "rbac" (vs/jm "active" true "deny" true))))]
                 (t/is-throws (fn [] (vec (e-available/stream (api/available denied nil) "list" (vs/jm) nil)))
                              "rbac_denied" "the rbac denial raises from the stream"))))))
  (t/run-check rec "gen-stream-ctrl-available"
    (fn [] (let [explain (vs/jm)
                 ctrl (vs/jm "explain" explain)]
             (vec (e-available/stream (api/available (api/test-sdk nil nil) nil) "list" (vs/jm) (vs/jm "ctrl" ctrl)))
             (t/is-eq (vec (vs/keysof ctrl)) ["explain"] "the stream changed the caller's ctrl")
             (t/is-true (identical? explain (vs/getprop ctrl "explain")) "the caller's explain record is not its own")
             (t/is-true (pos? (count (vs/keysof explain))) "the caller's explain record was not filled"))))
  (t/run-check rec "gen-unexpected-available"
    (fn [] (let [seen (atom 0)
                 hook (atom {:name "failhook" :active true :version "0.0.1" :_options nil
                             "init" (fn [_ctx _opts] nil)
                             "PreSpec" (fn [_ctx] (throw (RuntimeException. "available hook failed")))
                             "PreUnexpected" (fn [_ctx] (swap! seen inc))})
                 ent (api/available (api/make-sdk (vs/jm "feature" (vs/jm "test" (vs/jm "active" true)) "extend" [hook])) nil)
                 err (try (e-available/list ent (vs/jm) nil) nil (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "hook failed"))
                        "the hook's failure is raised")
             (t/is-true (pos? @seen) "PreUnexpected did not fire")
             (let [fired @seen]
               (t/is-nil (e-available/list ent (vs/jm) (vs/jm "throw" false)) "throw false should resolve to nothing")
               (t/is-true (> @seen fired) "PreUnexpected did not fire under throw false")))))
  (t/run-check rec "gen-validate-available"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-available/list (api/available client nil) (vs/jm "name" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-blacklist"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/blacklist sdk nil)) "blacklist accessor present"))))
  (t/run-check rec "gen-smoke-blacklist"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/blacklist sdk nil)]
             (let [res (e-blacklist/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             )))
  (t/run-check rec "gen-validate-blacklist"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-blacklist/load (api/blacklist client nil) (vs/jm "limit" "x") nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-callback"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/callback sdk nil)) "callback accessor present"))))
  (t/run-check rec "gen-smoke-callback"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/callback sdk nil)]
             (let [res (e-callback/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             (let [items (e-callback/list ent (vs/jm) nil)]
               ;; list resolves to one entity per record.
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
  (t/run-check rec "gen-list-callback"
    (fn [] (let [seed (vs/jm "callback" (vs/jm "L1" (vs/jm "id" "L1" "name" "a")
                                                "L2" (vs/jm "id" "L2" "name" "b")))
                 items (e-callback/list (api/callback (api/test-sdk (vs/jm "entity" seed) nil) nil)
                                         (vs/jm) nil)]
             ;; list resolves to one entity per record; data-get reads the record.
             (t/is-eq (count items) 2 "list answers each seeded record")
             (t/is-true (every? (fn [item] (and (map? item) (vs/ismap ((:data-get item))))) items)
                        "each listed item is an entity carrying its record"))))
  (t/run-check rec "gen-stream-callback"
    (fn [] (let [seed (vs/jm "callback" (vs/jm "S1" (vs/jm "id" "S1" "name" "a")
                                                "S2" (vs/jm "id" "S2" "name" "b")
                                                "S3" (vs/jm "id" "S3" "name" "c")))]
             ;; Fallback (no streaming feature): materialised items.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   items (vec (e-callback/stream (api/callback sdk nil) "list" (vs/jm) nil))]
               (t/is-eq (count items) 3 "stream fallback yields materialised items")
               (t/is-true (vs/ismap (first items)) "stream yields bare record maps"))
             ;; signal cancels iteration between yields.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   n (atom 0) sig (fn [] (>= (swap! n inc) 2))
                   items (vec (e-callback/stream (api/callback sdk nil) "list" (vs/jm) (vs/jm "signal" sig)))]
               (t/is-eq (count items) 1 "stream signal stops after first yield"))
             ;; Streaming feature active: yields from the streaming iterator.
             (when (vs/getpath (config/make-config) "feature.streaming")
               (let [ssdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true))))]
                 (t/is-eq (count (vec (e-callback/stream (api/callback ssdk nil) "list" (vs/jm) nil))) 3
                          "stream (streaming active) yields all items"))
               (let [csdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true "chunkSize" 2))))
                     batches (vec (e-callback/stream (api/callback csdk nil) "list" (vs/jm) nil))]
                 (t/is-eq (count batches) 2 "stream chunkSize groups items into 2 batches"))))))
  (t/run-check rec "gen-stream-error-callback"
    (fn [] (let [offline (vs/jm "net" (vs/jm "offline" true))
                 err (try (vec (e-callback/stream (api/callback (api/test-sdk offline nil) nil) "list" (vs/jm) nil)) nil
                          (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "offline"))
                        "the transport failure raises from the stream")
             (t/is-eq (count (vec (e-callback/stream (api/callback (api/test-sdk offline nil) nil) "list" (vs/jm)
                                                 (vs/jm "ctrl" (vs/jm "throw" false)))))
                      0 "throw false ends the stream quietly")
             (when (vs/getpath (config/make-config) "feature.rbac")
               (let [denied (api/test-sdk nil (vs/jm "feature" (vs/jm "rbac" (vs/jm "active" true "deny" true))))]
                 (t/is-throws (fn [] (vec (e-callback/stream (api/callback denied nil) "list" (vs/jm) nil)))
                              "rbac_denied" "the rbac denial raises from the stream"))))))
  (t/run-check rec "gen-stream-ctrl-callback"
    (fn [] (let [explain (vs/jm)
                 ctrl (vs/jm "explain" explain)]
             (vec (e-callback/stream (api/callback (api/test-sdk nil nil) nil) "list" (vs/jm) (vs/jm "ctrl" ctrl)))
             (t/is-eq (vec (vs/keysof ctrl)) ["explain"] "the stream changed the caller's ctrl")
             (t/is-true (identical? explain (vs/getprop ctrl "explain")) "the caller's explain record is not its own")
             (t/is-true (pos? (count (vs/keysof explain))) "the caller's explain record was not filled"))))
  (t/run-check rec "gen-unexpected-callback"
    (fn [] (let [seen (atom 0)
                 hook (atom {:name "failhook" :active true :version "0.0.1" :_options nil
                             "init" (fn [_ctx _opts] nil)
                             "PreSpec" (fn [_ctx] (throw (RuntimeException. "callback hook failed")))
                             "PreUnexpected" (fn [_ctx] (swap! seen inc))})
                 ent (api/callback (api/make-sdk (vs/jm "feature" (vs/jm "test" (vs/jm "active" true)) "extend" [hook])) nil)
                 err (try (e-callback/list ent (vs/jm) nil) nil (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "hook failed"))
                        "the hook's failure is raised")
             (t/is-true (pos? @seen) "PreUnexpected did not fire")
             (let [fired @seen]
               (t/is-nil (e-callback/list ent (vs/jm) (vs/jm "throw" false)) "throw false should resolve to nothing")
               (t/is-true (> @seen fired) "PreUnexpected did not fire under throw false")))))
  (t/run-check rec "gen-validate-callback"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-callback/list (api/callback client nil) (vs/jm "active" "x") nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-contact"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/contact sdk nil)) "contact accessor present"))))
  (t/run-check rec "gen-smoke-contact"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/contact sdk nil)]
             (let [res (e-contact/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             (let [items (e-contact/list ent (vs/jm) nil)]
               ;; list resolves to one entity per record.
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
  (t/run-check rec "gen-list-contact"
    (fn [] (let [seed (vs/jm "contact" (vs/jm "L1" (vs/jm "id" "L1" "name" "a")
                                                "L2" (vs/jm "id" "L2" "name" "b")))
                 items (e-contact/list (api/contact (api/test-sdk (vs/jm "entity" seed) nil) nil)
                                         (vs/jm) nil)]
             ;; list resolves to one entity per record; data-get reads the record.
             (t/is-eq (count items) 2 "list answers each seeded record")
             (t/is-true (every? (fn [item] (and (map? item) (vs/ismap ((:data-get item))))) items)
                        "each listed item is an entity carrying its record"))))
  (t/run-check rec "gen-stream-contact"
    (fn [] (let [seed (vs/jm "contact" (vs/jm "S1" (vs/jm "id" "S1" "name" "a")
                                                "S2" (vs/jm "id" "S2" "name" "b")
                                                "S3" (vs/jm "id" "S3" "name" "c")))]
             ;; Fallback (no streaming feature): materialised items.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   items (vec (e-contact/stream (api/contact sdk nil) "list" (vs/jm) nil))]
               (t/is-eq (count items) 3 "stream fallback yields materialised items")
               (t/is-true (vs/ismap (first items)) "stream yields bare record maps"))
             ;; signal cancels iteration between yields.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   n (atom 0) sig (fn [] (>= (swap! n inc) 2))
                   items (vec (e-contact/stream (api/contact sdk nil) "list" (vs/jm) (vs/jm "signal" sig)))]
               (t/is-eq (count items) 1 "stream signal stops after first yield"))
             ;; Streaming feature active: yields from the streaming iterator.
             (when (vs/getpath (config/make-config) "feature.streaming")
               (let [ssdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true))))]
                 (t/is-eq (count (vec (e-contact/stream (api/contact ssdk nil) "list" (vs/jm) nil))) 3
                          "stream (streaming active) yields all items"))
               (let [csdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true "chunkSize" 2))))
                     batches (vec (e-contact/stream (api/contact csdk nil) "list" (vs/jm) nil))]
                 (t/is-eq (count batches) 2 "stream chunkSize groups items into 2 batches"))))))
  (t/run-check rec "gen-stream-error-contact"
    (fn [] (let [offline (vs/jm "net" (vs/jm "offline" true))
                 err (try (vec (e-contact/stream (api/contact (api/test-sdk offline nil) nil) "list" (vs/jm) nil)) nil
                          (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "offline"))
                        "the transport failure raises from the stream")
             (t/is-eq (count (vec (e-contact/stream (api/contact (api/test-sdk offline nil) nil) "list" (vs/jm)
                                                 (vs/jm "ctrl" (vs/jm "throw" false)))))
                      0 "throw false ends the stream quietly")
             (when (vs/getpath (config/make-config) "feature.rbac")
               (let [denied (api/test-sdk nil (vs/jm "feature" (vs/jm "rbac" (vs/jm "active" true "deny" true))))]
                 (t/is-throws (fn [] (vec (e-contact/stream (api/contact denied nil) "list" (vs/jm) nil)))
                              "rbac_denied" "the rbac denial raises from the stream"))))))
  (t/run-check rec "gen-stream-ctrl-contact"
    (fn [] (let [explain (vs/jm)
                 ctrl (vs/jm "explain" explain)]
             (vec (e-contact/stream (api/contact (api/test-sdk nil nil) nil) "list" (vs/jm) (vs/jm "ctrl" ctrl)))
             (t/is-eq (vec (vs/keysof ctrl)) ["explain"] "the stream changed the caller's ctrl")
             (t/is-true (identical? explain (vs/getprop ctrl "explain")) "the caller's explain record is not its own")
             (t/is-true (pos? (count (vs/keysof explain))) "the caller's explain record was not filled"))))
  (t/run-check rec "gen-unexpected-contact"
    (fn [] (let [seen (atom 0)
                 hook (atom {:name "failhook" :active true :version "0.0.1" :_options nil
                             "init" (fn [_ctx _opts] nil)
                             "PreSpec" (fn [_ctx] (throw (RuntimeException. "contact hook failed")))
                             "PreUnexpected" (fn [_ctx] (swap! seen inc))})
                 ent (api/contact (api/make-sdk (vs/jm "feature" (vs/jm "test" (vs/jm "active" true)) "extend" [hook])) nil)
                 err (try (e-contact/list ent (vs/jm) nil) nil (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "hook failed"))
                        "the hook's failure is raised")
             (t/is-true (pos? @seen) "PreUnexpected did not fire")
             (let [fired @seen]
               (t/is-nil (e-contact/list ent (vs/jm) (vs/jm "throw" false)) "throw false should resolve to nothing")
               (t/is-true (> @seen fired) "PreUnexpected did not fire under throw false")))))
  (t/run-check rec "gen-validate-contact"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-contact/list (api/contact client nil) (vs/jm "gender" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-contacts_field"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/contacts_field sdk nil)) "contacts_field accessor present"))))
  (t/run-check rec "gen-smoke-contacts_field"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/contacts_field sdk nil)]
             (let [res (e-contacts_field/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             (let [items (e-contacts_field/list ent (vs/jm) nil)]
               ;; list resolves to one entity per record.
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
  (t/run-check rec "gen-list-contacts_field"
    (fn [] (let [seed (vs/jm "contacts_field" (vs/jm "L1" (vs/jm "id" "L1" "name" "a")
                                                "L2" (vs/jm "id" "L2" "name" "b")))
                 items (e-contacts_field/list (api/contacts_field (api/test-sdk (vs/jm "entity" seed) nil) nil)
                                         (vs/jm) nil)]
             ;; list resolves to one entity per record; data-get reads the record.
             (t/is-eq (count items) 2 "list answers each seeded record")
             (t/is-true (every? (fn [item] (and (map? item) (vs/ismap ((:data-get item))))) items)
                        "each listed item is an entity carrying its record"))))
  (t/run-check rec "gen-stream-contacts_field"
    (fn [] (let [seed (vs/jm "contacts_field" (vs/jm "S1" (vs/jm "id" "S1" "name" "a")
                                                "S2" (vs/jm "id" "S2" "name" "b")
                                                "S3" (vs/jm "id" "S3" "name" "c")))]
             ;; Fallback (no streaming feature): materialised items.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   items (vec (e-contacts_field/stream (api/contacts_field sdk nil) "list" (vs/jm) nil))]
               (t/is-eq (count items) 3 "stream fallback yields materialised items")
               (t/is-true (vs/ismap (first items)) "stream yields bare record maps"))
             ;; signal cancels iteration between yields.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   n (atom 0) sig (fn [] (>= (swap! n inc) 2))
                   items (vec (e-contacts_field/stream (api/contacts_field sdk nil) "list" (vs/jm) (vs/jm "signal" sig)))]
               (t/is-eq (count items) 1 "stream signal stops after first yield"))
             ;; Streaming feature active: yields from the streaming iterator.
             (when (vs/getpath (config/make-config) "feature.streaming")
               (let [ssdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true))))]
                 (t/is-eq (count (vec (e-contacts_field/stream (api/contacts_field ssdk nil) "list" (vs/jm) nil))) 3
                          "stream (streaming active) yields all items"))
               (let [csdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true "chunkSize" 2))))
                     batches (vec (e-contacts_field/stream (api/contacts_field csdk nil) "list" (vs/jm) nil))]
                 (t/is-eq (count batches) 2 "stream chunkSize groups items into 2 batches"))))))
  (t/run-check rec "gen-stream-error-contacts_field"
    (fn [] (let [offline (vs/jm "net" (vs/jm "offline" true))
                 err (try (vec (e-contacts_field/stream (api/contacts_field (api/test-sdk offline nil) nil) "list" (vs/jm) nil)) nil
                          (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "offline"))
                        "the transport failure raises from the stream")
             (t/is-eq (count (vec (e-contacts_field/stream (api/contacts_field (api/test-sdk offline nil) nil) "list" (vs/jm)
                                                 (vs/jm "ctrl" (vs/jm "throw" false)))))
                      0 "throw false ends the stream quietly")
             (when (vs/getpath (config/make-config) "feature.rbac")
               (let [denied (api/test-sdk nil (vs/jm "feature" (vs/jm "rbac" (vs/jm "active" true "deny" true))))]
                 (t/is-throws (fn [] (vec (e-contacts_field/stream (api/contacts_field denied nil) "list" (vs/jm) nil)))
                              "rbac_denied" "the rbac denial raises from the stream"))))))
  (t/run-check rec "gen-stream-ctrl-contacts_field"
    (fn [] (let [explain (vs/jm)
                 ctrl (vs/jm "explain" explain)]
             (vec (e-contacts_field/stream (api/contacts_field (api/test-sdk nil nil) nil) "list" (vs/jm) (vs/jm "ctrl" ctrl)))
             (t/is-eq (vec (vs/keysof ctrl)) ["explain"] "the stream changed the caller's ctrl")
             (t/is-true (identical? explain (vs/getprop ctrl "explain")) "the caller's explain record is not its own")
             (t/is-true (pos? (count (vs/keysof explain))) "the caller's explain record was not filled"))))
  (t/run-check rec "gen-unexpected-contacts_field"
    (fn [] (let [seen (atom 0)
                 hook (atom {:name "failhook" :active true :version "0.0.1" :_options nil
                             "init" (fn [_ctx _opts] nil)
                             "PreSpec" (fn [_ctx] (throw (RuntimeException. "contacts_field hook failed")))
                             "PreUnexpected" (fn [_ctx] (swap! seen inc))})
                 ent (api/contacts_field (api/make-sdk (vs/jm "feature" (vs/jm "test" (vs/jm "active" true)) "extend" [hook])) nil)
                 err (try (e-contacts_field/list ent (vs/jm) nil) nil (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "hook failed"))
                        "the hook's failure is raised")
             (t/is-true (pos? @seen) "PreUnexpected did not fire")
             (let [fired @seen]
               (t/is-nil (e-contacts_field/list ent (vs/jm) (vs/jm "throw" false)) "throw false should resolve to nothing")
               (t/is-true (> @seen fired) "PreUnexpected did not fire under throw false")))))
  (t/run-check rec "gen-validate-contacts_field"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-contacts_field/list (api/contacts_field client nil) (vs/jm "id" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-contacts_field_option"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/contacts_field_option sdk nil)) "contacts_field_option accessor present"))))
  (t/run-check rec "gen-validate-contacts_field_option"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-contacts_field_option/list (api/contacts_field_option client nil) (vs/jm "field_id" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-contactsgroup"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/contactsgroup sdk nil)) "contactsgroup accessor present"))))
  (t/run-check rec "gen-smoke-contactsgroup"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/contactsgroup sdk nil)]
             (let [res (e-contactsgroup/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             (let [items (e-contactsgroup/list ent (vs/jm) nil)]
               ;; list resolves to one entity per record.
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
  (t/run-check rec "gen-list-contactsgroup"
    (fn [] (let [seed (vs/jm "contactsgroup" (vs/jm "L1" (vs/jm "id" "L1" "name" "a")
                                                "L2" (vs/jm "id" "L2" "name" "b")))
                 items (e-contactsgroup/list (api/contactsgroup (api/test-sdk (vs/jm "entity" seed) nil) nil)
                                         (vs/jm) nil)]
             ;; list resolves to one entity per record; data-get reads the record.
             (t/is-eq (count items) 2 "list answers each seeded record")
             (t/is-true (every? (fn [item] (and (map? item) (vs/ismap ((:data-get item))))) items)
                        "each listed item is an entity carrying its record"))))
  (t/run-check rec "gen-stream-contactsgroup"
    (fn [] (let [seed (vs/jm "contactsgroup" (vs/jm "S1" (vs/jm "id" "S1" "name" "a")
                                                "S2" (vs/jm "id" "S2" "name" "b")
                                                "S3" (vs/jm "id" "S3" "name" "c")))]
             ;; Fallback (no streaming feature): materialised items.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   items (vec (e-contactsgroup/stream (api/contactsgroup sdk nil) "list" (vs/jm) nil))]
               (t/is-eq (count items) 3 "stream fallback yields materialised items")
               (t/is-true (vs/ismap (first items)) "stream yields bare record maps"))
             ;; signal cancels iteration between yields.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   n (atom 0) sig (fn [] (>= (swap! n inc) 2))
                   items (vec (e-contactsgroup/stream (api/contactsgroup sdk nil) "list" (vs/jm) (vs/jm "signal" sig)))]
               (t/is-eq (count items) 1 "stream signal stops after first yield"))
             ;; Streaming feature active: yields from the streaming iterator.
             (when (vs/getpath (config/make-config) "feature.streaming")
               (let [ssdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true))))]
                 (t/is-eq (count (vec (e-contactsgroup/stream (api/contactsgroup ssdk nil) "list" (vs/jm) nil))) 3
                          "stream (streaming active) yields all items"))
               (let [csdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true "chunkSize" 2))))
                     batches (vec (e-contactsgroup/stream (api/contactsgroup csdk nil) "list" (vs/jm) nil))]
                 (t/is-eq (count batches) 2 "stream chunkSize groups items into 2 batches"))))))
  (t/run-check rec "gen-stream-error-contactsgroup"
    (fn [] (let [offline (vs/jm "net" (vs/jm "offline" true))
                 err (try (vec (e-contactsgroup/stream (api/contactsgroup (api/test-sdk offline nil) nil) "list" (vs/jm) nil)) nil
                          (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "offline"))
                        "the transport failure raises from the stream")
             (t/is-eq (count (vec (e-contactsgroup/stream (api/contactsgroup (api/test-sdk offline nil) nil) "list" (vs/jm)
                                                 (vs/jm "ctrl" (vs/jm "throw" false)))))
                      0 "throw false ends the stream quietly")
             (when (vs/getpath (config/make-config) "feature.rbac")
               (let [denied (api/test-sdk nil (vs/jm "feature" (vs/jm "rbac" (vs/jm "active" true "deny" true))))]
                 (t/is-throws (fn [] (vec (e-contactsgroup/stream (api/contactsgroup denied nil) "list" (vs/jm) nil)))
                              "rbac_denied" "the rbac denial raises from the stream"))))))
  (t/run-check rec "gen-stream-ctrl-contactsgroup"
    (fn [] (let [explain (vs/jm)
                 ctrl (vs/jm "explain" explain)]
             (vec (e-contactsgroup/stream (api/contactsgroup (api/test-sdk nil nil) nil) "list" (vs/jm) (vs/jm "ctrl" ctrl)))
             (t/is-eq (vec (vs/keysof ctrl)) ["explain"] "the stream changed the caller's ctrl")
             (t/is-true (identical? explain (vs/getprop ctrl "explain")) "the caller's explain record is not its own")
             (t/is-true (pos? (count (vs/keysof explain))) "the caller's explain record was not filled"))))
  (t/run-check rec "gen-unexpected-contactsgroup"
    (fn [] (let [seen (atom 0)
                 hook (atom {:name "failhook" :active true :version "0.0.1" :_options nil
                             "init" (fn [_ctx _opts] nil)
                             "PreSpec" (fn [_ctx] (throw (RuntimeException. "contactsgroup hook failed")))
                             "PreUnexpected" (fn [_ctx] (swap! seen inc))})
                 ent (api/contactsgroup (api/make-sdk (vs/jm "feature" (vs/jm "test" (vs/jm "active" true)) "extend" [hook])) nil)
                 err (try (e-contactsgroup/list ent (vs/jm) nil) nil (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "hook failed"))
                        "the hook's failure is raised")
             (t/is-true (pos? @seen) "PreUnexpected did not fire")
             (let [fired @seen]
               (t/is-nil (e-contactsgroup/list ent (vs/jm) (vs/jm "throw" false)) "throw false should resolve to nothing")
               (t/is-true (> @seen fired) "PreUnexpected did not fire under throw false")))))
  (t/run-check rec "gen-validate-contactsgroup"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-contactsgroup/create (api/contactsgroup client nil) (vs/jm "group_id" 1 "read" true "send" true "username" "x" "write" true) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-contactstrash"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/contactstrash sdk nil)) "contactstrash accessor present"))))
  (t/run-check rec "gen-exists-field_available"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/field_available sdk nil)) "field_available accessor present"))))
  (t/run-check rec "gen-smoke-field_available"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/field_available sdk nil)]
             (let [items (e-field_available/list ent (vs/jm) nil)]
               ;; list resolves to one entity per record.
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
  (t/run-check rec "gen-list-field_available"
    (fn [] (let [seed (vs/jm "field_available" (vs/jm "L1" (vs/jm "id" "L1" "name" "a")
                                                "L2" (vs/jm "id" "L2" "name" "b")))
                 items (e-field_available/list (api/field_available (api/test-sdk (vs/jm "entity" seed) nil) nil)
                                         (vs/jm) nil)]
             ;; list resolves to one entity per record; data-get reads the record.
             (t/is-eq (count items) 2 "list answers each seeded record")
             (t/is-true (every? (fn [item] (and (map? item) (vs/ismap ((:data-get item))))) items)
                        "each listed item is an entity carrying its record"))))
  (t/run-check rec "gen-stream-field_available"
    (fn [] (let [seed (vs/jm "field_available" (vs/jm "S1" (vs/jm "id" "S1" "name" "a")
                                                "S2" (vs/jm "id" "S2" "name" "b")
                                                "S3" (vs/jm "id" "S3" "name" "c")))]
             ;; Fallback (no streaming feature): materialised items.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   items (vec (e-field_available/stream (api/field_available sdk nil) "list" (vs/jm) nil))]
               (t/is-eq (count items) 3 "stream fallback yields materialised items")
               (t/is-true (vs/ismap (first items)) "stream yields bare record maps"))
             ;; signal cancels iteration between yields.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   n (atom 0) sig (fn [] (>= (swap! n inc) 2))
                   items (vec (e-field_available/stream (api/field_available sdk nil) "list" (vs/jm) (vs/jm "signal" sig)))]
               (t/is-eq (count items) 1 "stream signal stops after first yield"))
             ;; Streaming feature active: yields from the streaming iterator.
             (when (vs/getpath (config/make-config) "feature.streaming")
               (let [ssdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true))))]
                 (t/is-eq (count (vec (e-field_available/stream (api/field_available ssdk nil) "list" (vs/jm) nil))) 3
                          "stream (streaming active) yields all items"))
               (let [csdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true "chunkSize" 2))))
                     batches (vec (e-field_available/stream (api/field_available csdk nil) "list" (vs/jm) nil))]
                 (t/is-eq (count batches) 2 "stream chunkSize groups items into 2 batches"))))))
  (t/run-check rec "gen-stream-error-field_available"
    (fn [] (let [offline (vs/jm "net" (vs/jm "offline" true))
                 err (try (vec (e-field_available/stream (api/field_available (api/test-sdk offline nil) nil) "list" (vs/jm) nil)) nil
                          (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "offline"))
                        "the transport failure raises from the stream")
             (t/is-eq (count (vec (e-field_available/stream (api/field_available (api/test-sdk offline nil) nil) "list" (vs/jm)
                                                 (vs/jm "ctrl" (vs/jm "throw" false)))))
                      0 "throw false ends the stream quietly")
             (when (vs/getpath (config/make-config) "feature.rbac")
               (let [denied (api/test-sdk nil (vs/jm "feature" (vs/jm "rbac" (vs/jm "active" true "deny" true))))]
                 (t/is-throws (fn [] (vec (e-field_available/stream (api/field_available denied nil) "list" (vs/jm) nil)))
                              "rbac_denied" "the rbac denial raises from the stream"))))))
  (t/run-check rec "gen-stream-ctrl-field_available"
    (fn [] (let [explain (vs/jm)
                 ctrl (vs/jm "explain" explain)]
             (vec (e-field_available/stream (api/field_available (api/test-sdk nil nil) nil) "list" (vs/jm) (vs/jm "ctrl" ctrl)))
             (t/is-eq (vec (vs/keysof ctrl)) ["explain"] "the stream changed the caller's ctrl")
             (t/is-true (identical? explain (vs/getprop ctrl "explain")) "the caller's explain record is not its own")
             (t/is-true (pos? (count (vs/keysof explain))) "the caller's explain record was not filled"))))
  (t/run-check rec "gen-unexpected-field_available"
    (fn [] (let [seen (atom 0)
                 hook (atom {:name "failhook" :active true :version "0.0.1" :_options nil
                             "init" (fn [_ctx _opts] nil)
                             "PreSpec" (fn [_ctx] (throw (RuntimeException. "field_available hook failed")))
                             "PreUnexpected" (fn [_ctx] (swap! seen inc))})
                 ent (api/field_available (api/make-sdk (vs/jm "feature" (vs/jm "test" (vs/jm "active" true)) "extend" [hook])) nil)
                 err (try (e-field_available/list ent (vs/jm) nil) nil (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "hook failed"))
                        "the hook's failure is raised")
             (t/is-true (pos? @seen) "PreUnexpected did not fire")
             (let [fired @seen]
               (t/is-nil (e-field_available/list ent (vs/jm) (vs/jm "throw" false)) "throw false should resolve to nothing")
               (t/is-true (> @seen fired) "PreUnexpected did not fire under throw false")))))
  (t/run-check rec "gen-validate-field_available"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-field_available/list (api/field_available client nil) (vs/jm "built_in" "x") nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-group"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/group sdk nil)) "group accessor present"))))
  (t/run-check rec "gen-validate-group"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-group/load (api/group client nil) (vs/jm "id" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-mfa_code"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/mfa_code sdk nil)) "mfa_code accessor present"))))
  (t/run-check rec "gen-smoke-mfa_code"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/mfa_code sdk nil)]
             (let [res (e-mfa_code/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             )))
  (t/run-check rec "gen-validate-mfa_code"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-mfa_code/create (api/mfa_code client nil) (vs/jm "content" 1 "phone_number" "x") nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-opt_out"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/opt_out sdk nil)) "opt_out accessor present"))))
  (t/run-check rec "gen-smoke-opt_out"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/opt_out sdk nil)]
             (let [items (e-opt_out/list ent (vs/jm) nil)]
               ;; list resolves to one entity per record.
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
  (t/run-check rec "gen-list-opt_out"
    (fn [] (let [seed (vs/jm "opt_out" (vs/jm "L1" (vs/jm "id" "L1" "name" "a")
                                                "L2" (vs/jm "id" "L2" "name" "b")))
                 items (e-opt_out/list (api/opt_out (api/test-sdk (vs/jm "entity" seed) nil) nil)
                                         (vs/jm) nil)]
             ;; list resolves to one entity per record; data-get reads the record.
             (t/is-eq (count items) 2 "list answers each seeded record")
             (t/is-true (every? (fn [item] (and (map? item) (vs/ismap ((:data-get item))))) items)
                        "each listed item is an entity carrying its record"))))
  (t/run-check rec "gen-stream-opt_out"
    (fn [] (let [seed (vs/jm "opt_out" (vs/jm "S1" (vs/jm "id" "S1" "name" "a")
                                                "S2" (vs/jm "id" "S2" "name" "b")
                                                "S3" (vs/jm "id" "S3" "name" "c")))]
             ;; Fallback (no streaming feature): materialised items.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   items (vec (e-opt_out/stream (api/opt_out sdk nil) "list" (vs/jm) nil))]
               (t/is-eq (count items) 3 "stream fallback yields materialised items")
               (t/is-true (vs/ismap (first items)) "stream yields bare record maps"))
             ;; signal cancels iteration between yields.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   n (atom 0) sig (fn [] (>= (swap! n inc) 2))
                   items (vec (e-opt_out/stream (api/opt_out sdk nil) "list" (vs/jm) (vs/jm "signal" sig)))]
               (t/is-eq (count items) 1 "stream signal stops after first yield"))
             ;; Streaming feature active: yields from the streaming iterator.
             (when (vs/getpath (config/make-config) "feature.streaming")
               (let [ssdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true))))]
                 (t/is-eq (count (vec (e-opt_out/stream (api/opt_out ssdk nil) "list" (vs/jm) nil))) 3
                          "stream (streaming active) yields all items"))
               (let [csdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true "chunkSize" 2))))
                     batches (vec (e-opt_out/stream (api/opt_out csdk nil) "list" (vs/jm) nil))]
                 (t/is-eq (count batches) 2 "stream chunkSize groups items into 2 batches"))))))
  (t/run-check rec "gen-stream-error-opt_out"
    (fn [] (let [offline (vs/jm "net" (vs/jm "offline" true))
                 err (try (vec (e-opt_out/stream (api/opt_out (api/test-sdk offline nil) nil) "list" (vs/jm) nil)) nil
                          (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "offline"))
                        "the transport failure raises from the stream")
             (t/is-eq (count (vec (e-opt_out/stream (api/opt_out (api/test-sdk offline nil) nil) "list" (vs/jm)
                                                 (vs/jm "ctrl" (vs/jm "throw" false)))))
                      0 "throw false ends the stream quietly")
             (when (vs/getpath (config/make-config) "feature.rbac")
               (let [denied (api/test-sdk nil (vs/jm "feature" (vs/jm "rbac" (vs/jm "active" true "deny" true))))]
                 (t/is-throws (fn [] (vec (e-opt_out/stream (api/opt_out denied nil) "list" (vs/jm) nil)))
                              "rbac_denied" "the rbac denial raises from the stream"))))))
  (t/run-check rec "gen-stream-ctrl-opt_out"
    (fn [] (let [explain (vs/jm)
                 ctrl (vs/jm "explain" explain)]
             (vec (e-opt_out/stream (api/opt_out (api/test-sdk nil nil) nil) "list" (vs/jm) (vs/jm "ctrl" ctrl)))
             (t/is-eq (vec (vs/keysof ctrl)) ["explain"] "the stream changed the caller's ctrl")
             (t/is-true (identical? explain (vs/getprop ctrl "explain")) "the caller's explain record is not its own")
             (t/is-true (pos? (count (vs/keysof explain))) "the caller's explain record was not filled"))))
  (t/run-check rec "gen-unexpected-opt_out"
    (fn [] (let [seen (atom 0)
                 hook (atom {:name "failhook" :active true :version "0.0.1" :_options nil
                             "init" (fn [_ctx _opts] nil)
                             "PreSpec" (fn [_ctx] (throw (RuntimeException. "opt_out hook failed")))
                             "PreUnexpected" (fn [_ctx] (swap! seen inc))})
                 ent (api/opt_out (api/make-sdk (vs/jm "feature" (vs/jm "test" (vs/jm "active" true)) "extend" [hook])) nil)
                 err (try (e-opt_out/list ent (vs/jm) nil) nil (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "hook failed"))
                        "the hook's failure is raised")
             (t/is-true (pos? @seen) "PreUnexpected did not fire")
             (let [fired @seen]
               (t/is-nil (e-opt_out/list ent (vs/jm) (vs/jm "throw" false)) "throw false should resolve to nothing")
               (t/is-true (> @seen fired) "PreUnexpected did not fire under throw false")))))
  (t/run-check rec "gen-validate-opt_out"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-opt_out/list (api/opt_out client nil) (vs/jm "limit" "x") nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-opt_out_setting"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/opt_out_setting sdk nil)) "opt_out_setting accessor present"))))
  (t/run-check rec "gen-validate-opt_out_setting"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-opt_out_setting/load (api/opt_out_setting client nil) (vs/jm "brand" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-permission"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/permission sdk nil)) "permission accessor present"))))
  (t/run-check rec "gen-validate-permission"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-permission/load (api/permission client nil) (vs/jm "group_id" 1 "id" "x") nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-ping"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/ping sdk nil)) "ping accessor present"))))
  (t/run-check rec "gen-smoke-ping"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/ping sdk nil)]
             (let [items (e-ping/list ent (vs/jm) nil)]
               ;; list resolves to one entity per record.
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
  (t/run-check rec "gen-list-ping"
    (fn [] (let [seed (vs/jm "ping" (vs/jm "L1" (vs/jm "id" "L1" "name" "a")
                                                "L2" (vs/jm "id" "L2" "name" "b")))
                 items (e-ping/list (api/ping (api/test-sdk (vs/jm "entity" seed) nil) nil)
                                         (vs/jm) nil)]
             ;; list resolves to one entity per record; data-get reads the record.
             (t/is-eq (count items) 2 "list answers each seeded record")
             (t/is-true (every? (fn [item] (and (map? item) (vs/ismap ((:data-get item))))) items)
                        "each listed item is an entity carrying its record"))))
  (t/run-check rec "gen-stream-ping"
    (fn [] (let [seed (vs/jm "ping" (vs/jm "S1" (vs/jm "id" "S1" "name" "a")
                                                "S2" (vs/jm "id" "S2" "name" "b")
                                                "S3" (vs/jm "id" "S3" "name" "c")))]
             ;; Fallback (no streaming feature): materialised items.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   items (vec (e-ping/stream (api/ping sdk nil) "list" (vs/jm) nil))]
               (t/is-eq (count items) 3 "stream fallback yields materialised items")
               (t/is-true (vs/ismap (first items)) "stream yields bare record maps"))
             ;; signal cancels iteration between yields.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   n (atom 0) sig (fn [] (>= (swap! n inc) 2))
                   items (vec (e-ping/stream (api/ping sdk nil) "list" (vs/jm) (vs/jm "signal" sig)))]
               (t/is-eq (count items) 1 "stream signal stops after first yield"))
             ;; Streaming feature active: yields from the streaming iterator.
             (when (vs/getpath (config/make-config) "feature.streaming")
               (let [ssdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true))))]
                 (t/is-eq (count (vec (e-ping/stream (api/ping ssdk nil) "list" (vs/jm) nil))) 3
                          "stream (streaming active) yields all items"))
               (let [csdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true "chunkSize" 2))))
                     batches (vec (e-ping/stream (api/ping csdk nil) "list" (vs/jm) nil))]
                 (t/is-eq (count batches) 2 "stream chunkSize groups items into 2 batches"))))))
  (t/run-check rec "gen-stream-error-ping"
    (fn [] (let [offline (vs/jm "net" (vs/jm "offline" true))
                 err (try (vec (e-ping/stream (api/ping (api/test-sdk offline nil) nil) "list" (vs/jm) nil)) nil
                          (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "offline"))
                        "the transport failure raises from the stream")
             (t/is-eq (count (vec (e-ping/stream (api/ping (api/test-sdk offline nil) nil) "list" (vs/jm)
                                                 (vs/jm "ctrl" (vs/jm "throw" false)))))
                      0 "throw false ends the stream quietly")
             (when (vs/getpath (config/make-config) "feature.rbac")
               (let [denied (api/test-sdk nil (vs/jm "feature" (vs/jm "rbac" (vs/jm "active" true "deny" true))))]
                 (t/is-throws (fn [] (vec (e-ping/stream (api/ping denied nil) "list" (vs/jm) nil)))
                              "rbac_denied" "the rbac denial raises from the stream"))))))
  (t/run-check rec "gen-stream-ctrl-ping"
    (fn [] (let [explain (vs/jm)
                 ctrl (vs/jm "explain" explain)]
             (vec (e-ping/stream (api/ping (api/test-sdk nil nil) nil) "list" (vs/jm) (vs/jm "ctrl" ctrl)))
             (t/is-eq (vec (vs/keysof ctrl)) ["explain"] "the stream changed the caller's ctrl")
             (t/is-true (identical? explain (vs/getprop ctrl "explain")) "the caller's explain record is not its own")
             (t/is-true (pos? (count (vs/keysof explain))) "the caller's explain record was not filled"))))
  (t/run-check rec "gen-unexpected-ping"
    (fn [] (let [seen (atom 0)
                 hook (atom {:name "failhook" :active true :version "0.0.1" :_options nil
                             "init" (fn [_ctx _opts] nil)
                             "PreSpec" (fn [_ctx] (throw (RuntimeException. "ping hook failed")))
                             "PreUnexpected" (fn [_ctx] (swap! seen inc))})
                 ent (api/ping (api/make-sdk (vs/jm "feature" (vs/jm "test" (vs/jm "active" true)) "extend" [hook])) nil)
                 err (try (e-ping/list ent (vs/jm) nil) nil (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "hook failed"))
                        "the hook's failure is raised")
             (t/is-true (pos? @seen) "PreUnexpected did not fire")
             (let [fired @seen]
               (t/is-nil (e-ping/list ent (vs/jm) (vs/jm "throw" false)) "throw false should resolve to nothing")
               (t/is-true (> @seen fired) "PreUnexpected did not fire under throw false")))))
  (t/run-check rec "gen-validate-ping"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-ping/list (api/ping client nil) (vs/jm "authorized" "x") nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-profile"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/profile sdk nil)) "profile accessor present"))))
  (t/run-check rec "gen-smoke-profile"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/profile sdk nil)]
             (let [items (e-profile/list ent (vs/jm) nil)]
               ;; list resolves to one entity per record.
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
  (t/run-check rec "gen-list-profile"
    (fn [] (let [seed (vs/jm "profile" (vs/jm "L1" (vs/jm "id" "L1" "name" "a")
                                                "L2" (vs/jm "id" "L2" "name" "b")))
                 items (e-profile/list (api/profile (api/test-sdk (vs/jm "entity" seed) nil) nil)
                                         (vs/jm) nil)]
             ;; list resolves to one entity per record; data-get reads the record.
             (t/is-eq (count items) 2 "list answers each seeded record")
             (t/is-true (every? (fn [item] (and (map? item) (vs/ismap ((:data-get item))))) items)
                        "each listed item is an entity carrying its record"))))
  (t/run-check rec "gen-stream-profile"
    (fn [] (let [seed (vs/jm "profile" (vs/jm "S1" (vs/jm "id" "S1" "name" "a")
                                                "S2" (vs/jm "id" "S2" "name" "b")
                                                "S3" (vs/jm "id" "S3" "name" "c")))]
             ;; Fallback (no streaming feature): materialised items.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   items (vec (e-profile/stream (api/profile sdk nil) "list" (vs/jm) nil))]
               (t/is-eq (count items) 3 "stream fallback yields materialised items")
               (t/is-true (vs/ismap (first items)) "stream yields bare record maps"))
             ;; signal cancels iteration between yields.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   n (atom 0) sig (fn [] (>= (swap! n inc) 2))
                   items (vec (e-profile/stream (api/profile sdk nil) "list" (vs/jm) (vs/jm "signal" sig)))]
               (t/is-eq (count items) 1 "stream signal stops after first yield"))
             ;; Streaming feature active: yields from the streaming iterator.
             (when (vs/getpath (config/make-config) "feature.streaming")
               (let [ssdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true))))]
                 (t/is-eq (count (vec (e-profile/stream (api/profile ssdk nil) "list" (vs/jm) nil))) 3
                          "stream (streaming active) yields all items"))
               (let [csdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true "chunkSize" 2))))
                     batches (vec (e-profile/stream (api/profile csdk nil) "list" (vs/jm) nil))]
                 (t/is-eq (count batches) 2 "stream chunkSize groups items into 2 batches"))))))
  (t/run-check rec "gen-stream-error-profile"
    (fn [] (let [offline (vs/jm "net" (vs/jm "offline" true))
                 err (try (vec (e-profile/stream (api/profile (api/test-sdk offline nil) nil) "list" (vs/jm) nil)) nil
                          (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "offline"))
                        "the transport failure raises from the stream")
             (t/is-eq (count (vec (e-profile/stream (api/profile (api/test-sdk offline nil) nil) "list" (vs/jm)
                                                 (vs/jm "ctrl" (vs/jm "throw" false)))))
                      0 "throw false ends the stream quietly")
             (when (vs/getpath (config/make-config) "feature.rbac")
               (let [denied (api/test-sdk nil (vs/jm "feature" (vs/jm "rbac" (vs/jm "active" true "deny" true))))]
                 (t/is-throws (fn [] (vec (e-profile/stream (api/profile denied nil) "list" (vs/jm) nil)))
                              "rbac_denied" "the rbac denial raises from the stream"))))))
  (t/run-check rec "gen-stream-ctrl-profile"
    (fn [] (let [explain (vs/jm)
                 ctrl (vs/jm "explain" explain)]
             (vec (e-profile/stream (api/profile (api/test-sdk nil nil) nil) "list" (vs/jm) (vs/jm "ctrl" ctrl)))
             (t/is-eq (vec (vs/keysof ctrl)) ["explain"] "the stream changed the caller's ctrl")
             (t/is-true (identical? explain (vs/getprop ctrl "explain")) "the caller's explain record is not its own")
             (t/is-true (pos? (count (vs/keysof explain))) "the caller's explain record was not filled"))))
  (t/run-check rec "gen-unexpected-profile"
    (fn [] (let [seen (atom 0)
                 hook (atom {:name "failhook" :active true :version "0.0.1" :_options nil
                             "init" (fn [_ctx _opts] nil)
                             "PreSpec" (fn [_ctx] (throw (RuntimeException. "profile hook failed")))
                             "PreUnexpected" (fn [_ctx] (swap! seen inc))})
                 ent (api/profile (api/make-sdk (vs/jm "feature" (vs/jm "test" (vs/jm "active" true)) "extend" [hook])) nil)
                 err (try (e-profile/list ent (vs/jm) nil) nil (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "hook failed"))
                        "the hook's failure is raised")
             (t/is-true (pos? @seen) "PreUnexpected did not fire")
             (let [fired @seen]
               (t/is-nil (e-profile/list ent (vs/jm) (vs/jm "throw" false)) "throw false should resolve to nothing")
               (t/is-true (> @seen fired) "PreUnexpected did not fire under throw false")))))
  (t/run-check rec "gen-validate-profile"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-profile/list (api/profile client nil) (vs/jm "type" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-rcs"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/rcs sdk nil)) "rcs accessor present"))))
  (t/run-check rec "gen-smoke-rcs"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/rcs sdk nil)]
             (let [items (e-rcs/list ent (vs/jm) nil)]
               ;; list resolves to one entity per record.
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
  (t/run-check rec "gen-list-rcs"
    (fn [] (let [seed (vs/jm "rcs" (vs/jm "L1" (vs/jm "id" "L1" "name" "a")
                                                "L2" (vs/jm "id" "L2" "name" "b")))
                 items (e-rcs/list (api/rcs (api/test-sdk (vs/jm "entity" seed) nil) nil)
                                         (vs/jm) nil)]
             ;; list resolves to one entity per record; data-get reads the record.
             (t/is-eq (count items) 2 "list answers each seeded record")
             (t/is-true (every? (fn [item] (and (map? item) (vs/ismap ((:data-get item))))) items)
                        "each listed item is an entity carrying its record"))))
  (t/run-check rec "gen-stream-rcs"
    (fn [] (let [seed (vs/jm "rcs" (vs/jm "S1" (vs/jm "id" "S1" "name" "a")
                                                "S2" (vs/jm "id" "S2" "name" "b")
                                                "S3" (vs/jm "id" "S3" "name" "c")))]
             ;; Fallback (no streaming feature): materialised items.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   items (vec (e-rcs/stream (api/rcs sdk nil) "list" (vs/jm) nil))]
               (t/is-eq (count items) 3 "stream fallback yields materialised items")
               (t/is-true (vs/ismap (first items)) "stream yields bare record maps"))
             ;; signal cancels iteration between yields.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   n (atom 0) sig (fn [] (>= (swap! n inc) 2))
                   items (vec (e-rcs/stream (api/rcs sdk nil) "list" (vs/jm) (vs/jm "signal" sig)))]
               (t/is-eq (count items) 1 "stream signal stops after first yield"))
             ;; Streaming feature active: yields from the streaming iterator.
             (when (vs/getpath (config/make-config) "feature.streaming")
               (let [ssdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true))))]
                 (t/is-eq (count (vec (e-rcs/stream (api/rcs ssdk nil) "list" (vs/jm) nil))) 3
                          "stream (streaming active) yields all items"))
               (let [csdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true "chunkSize" 2))))
                     batches (vec (e-rcs/stream (api/rcs csdk nil) "list" (vs/jm) nil))]
                 (t/is-eq (count batches) 2 "stream chunkSize groups items into 2 batches"))))))
  (t/run-check rec "gen-stream-error-rcs"
    (fn [] (let [offline (vs/jm "net" (vs/jm "offline" true))
                 err (try (vec (e-rcs/stream (api/rcs (api/test-sdk offline nil) nil) "list" (vs/jm) nil)) nil
                          (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "offline"))
                        "the transport failure raises from the stream")
             (t/is-eq (count (vec (e-rcs/stream (api/rcs (api/test-sdk offline nil) nil) "list" (vs/jm)
                                                 (vs/jm "ctrl" (vs/jm "throw" false)))))
                      0 "throw false ends the stream quietly")
             (when (vs/getpath (config/make-config) "feature.rbac")
               (let [denied (api/test-sdk nil (vs/jm "feature" (vs/jm "rbac" (vs/jm "active" true "deny" true))))]
                 (t/is-throws (fn [] (vec (e-rcs/stream (api/rcs denied nil) "list" (vs/jm) nil)))
                              "rbac_denied" "the rbac denial raises from the stream"))))))
  (t/run-check rec "gen-stream-ctrl-rcs"
    (fn [] (let [explain (vs/jm)
                 ctrl (vs/jm "explain" explain)]
             (vec (e-rcs/stream (api/rcs (api/test-sdk nil nil) nil) "list" (vs/jm) (vs/jm "ctrl" ctrl)))
             (t/is-eq (vec (vs/keysof ctrl)) ["explain"] "the stream changed the caller's ctrl")
             (t/is-true (identical? explain (vs/getprop ctrl "explain")) "the caller's explain record is not its own")
             (t/is-true (pos? (count (vs/keysof explain))) "the caller's explain record was not filled"))))
  (t/run-check rec "gen-unexpected-rcs"
    (fn [] (let [seen (atom 0)
                 hook (atom {:name "failhook" :active true :version "0.0.1" :_options nil
                             "init" (fn [_ctx _opts] nil)
                             "PreSpec" (fn [_ctx] (throw (RuntimeException. "rcs hook failed")))
                             "PreUnexpected" (fn [_ctx] (swap! seen inc))})
                 ent (api/rcs (api/make-sdk (vs/jm "feature" (vs/jm "test" (vs/jm "active" true)) "extend" [hook])) nil)
                 err (try (e-rcs/list ent (vs/jm) nil) nil (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "hook failed"))
                        "the hook's failure is raised")
             (t/is-true (pos? @seen) "PreUnexpected did not fire")
             (let [fired @seen]
               (t/is-nil (e-rcs/list ent (vs/jm) (vs/jm "throw" false)) "throw false should resolve to nothing")
               (t/is-true (> @seen fired) "PreUnexpected did not fire under throw false")))))
  (t/run-check rec "gen-exists-sendername"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/sendername sdk nil)) "sendername accessor present"))))
  (t/run-check rec "gen-smoke-sendername"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/sendername sdk nil)]
             (let [res (e-sendername/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             (let [items (e-sendername/list ent (vs/jm) nil)]
               ;; list resolves to one entity per record.
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
  (t/run-check rec "gen-list-sendername"
    (fn [] (let [seed (vs/jm "sendername" (vs/jm "L1" (vs/jm "id" "L1" "name" "a")
                                                "L2" (vs/jm "id" "L2" "name" "b")))
                 items (e-sendername/list (api/sendername (api/test-sdk (vs/jm "entity" seed) nil) nil)
                                         (vs/jm) nil)]
             ;; list resolves to one entity per record; data-get reads the record.
             (t/is-eq (count items) 2 "list answers each seeded record")
             (t/is-true (every? (fn [item] (and (map? item) (vs/ismap ((:data-get item))))) items)
                        "each listed item is an entity carrying its record"))))
  (t/run-check rec "gen-stream-sendername"
    (fn [] (let [seed (vs/jm "sendername" (vs/jm "S1" (vs/jm "id" "S1" "name" "a")
                                                "S2" (vs/jm "id" "S2" "name" "b")
                                                "S3" (vs/jm "id" "S3" "name" "c")))]
             ;; Fallback (no streaming feature): materialised items.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   items (vec (e-sendername/stream (api/sendername sdk nil) "list" (vs/jm) nil))]
               (t/is-eq (count items) 3 "stream fallback yields materialised items")
               (t/is-true (vs/ismap (first items)) "stream yields bare record maps"))
             ;; signal cancels iteration between yields.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   n (atom 0) sig (fn [] (>= (swap! n inc) 2))
                   items (vec (e-sendername/stream (api/sendername sdk nil) "list" (vs/jm) (vs/jm "signal" sig)))]
               (t/is-eq (count items) 1 "stream signal stops after first yield"))
             ;; Streaming feature active: yields from the streaming iterator.
             (when (vs/getpath (config/make-config) "feature.streaming")
               (let [ssdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true))))]
                 (t/is-eq (count (vec (e-sendername/stream (api/sendername ssdk nil) "list" (vs/jm) nil))) 3
                          "stream (streaming active) yields all items"))
               (let [csdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true "chunkSize" 2))))
                     batches (vec (e-sendername/stream (api/sendername csdk nil) "list" (vs/jm) nil))]
                 (t/is-eq (count batches) 2 "stream chunkSize groups items into 2 batches"))))))
  (t/run-check rec "gen-stream-error-sendername"
    (fn [] (let [offline (vs/jm "net" (vs/jm "offline" true))
                 err (try (vec (e-sendername/stream (api/sendername (api/test-sdk offline nil) nil) "list" (vs/jm) nil)) nil
                          (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "offline"))
                        "the transport failure raises from the stream")
             (t/is-eq (count (vec (e-sendername/stream (api/sendername (api/test-sdk offline nil) nil) "list" (vs/jm)
                                                 (vs/jm "ctrl" (vs/jm "throw" false)))))
                      0 "throw false ends the stream quietly")
             (when (vs/getpath (config/make-config) "feature.rbac")
               (let [denied (api/test-sdk nil (vs/jm "feature" (vs/jm "rbac" (vs/jm "active" true "deny" true))))]
                 (t/is-throws (fn [] (vec (e-sendername/stream (api/sendername denied nil) "list" (vs/jm) nil)))
                              "rbac_denied" "the rbac denial raises from the stream"))))))
  (t/run-check rec "gen-stream-ctrl-sendername"
    (fn [] (let [explain (vs/jm)
                 ctrl (vs/jm "explain" explain)]
             (vec (e-sendername/stream (api/sendername (api/test-sdk nil nil) nil) "list" (vs/jm) (vs/jm "ctrl" ctrl)))
             (t/is-eq (vec (vs/keysof ctrl)) ["explain"] "the stream changed the caller's ctrl")
             (t/is-true (identical? explain (vs/getprop ctrl "explain")) "the caller's explain record is not its own")
             (t/is-true (pos? (count (vs/keysof explain))) "the caller's explain record was not filled"))))
  (t/run-check rec "gen-unexpected-sendername"
    (fn [] (let [seen (atom 0)
                 hook (atom {:name "failhook" :active true :version "0.0.1" :_options nil
                             "init" (fn [_ctx _opts] nil)
                             "PreSpec" (fn [_ctx] (throw (RuntimeException. "sendername hook failed")))
                             "PreUnexpected" (fn [_ctx] (swap! seen inc))})
                 ent (api/sendername (api/make-sdk (vs/jm "feature" (vs/jm "test" (vs/jm "active" true)) "extend" [hook])) nil)
                 err (try (e-sendername/list ent (vs/jm) nil) nil (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "hook failed"))
                        "the hook's failure is raised")
             (t/is-true (pos? @seen) "PreUnexpected did not fire")
             (let [fired @seen]
               (t/is-nil (e-sendername/list ent (vs/jm) (vs/jm "throw" false)) "throw false should resolve to nothing")
               (t/is-true (> @seen fired) "PreUnexpected did not fire under throw false")))))
  (t/run-check rec "gen-validate-sendername"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-sendername/list (api/sendername client nil) (vs/jm "created_at" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-sendername_statement"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/sendername_statement sdk nil)) "sendername_statement accessor present"))))
  (t/run-check rec "gen-smoke-sendername_statement"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/sendername_statement sdk nil)]
             (let [items (e-sendername_statement/list ent (vs/jm) nil)]
               ;; list resolves to one entity per record.
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
  (t/run-check rec "gen-list-sendername_statement"
    (fn [] (let [seed (vs/jm "sendername_statement" (vs/jm "L1" (vs/jm "id" "L1" "name" "a")
                                                "L2" (vs/jm "id" "L2" "name" "b")))
                 items (e-sendername_statement/list (api/sendername_statement (api/test-sdk (vs/jm "entity" seed) nil) nil)
                                         (vs/jm) nil)]
             ;; list resolves to one entity per record; data-get reads the record.
             (t/is-eq (count items) 2 "list answers each seeded record")
             (t/is-true (every? (fn [item] (and (map? item) (vs/ismap ((:data-get item))))) items)
                        "each listed item is an entity carrying its record"))))
  (t/run-check rec "gen-stream-sendername_statement"
    (fn [] (let [seed (vs/jm "sendername_statement" (vs/jm "S1" (vs/jm "id" "S1" "name" "a")
                                                "S2" (vs/jm "id" "S2" "name" "b")
                                                "S3" (vs/jm "id" "S3" "name" "c")))]
             ;; Fallback (no streaming feature): materialised items.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   items (vec (e-sendername_statement/stream (api/sendername_statement sdk nil) "list" (vs/jm) nil))]
               (t/is-eq (count items) 3 "stream fallback yields materialised items")
               (t/is-true (vs/ismap (first items)) "stream yields bare record maps"))
             ;; signal cancels iteration between yields.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   n (atom 0) sig (fn [] (>= (swap! n inc) 2))
                   items (vec (e-sendername_statement/stream (api/sendername_statement sdk nil) "list" (vs/jm) (vs/jm "signal" sig)))]
               (t/is-eq (count items) 1 "stream signal stops after first yield"))
             ;; Streaming feature active: yields from the streaming iterator.
             (when (vs/getpath (config/make-config) "feature.streaming")
               (let [ssdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true))))]
                 (t/is-eq (count (vec (e-sendername_statement/stream (api/sendername_statement ssdk nil) "list" (vs/jm) nil))) 3
                          "stream (streaming active) yields all items"))
               (let [csdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true "chunkSize" 2))))
                     batches (vec (e-sendername_statement/stream (api/sendername_statement csdk nil) "list" (vs/jm) nil))]
                 (t/is-eq (count batches) 2 "stream chunkSize groups items into 2 batches"))))))
  (t/run-check rec "gen-stream-error-sendername_statement"
    (fn [] (let [offline (vs/jm "net" (vs/jm "offline" true))
                 err (try (vec (e-sendername_statement/stream (api/sendername_statement (api/test-sdk offline nil) nil) "list" (vs/jm) nil)) nil
                          (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "offline"))
                        "the transport failure raises from the stream")
             (t/is-eq (count (vec (e-sendername_statement/stream (api/sendername_statement (api/test-sdk offline nil) nil) "list" (vs/jm)
                                                 (vs/jm "ctrl" (vs/jm "throw" false)))))
                      0 "throw false ends the stream quietly")
             (when (vs/getpath (config/make-config) "feature.rbac")
               (let [denied (api/test-sdk nil (vs/jm "feature" (vs/jm "rbac" (vs/jm "active" true "deny" true))))]
                 (t/is-throws (fn [] (vec (e-sendername_statement/stream (api/sendername_statement denied nil) "list" (vs/jm) nil)))
                              "rbac_denied" "the rbac denial raises from the stream"))))))
  (t/run-check rec "gen-stream-ctrl-sendername_statement"
    (fn [] (let [explain (vs/jm)
                 ctrl (vs/jm "explain" explain)]
             (vec (e-sendername_statement/stream (api/sendername_statement (api/test-sdk nil nil) nil) "list" (vs/jm) (vs/jm "ctrl" ctrl)))
             (t/is-eq (vec (vs/keysof ctrl)) ["explain"] "the stream changed the caller's ctrl")
             (t/is-true (identical? explain (vs/getprop ctrl "explain")) "the caller's explain record is not its own")
             (t/is-true (pos? (count (vs/keysof explain))) "the caller's explain record was not filled"))))
  (t/run-check rec "gen-unexpected-sendername_statement"
    (fn [] (let [seen (atom 0)
                 hook (atom {:name "failhook" :active true :version "0.0.1" :_options nil
                             "init" (fn [_ctx _opts] nil)
                             "PreSpec" (fn [_ctx] (throw (RuntimeException. "sendername_statement hook failed")))
                             "PreUnexpected" (fn [_ctx] (swap! seen inc))})
                 ent (api/sendername_statement (api/make-sdk (vs/jm "feature" (vs/jm "test" (vs/jm "active" true)) "extend" [hook])) nil)
                 err (try (e-sendername_statement/list ent (vs/jm) nil) nil (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "hook failed"))
                        "the hook's failure is raised")
             (t/is-true (pos? @seen) "PreUnexpected did not fire")
             (let [fired @seen]
               (t/is-nil (e-sendername_statement/list ent (vs/jm) (vs/jm "throw" false)) "throw false should resolve to nothing")
               (t/is-true (> @seen fired) "PreUnexpected did not fire under throw false")))))
  (t/run-check rec "gen-validate-sendername_statement"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-sendername_statement/list (api/sendername_statement client nil) (vs/jm "content" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-sent_rcs_message"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/sent_rcs_message sdk nil)) "sent_rcs_message accessor present"))))
  (t/run-check rec "gen-smoke-sent_rcs_message"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/sent_rcs_message sdk nil)]
             (let [res (e-sent_rcs_message/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             )))
  (t/run-check rec "gen-validate-sent_rcs_message"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-sent_rcs_message/create (api/sent_rcs_message client nil) (vs/jm "phone_number" 1 "sender" "x") nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-shipment_country_volume"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/shipment_country_volume sdk nil)) "shipment_country_volume accessor present"))))
  (t/run-check rec "gen-smoke-shipment_country_volume"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/shipment_country_volume sdk nil)]
             (let [items (e-shipment_country_volume/list ent (vs/jm) nil)]
               ;; list resolves to one entity per record.
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
  (t/run-check rec "gen-list-shipment_country_volume"
    (fn [] (let [seed (vs/jm "shipment_country_volume" (vs/jm "L1" (vs/jm "id" "L1" "name" "a")
                                                "L2" (vs/jm "id" "L2" "name" "b")))
                 items (e-shipment_country_volume/list (api/shipment_country_volume (api/test-sdk (vs/jm "entity" seed) nil) nil)
                                         (vs/jm) nil)]
             ;; list resolves to one entity per record; data-get reads the record.
             (t/is-eq (count items) 2 "list answers each seeded record")
             (t/is-true (every? (fn [item] (and (map? item) (vs/ismap ((:data-get item))))) items)
                        "each listed item is an entity carrying its record"))))
  (t/run-check rec "gen-stream-shipment_country_volume"
    (fn [] (let [seed (vs/jm "shipment_country_volume" (vs/jm "S1" (vs/jm "id" "S1" "name" "a")
                                                "S2" (vs/jm "id" "S2" "name" "b")
                                                "S3" (vs/jm "id" "S3" "name" "c")))]
             ;; Fallback (no streaming feature): materialised items.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   items (vec (e-shipment_country_volume/stream (api/shipment_country_volume sdk nil) "list" (vs/jm) nil))]
               (t/is-eq (count items) 3 "stream fallback yields materialised items")
               (t/is-true (vs/ismap (first items)) "stream yields bare record maps"))
             ;; signal cancels iteration between yields.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   n (atom 0) sig (fn [] (>= (swap! n inc) 2))
                   items (vec (e-shipment_country_volume/stream (api/shipment_country_volume sdk nil) "list" (vs/jm) (vs/jm "signal" sig)))]
               (t/is-eq (count items) 1 "stream signal stops after first yield"))
             ;; Streaming feature active: yields from the streaming iterator.
             (when (vs/getpath (config/make-config) "feature.streaming")
               (let [ssdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true))))]
                 (t/is-eq (count (vec (e-shipment_country_volume/stream (api/shipment_country_volume ssdk nil) "list" (vs/jm) nil))) 3
                          "stream (streaming active) yields all items"))
               (let [csdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true "chunkSize" 2))))
                     batches (vec (e-shipment_country_volume/stream (api/shipment_country_volume csdk nil) "list" (vs/jm) nil))]
                 (t/is-eq (count batches) 2 "stream chunkSize groups items into 2 batches"))))))
  (t/run-check rec "gen-stream-error-shipment_country_volume"
    (fn [] (let [offline (vs/jm "net" (vs/jm "offline" true))
                 err (try (vec (e-shipment_country_volume/stream (api/shipment_country_volume (api/test-sdk offline nil) nil) "list" (vs/jm) nil)) nil
                          (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "offline"))
                        "the transport failure raises from the stream")
             (t/is-eq (count (vec (e-shipment_country_volume/stream (api/shipment_country_volume (api/test-sdk offline nil) nil) "list" (vs/jm)
                                                 (vs/jm "ctrl" (vs/jm "throw" false)))))
                      0 "throw false ends the stream quietly")
             (when (vs/getpath (config/make-config) "feature.rbac")
               (let [denied (api/test-sdk nil (vs/jm "feature" (vs/jm "rbac" (vs/jm "active" true "deny" true))))]
                 (t/is-throws (fn [] (vec (e-shipment_country_volume/stream (api/shipment_country_volume denied nil) "list" (vs/jm) nil)))
                              "rbac_denied" "the rbac denial raises from the stream"))))))
  (t/run-check rec "gen-stream-ctrl-shipment_country_volume"
    (fn [] (let [explain (vs/jm)
                 ctrl (vs/jm "explain" explain)]
             (vec (e-shipment_country_volume/stream (api/shipment_country_volume (api/test-sdk nil nil) nil) "list" (vs/jm) (vs/jm "ctrl" ctrl)))
             (t/is-eq (vec (vs/keysof ctrl)) ["explain"] "the stream changed the caller's ctrl")
             (t/is-true (identical? explain (vs/getprop ctrl "explain")) "the caller's explain record is not its own")
             (t/is-true (pos? (count (vs/keysof explain))) "the caller's explain record was not filled"))))
  (t/run-check rec "gen-unexpected-shipment_country_volume"
    (fn [] (let [seen (atom 0)
                 hook (atom {:name "failhook" :active true :version "0.0.1" :_options nil
                             "init" (fn [_ctx _opts] nil)
                             "PreSpec" (fn [_ctx] (throw (RuntimeException. "shipment_country_volume hook failed")))
                             "PreUnexpected" (fn [_ctx] (swap! seen inc))})
                 ent (api/shipment_country_volume (api/make-sdk (vs/jm "feature" (vs/jm "test" (vs/jm "active" true)) "extend" [hook])) nil)
                 err (try (e-shipment_country_volume/list ent (vs/jm) nil) nil (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "hook failed"))
                        "the hook's failure is raised")
             (t/is-true (pos? @seen) "PreUnexpected did not fire")
             (let [fired @seen]
               (t/is-nil (e-shipment_country_volume/list ent (vs/jm) (vs/jm "throw" false)) "throw false should resolve to nothing")
               (t/is-true (> @seen fired) "PreUnexpected did not fire under throw false")))))
  (t/run-check rec "gen-validate-shipment_country_volume"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-shipment_country_volume/list (api/shipment_country_volume client nil) (vs/jm "month" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-short_url"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/short_url sdk nil)) "short_url accessor present"))))
  (t/run-check rec "gen-smoke-short_url"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/short_url sdk nil)]
             (let [res (e-short_url/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             (let [items (e-short_url/list ent (vs/jm) nil)]
               ;; list resolves to one entity per record.
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
  (t/run-check rec "gen-list-short_url"
    (fn [] (let [seed (vs/jm "short_url" (vs/jm "L1" (vs/jm "id" "L1" "name" "a")
                                                "L2" (vs/jm "id" "L2" "name" "b")))
                 items (e-short_url/list (api/short_url (api/test-sdk (vs/jm "entity" seed) nil) nil)
                                         (vs/jm) nil)]
             ;; list resolves to one entity per record; data-get reads the record.
             (t/is-eq (count items) 2 "list answers each seeded record")
             (t/is-true (every? (fn [item] (and (map? item) (vs/ismap ((:data-get item))))) items)
                        "each listed item is an entity carrying its record"))))
  (t/run-check rec "gen-stream-short_url"
    (fn [] (let [seed (vs/jm "short_url" (vs/jm "S1" (vs/jm "id" "S1" "name" "a")
                                                "S2" (vs/jm "id" "S2" "name" "b")
                                                "S3" (vs/jm "id" "S3" "name" "c")))]
             ;; Fallback (no streaming feature): materialised items.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   items (vec (e-short_url/stream (api/short_url sdk nil) "list" (vs/jm) nil))]
               (t/is-eq (count items) 3 "stream fallback yields materialised items")
               (t/is-true (vs/ismap (first items)) "stream yields bare record maps"))
             ;; signal cancels iteration between yields.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   n (atom 0) sig (fn [] (>= (swap! n inc) 2))
                   items (vec (e-short_url/stream (api/short_url sdk nil) "list" (vs/jm) (vs/jm "signal" sig)))]
               (t/is-eq (count items) 1 "stream signal stops after first yield"))
             ;; Streaming feature active: yields from the streaming iterator.
             (when (vs/getpath (config/make-config) "feature.streaming")
               (let [ssdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true))))]
                 (t/is-eq (count (vec (e-short_url/stream (api/short_url ssdk nil) "list" (vs/jm) nil))) 3
                          "stream (streaming active) yields all items"))
               (let [csdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true "chunkSize" 2))))
                     batches (vec (e-short_url/stream (api/short_url csdk nil) "list" (vs/jm) nil))]
                 (t/is-eq (count batches) 2 "stream chunkSize groups items into 2 batches"))))))
  (t/run-check rec "gen-stream-error-short_url"
    (fn [] (let [offline (vs/jm "net" (vs/jm "offline" true))
                 err (try (vec (e-short_url/stream (api/short_url (api/test-sdk offline nil) nil) "list" (vs/jm) nil)) nil
                          (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "offline"))
                        "the transport failure raises from the stream")
             (t/is-eq (count (vec (e-short_url/stream (api/short_url (api/test-sdk offline nil) nil) "list" (vs/jm)
                                                 (vs/jm "ctrl" (vs/jm "throw" false)))))
                      0 "throw false ends the stream quietly")
             (when (vs/getpath (config/make-config) "feature.rbac")
               (let [denied (api/test-sdk nil (vs/jm "feature" (vs/jm "rbac" (vs/jm "active" true "deny" true))))]
                 (t/is-throws (fn [] (vec (e-short_url/stream (api/short_url denied nil) "list" (vs/jm) nil)))
                              "rbac_denied" "the rbac denial raises from the stream"))))))
  (t/run-check rec "gen-stream-ctrl-short_url"
    (fn [] (let [explain (vs/jm)
                 ctrl (vs/jm "explain" explain)]
             (vec (e-short_url/stream (api/short_url (api/test-sdk nil nil) nil) "list" (vs/jm) (vs/jm "ctrl" ctrl)))
             (t/is-eq (vec (vs/keysof ctrl)) ["explain"] "the stream changed the caller's ctrl")
             (t/is-true (identical? explain (vs/getprop ctrl "explain")) "the caller's explain record is not its own")
             (t/is-true (pos? (count (vs/keysof explain))) "the caller's explain record was not filled"))))
  (t/run-check rec "gen-unexpected-short_url"
    (fn [] (let [seen (atom 0)
                 hook (atom {:name "failhook" :active true :version "0.0.1" :_options nil
                             "init" (fn [_ctx _opts] nil)
                             "PreSpec" (fn [_ctx] (throw (RuntimeException. "short_url hook failed")))
                             "PreUnexpected" (fn [_ctx] (swap! seen inc))})
                 ent (api/short_url (api/make-sdk (vs/jm "feature" (vs/jm "test" (vs/jm "active" true)) "extend" [hook])) nil)
                 err (try (e-short_url/list ent (vs/jm) nil) nil (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "hook failed"))
                        "the hook's failure is raised")
             (t/is-true (pos? @seen) "PreUnexpected did not fire")
             (let [fired @seen]
               (t/is-nil (e-short_url/list ent (vs/jm) (vs/jm "throw" false)) "throw false should resolve to nothing")
               (t/is-true (> @seen fired) "PreUnexpected did not fire under throw false")))))
  (t/run-check rec "gen-validate-short_url"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-short_url/list (api/short_url client nil) (vs/jm "description" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-smsdo"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/smsdo sdk nil)) "smsdo accessor present"))))
  (t/run-check rec "gen-smoke-smsdo"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/smsdo sdk nil)]
             (let [res (e-smsdo/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             )))
  (t/run-check rec "gen-validate-smsdo"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-smsdo/create (api/smsdo client nil) (vs/jm "allow_duplicates" "x") nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-smssendername"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/smssendername sdk nil)) "smssendername accessor present"))))
  (t/run-check rec "gen-validate-smssendername"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-smssendername/create (api/smssendername client nil) (vs/jm "sender" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-smstemplate"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/smstemplate sdk nil)) "smstemplate accessor present"))))
  (t/run-check rec "gen-validate-smstemplate"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-smstemplate/remove (api/smstemplate client nil) (vs/jm "id" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-subuser"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/subuser sdk nil)) "subuser accessor present"))))
  (t/run-check rec "gen-smoke-subuser"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/subuser sdk nil)]
             (let [res (e-subuser/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             (let [items (e-subuser/list ent (vs/jm) nil)]
               ;; list resolves to one entity per record.
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
  (t/run-check rec "gen-list-subuser"
    (fn [] (let [seed (vs/jm "subuser" (vs/jm "L1" (vs/jm "id" "L1" "name" "a")
                                                "L2" (vs/jm "id" "L2" "name" "b")))
                 items (e-subuser/list (api/subuser (api/test-sdk (vs/jm "entity" seed) nil) nil)
                                         (vs/jm) nil)]
             ;; list resolves to one entity per record; data-get reads the record.
             (t/is-eq (count items) 2 "list answers each seeded record")
             (t/is-true (every? (fn [item] (and (map? item) (vs/ismap ((:data-get item))))) items)
                        "each listed item is an entity carrying its record"))))
  (t/run-check rec "gen-stream-subuser"
    (fn [] (let [seed (vs/jm "subuser" (vs/jm "S1" (vs/jm "id" "S1" "name" "a")
                                                "S2" (vs/jm "id" "S2" "name" "b")
                                                "S3" (vs/jm "id" "S3" "name" "c")))]
             ;; Fallback (no streaming feature): materialised items.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   items (vec (e-subuser/stream (api/subuser sdk nil) "list" (vs/jm) nil))]
               (t/is-eq (count items) 3 "stream fallback yields materialised items")
               (t/is-true (vs/ismap (first items)) "stream yields bare record maps"))
             ;; signal cancels iteration between yields.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   n (atom 0) sig (fn [] (>= (swap! n inc) 2))
                   items (vec (e-subuser/stream (api/subuser sdk nil) "list" (vs/jm) (vs/jm "signal" sig)))]
               (t/is-eq (count items) 1 "stream signal stops after first yield"))
             ;; Streaming feature active: yields from the streaming iterator.
             (when (vs/getpath (config/make-config) "feature.streaming")
               (let [ssdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true))))]
                 (t/is-eq (count (vec (e-subuser/stream (api/subuser ssdk nil) "list" (vs/jm) nil))) 3
                          "stream (streaming active) yields all items"))
               (let [csdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true "chunkSize" 2))))
                     batches (vec (e-subuser/stream (api/subuser csdk nil) "list" (vs/jm) nil))]
                 (t/is-eq (count batches) 2 "stream chunkSize groups items into 2 batches"))))))
  (t/run-check rec "gen-stream-error-subuser"
    (fn [] (let [offline (vs/jm "net" (vs/jm "offline" true))
                 err (try (vec (e-subuser/stream (api/subuser (api/test-sdk offline nil) nil) "list" (vs/jm) nil)) nil
                          (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "offline"))
                        "the transport failure raises from the stream")
             (t/is-eq (count (vec (e-subuser/stream (api/subuser (api/test-sdk offline nil) nil) "list" (vs/jm)
                                                 (vs/jm "ctrl" (vs/jm "throw" false)))))
                      0 "throw false ends the stream quietly")
             (when (vs/getpath (config/make-config) "feature.rbac")
               (let [denied (api/test-sdk nil (vs/jm "feature" (vs/jm "rbac" (vs/jm "active" true "deny" true))))]
                 (t/is-throws (fn [] (vec (e-subuser/stream (api/subuser denied nil) "list" (vs/jm) nil)))
                              "rbac_denied" "the rbac denial raises from the stream"))))))
  (t/run-check rec "gen-stream-ctrl-subuser"
    (fn [] (let [explain (vs/jm)
                 ctrl (vs/jm "explain" explain)]
             (vec (e-subuser/stream (api/subuser (api/test-sdk nil nil) nil) "list" (vs/jm) (vs/jm "ctrl" ctrl)))
             (t/is-eq (vec (vs/keysof ctrl)) ["explain"] "the stream changed the caller's ctrl")
             (t/is-true (identical? explain (vs/getprop ctrl "explain")) "the caller's explain record is not its own")
             (t/is-true (pos? (count (vs/keysof explain))) "the caller's explain record was not filled"))))
  (t/run-check rec "gen-unexpected-subuser"
    (fn [] (let [seen (atom 0)
                 hook (atom {:name "failhook" :active true :version "0.0.1" :_options nil
                             "init" (fn [_ctx _opts] nil)
                             "PreSpec" (fn [_ctx] (throw (RuntimeException. "subuser hook failed")))
                             "PreUnexpected" (fn [_ctx] (swap! seen inc))})
                 ent (api/subuser (api/make-sdk (vs/jm "feature" (vs/jm "test" (vs/jm "active" true)) "extend" [hook])) nil)
                 err (try (e-subuser/list ent (vs/jm) nil) nil (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "hook failed"))
                        "the hook's failure is raised")
             (t/is-true (pos? @seen) "PreUnexpected did not fire")
             (let [fired @seen]
               (t/is-nil (e-subuser/list ent (vs/jm) (vs/jm "throw" false)) "throw false should resolve to nothing")
               (t/is-true (> @seen fired) "PreUnexpected did not fire under throw false")))))
  (t/run-check rec "gen-validate-subuser"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-subuser/list (api/subuser client nil) (vs/jm "q" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-template"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/template sdk nil)) "template accessor present"))))
  (t/run-check rec "gen-smoke-template"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/template sdk nil)]
             (let [res (e-template/create ent (vs/jm "name" "smoke") nil)
                   rec (if (map? res) ((:data-get res)) res)]
               ;; create resolves to the ENTITY; the record is data-get.
               (t/is-true (vs/ismap rec) "create resolves to an entity carrying a record")
               (t/is-true (some? (vs/getprop rec "id")) "created record has an id"))
             (let [items (e-template/list ent (vs/jm) nil)]
               ;; list resolves to one entity per record.
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
  (t/run-check rec "gen-list-template"
    (fn [] (let [seed (vs/jm "template" (vs/jm "L1" (vs/jm "id" "L1" "name" "a")
                                                "L2" (vs/jm "id" "L2" "name" "b")))
                 items (e-template/list (api/template (api/test-sdk (vs/jm "entity" seed) nil) nil)
                                         (vs/jm) nil)]
             ;; list resolves to one entity per record; data-get reads the record.
             (t/is-eq (count items) 2 "list answers each seeded record")
             (t/is-true (every? (fn [item] (and (map? item) (vs/ismap ((:data-get item))))) items)
                        "each listed item is an entity carrying its record"))))
  (t/run-check rec "gen-stream-template"
    (fn [] (let [seed (vs/jm "template" (vs/jm "S1" (vs/jm "id" "S1" "name" "a")
                                                "S2" (vs/jm "id" "S2" "name" "b")
                                                "S3" (vs/jm "id" "S3" "name" "c")))]
             ;; Fallback (no streaming feature): materialised items.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   items (vec (e-template/stream (api/template sdk nil) "list" (vs/jm) nil))]
               (t/is-eq (count items) 3 "stream fallback yields materialised items")
               (t/is-true (vs/ismap (first items)) "stream yields bare record maps"))
             ;; signal cancels iteration between yields.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   n (atom 0) sig (fn [] (>= (swap! n inc) 2))
                   items (vec (e-template/stream (api/template sdk nil) "list" (vs/jm) (vs/jm "signal" sig)))]
               (t/is-eq (count items) 1 "stream signal stops after first yield"))
             ;; Streaming feature active: yields from the streaming iterator.
             (when (vs/getpath (config/make-config) "feature.streaming")
               (let [ssdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true))))]
                 (t/is-eq (count (vec (e-template/stream (api/template ssdk nil) "list" (vs/jm) nil))) 3
                          "stream (streaming active) yields all items"))
               (let [csdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true "chunkSize" 2))))
                     batches (vec (e-template/stream (api/template csdk nil) "list" (vs/jm) nil))]
                 (t/is-eq (count batches) 2 "stream chunkSize groups items into 2 batches"))))))
  (t/run-check rec "gen-stream-error-template"
    (fn [] (let [offline (vs/jm "net" (vs/jm "offline" true))
                 err (try (vec (e-template/stream (api/template (api/test-sdk offline nil) nil) "list" (vs/jm) nil)) nil
                          (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "offline"))
                        "the transport failure raises from the stream")
             (t/is-eq (count (vec (e-template/stream (api/template (api/test-sdk offline nil) nil) "list" (vs/jm)
                                                 (vs/jm "ctrl" (vs/jm "throw" false)))))
                      0 "throw false ends the stream quietly")
             (when (vs/getpath (config/make-config) "feature.rbac")
               (let [denied (api/test-sdk nil (vs/jm "feature" (vs/jm "rbac" (vs/jm "active" true "deny" true))))]
                 (t/is-throws (fn [] (vec (e-template/stream (api/template denied nil) "list" (vs/jm) nil)))
                              "rbac_denied" "the rbac denial raises from the stream"))))))
  (t/run-check rec "gen-stream-ctrl-template"
    (fn [] (let [explain (vs/jm)
                 ctrl (vs/jm "explain" explain)]
             (vec (e-template/stream (api/template (api/test-sdk nil nil) nil) "list" (vs/jm) (vs/jm "ctrl" ctrl)))
             (t/is-eq (vec (vs/keysof ctrl)) ["explain"] "the stream changed the caller's ctrl")
             (t/is-true (identical? explain (vs/getprop ctrl "explain")) "the caller's explain record is not its own")
             (t/is-true (pos? (count (vs/keysof explain))) "the caller's explain record was not filled"))))
  (t/run-check rec "gen-unexpected-template"
    (fn [] (let [seen (atom 0)
                 hook (atom {:name "failhook" :active true :version "0.0.1" :_options nil
                             "init" (fn [_ctx _opts] nil)
                             "PreSpec" (fn [_ctx] (throw (RuntimeException. "template hook failed")))
                             "PreUnexpected" (fn [_ctx] (swap! seen inc))})
                 ent (api/template (api/make-sdk (vs/jm "feature" (vs/jm "test" (vs/jm "active" true)) "extend" [hook])) nil)
                 err (try (e-template/list ent (vs/jm) nil) nil (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "hook failed"))
                        "the hook's failure is raised")
             (t/is-true (pos? @seen) "PreUnexpected did not fire")
             (let [fired @seen]
               (t/is-nil (e-template/list ent (vs/jm) (vs/jm "throw" false)) "throw false should resolve to nothing")
               (t/is-true (> @seen fired) "PreUnexpected did not fire under throw false")))))
  (t/run-check rec "gen-validate-template"
    (fn [] (when (vs/getpath (config/make-config) "feature.validate")
             (let [client (api/test-sdk nil (vs/jm "feature" (vs/jm "validate" (vs/jm "active" true))))]
               (t/is-throws (fn [] (e-template/list (api/template client nil) (vs/jm "id" 1) nil))
                            "validate_failed" "validate refuses an invalid request")))))
  (t/run-check rec "gen-exists-user_rcs_sender_collection"
    (fn [] (let [sdk (api/test-sdk nil nil)]
             (t/is-true (some? (api/user_rcs_sender_collection sdk nil)) "user_rcs_sender_collection accessor present"))))
  (t/run-check rec "gen-smoke-user_rcs_sender_collection"
    (fn [] (let [sdk (api/test-sdk nil nil)
                 ent (api/user_rcs_sender_collection sdk nil)]
             (let [items (e-user_rcs_sender_collection/list ent (vs/jm) nil)]
               ;; list resolves to one entity per record.
               (t/is-true (sequential? items) "list returns a sequential collection"))
             )))
  (t/run-check rec "gen-list-user_rcs_sender_collection"
    (fn [] (let [seed (vs/jm "user_rcs_sender_collection" (vs/jm "L1" (vs/jm "id" "L1" "name" "a")
                                                "L2" (vs/jm "id" "L2" "name" "b")))
                 items (e-user_rcs_sender_collection/list (api/user_rcs_sender_collection (api/test-sdk (vs/jm "entity" seed) nil) nil)
                                         (vs/jm) nil)]
             ;; list resolves to one entity per record; data-get reads the record.
             (t/is-eq (count items) 2 "list answers each seeded record")
             (t/is-true (every? (fn [item] (and (map? item) (vs/ismap ((:data-get item))))) items)
                        "each listed item is an entity carrying its record"))))
  (t/run-check rec "gen-stream-user_rcs_sender_collection"
    (fn [] (let [seed (vs/jm "user_rcs_sender_collection" (vs/jm "S1" (vs/jm "id" "S1" "name" "a")
                                                "S2" (vs/jm "id" "S2" "name" "b")
                                                "S3" (vs/jm "id" "S3" "name" "c")))]
             ;; Fallback (no streaming feature): materialised items.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   items (vec (e-user_rcs_sender_collection/stream (api/user_rcs_sender_collection sdk nil) "list" (vs/jm) nil))]
               (t/is-eq (count items) 3 "stream fallback yields materialised items")
               (t/is-true (vs/ismap (first items)) "stream yields bare record maps"))
             ;; signal cancels iteration between yields.
             (let [sdk (api/test-sdk (vs/jm "entity" seed) nil)
                   n (atom 0) sig (fn [] (>= (swap! n inc) 2))
                   items (vec (e-user_rcs_sender_collection/stream (api/user_rcs_sender_collection sdk nil) "list" (vs/jm) (vs/jm "signal" sig)))]
               (t/is-eq (count items) 1 "stream signal stops after first yield"))
             ;; Streaming feature active: yields from the streaming iterator.
             (when (vs/getpath (config/make-config) "feature.streaming")
               (let [ssdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true))))]
                 (t/is-eq (count (vec (e-user_rcs_sender_collection/stream (api/user_rcs_sender_collection ssdk nil) "list" (vs/jm) nil))) 3
                          "stream (streaming active) yields all items"))
               (let [csdk (api/test-sdk (vs/jm "entity" seed) (vs/jm "feature" (vs/jm "streaming" (vs/jm "active" true "chunkSize" 2))))
                     batches (vec (e-user_rcs_sender_collection/stream (api/user_rcs_sender_collection csdk nil) "list" (vs/jm) nil))]
                 (t/is-eq (count batches) 2 "stream chunkSize groups items into 2 batches"))))))
  (t/run-check rec "gen-stream-error-user_rcs_sender_collection"
    (fn [] (let [offline (vs/jm "net" (vs/jm "offline" true))
                 err (try (vec (e-user_rcs_sender_collection/stream (api/user_rcs_sender_collection (api/test-sdk offline nil) nil) "list" (vs/jm) nil)) nil
                          (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "offline"))
                        "the transport failure raises from the stream")
             (t/is-eq (count (vec (e-user_rcs_sender_collection/stream (api/user_rcs_sender_collection (api/test-sdk offline nil) nil) "list" (vs/jm)
                                                 (vs/jm "ctrl" (vs/jm "throw" false)))))
                      0 "throw false ends the stream quietly")
             (when (vs/getpath (config/make-config) "feature.rbac")
               (let [denied (api/test-sdk nil (vs/jm "feature" (vs/jm "rbac" (vs/jm "active" true "deny" true))))]
                 (t/is-throws (fn [] (vec (e-user_rcs_sender_collection/stream (api/user_rcs_sender_collection denied nil) "list" (vs/jm) nil)))
                              "rbac_denied" "the rbac denial raises from the stream"))))))
  (t/run-check rec "gen-stream-ctrl-user_rcs_sender_collection"
    (fn [] (let [explain (vs/jm)
                 ctrl (vs/jm "explain" explain)]
             (vec (e-user_rcs_sender_collection/stream (api/user_rcs_sender_collection (api/test-sdk nil nil) nil) "list" (vs/jm) (vs/jm "ctrl" ctrl)))
             (t/is-eq (vec (vs/keysof ctrl)) ["explain"] "the stream changed the caller's ctrl")
             (t/is-true (identical? explain (vs/getprop ctrl "explain")) "the caller's explain record is not its own")
             (t/is-true (pos? (count (vs/keysof explain))) "the caller's explain record was not filled"))))
  (t/run-check rec "gen-unexpected-user_rcs_sender_collection"
    (fn [] (let [seen (atom 0)
                 hook (atom {:name "failhook" :active true :version "0.0.1" :_options nil
                             "init" (fn [_ctx _opts] nil)
                             "PreSpec" (fn [_ctx] (throw (RuntimeException. "user_rcs_sender_collection hook failed")))
                             "PreUnexpected" (fn [_ctx] (swap! seen inc))})
                 ent (api/user_rcs_sender_collection (api/make-sdk (vs/jm "feature" (vs/jm "test" (vs/jm "active" true)) "extend" [hook])) nil)
                 err (try (e-user_rcs_sender_collection/list ent (vs/jm) nil) nil (catch Throwable e e))]
             (t/is-true (and (some? err) (.contains (str (.getMessage ^Throwable err)) "hook failed"))
                        "the hook's failure is raised")
             (t/is-true (pos? @seen) "PreUnexpected did not fire")
             (let [fired @seen]
               (t/is-nil (e-user_rcs_sender_collection/list ent (vs/jm) (vs/jm "throw" false)) "throw false should resolve to nothing")
               (t/is-true (> @seen fired) "PreUnexpected did not fire under throw false")))))
  (t/run-check rec "gen-prepare-available"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/available" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-available"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/available" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-blacklist"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/blacklist" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-blacklist"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/blacklist" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-callback"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/callback" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-callback"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/callback" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-contact"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/contact" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-contact"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/contact" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-contacts_field"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/contacts_field" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-contacts_field"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/contacts_field" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-contacts_field_option"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/contacts_field_option" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-contacts_field_option"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/contacts_field_option" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-contactsgroup"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/contactsgroup" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-contactsgroup"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/contactsgroup" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-field_available"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/field_available" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-field_available"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/field_available" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-group"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/group" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-group"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/group" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-opt_out"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/opt_out" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-opt_out"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/opt_out" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-opt_out_setting"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/opt_out_setting" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-opt_out_setting"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/opt_out_setting" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-permission"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/permission" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-permission"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/permission" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-ping"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/ping" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-ping"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/ping" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-profile"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/profile" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-profile"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/profile" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-rcs"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/rcs" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-rcs"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/rcs" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-sendername"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/sendername" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-sendername"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/sendername" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-sendername_statement"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/sendername_statement" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-sendername_statement"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/sendername_statement" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-shipment_country_volume"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/shipment_country_volume" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-shipment_country_volume"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/shipment_country_volume" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-short_url"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/short_url" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-short_url"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/short_url" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-subuser"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/subuser" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-subuser"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/subuser" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-template"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/template" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-template"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/template" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (t/run-check rec "gen-prepare-user_rcs_sender_collection"
    (fn [] (let [client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"))
                 fetchdef (api/prepare client (vs/jm "path" "/api/user_rcs_sender_collection" "method" "GET"))]
             (t/is-true (vs/ismap fetchdef) "prepare returns a fetchdef map")
             (t/is-some (vs/getprop fetchdef "url") "fetchdef carries a url")
             (t/is-eq (vs/getprop fetchdef "method") "GET" "fetchdef preserves the method"))))
  (t/run-check rec "gen-direct-user_rcs_sender_collection"
    (fn [] (let [fetch (fn [_url _fetchdef]
                         [(vs/jm "status" 200 "statusText" "OK" "headers" (vs/jm)
                                 "json" (fn [] (vs/jm "id" "d1"))) nil])
                 client (api/make-sdk (vs/jm "base" "http://example.test" "apikey" "test-key"
                                             "system" (vs/jm "fetch" fetch)))
                 result (api/direct client (vs/jm "path" "/api/user_rcs_sender_collection" "method" "GET"))]
             (t/is-true (vs/ismap result) "direct returns a result map")
             (t/is-true (vs/getprop result "ok") "direct 200 => ok true")
             (t/is-eq (vs/getprop result "status") 200 "direct surfaces the status"))))
  (letfn [(fence-pat [] (re-pattern (apply str (repeat 3 (char 96)))))
          (fence-count [text] (count (re-seq (fence-pat) text)))
          (clj-blocks [text]
            (let [parts (clojure.string/split text (fence-pat))]
              (->> parts
                   (map-indexed vector)
                   (filter (fn [[i _]] (odd? i)))
                   (map (fn [[_ seg]] seg))
                   (filter (fn [seg]
                             (= "clojure"
                                (clojure.string/trim (first (clojure.string/split-lines seg))))))
                   (map (fn [seg]
                          (clojure.string/join "\n"
                            (rest (clojure.string/split-lines seg))))))))]
    (doseq [[label path] [["root-README" "../README.md"]
                          ["README" "README.md"]
                          ["REFERENCE" "REFERENCE.md"]]]
      (t/run-check rec (str "gen-readme-examples-" label)
        (fn []
          (if-not (.exists (java.io.File. ^String path))
            (t/is-true true (str label " absent (skipped)"))
            (let [text (slurp path)]
              ;; A code fence opened but never closed leaves an ODD number of
              ;; fence markers; the split-on-fence then captures the trailing
              ;; prose (everything after the last opener) as if it were a
              ;; clojure block, which can parse cleanly and pass silently. Fail
              ;; on the malformed doc instead. (Count markers directly rather
              ;; than split parts: split drops trailing empty segments, so a
              ;; closing fence at EOF would be miscounted.)
              (t/is-true (even? (fence-count text))
                         (str label " code fences balanced (no unclosed fence)"))
              (let [blocks (clj-blocks text)]
                (doseq [b blocks]
                  (binding [*read-eval* false]
                    (read-string (str "[\n" b "\n]"))))
                (t/is-true true (str label " clojure blocks parse cleanly")))))))))
  nil)
