declare const OPTSPEC: {
    allow: {
        method: string;
        op: string;
    };
    apikey: string;
    auth: {
        basic: boolean;
        in: string;
        name: string;
        prefix: string;
    };
    base: string;
    clean: {
        active: boolean;
        hint: string;
        keys: string;
        mask: string;
        min: string;
        values: string;
    };
    entity: {
        "`$CHILD`": {
            "`$OPEN`": boolean;
            active: boolean;
            alias: {};
        };
    };
    extend: string;
    headers: {
        "`$CHILD`": string;
    };
    prefix: string;
    secret: string;
    server: {
        "`$CHILD`": string;
    };
    suffix: string;
    system: {
        fetch: string;
    };
    test: {
        active: boolean;
        entity: {
            "`$OPEN`": boolean;
        };
    };
    utility: {};
    feature: {
        "`$CHILD`": {
            "`$OPEN`": boolean;
            active: boolean;
        };
        audit: (string | {
            "`$OPEN`": boolean;
            active: string[];
            actor: (string | string[])[];
            max: string[];
            now: string[];
            sink: string[];
        })[];
        cache: (string | {
            "`$OPEN`": boolean;
            active: string[];
            max: string[];
            methods: string[];
            ttl: string[];
            now: string[];
        })[];
        clienttrack: (string | {
            "`$OPEN`": boolean;
            active: string[];
            clientVersion: string[];
            clientName: string[];
            headers: string[];
            idgen: string[];
            sessionId: string[];
        })[];
        cost: (string | {
            "`$OPEN`": boolean;
            active: string[];
            budget: string[];
            currency: (string | string[])[];
            header: (string | string[])[];
            onBudget: (string | string[])[];
            path: (string | string[])[];
            perUnit: string[];
            rates: string[];
            unit: string[];
            actor: string[];
            sink: string[];
        })[];
        debug: (string | {
            "`$OPEN`": boolean;
            active: string[];
            max: string[];
            redact: string[];
            now: string[];
            onEntry: string[];
        })[];
        idempotency: (string | {
            "`$OPEN`": boolean;
            active: string[];
            header: (string | string[])[];
            methods: string[];
            ops: string[];
            keygen: string[];
        })[];
        log: (string | {
            "`$OPEN`": boolean;
            active: string[];
            level: string[];
            logger: string;
        })[];
        metrics: (string | {
            "`$OPEN`": boolean;
            active: string[];
            now: string[];
        })[];
        netsim: (string | {
            "`$OPEN`": boolean;
            active: string[];
            errorTimes: string[];
            failEvery: string[];
            failRate: string[];
            failStatus: string[];
            failTimes: string[];
            latency: string[];
            offline: string[];
            rateLimitTimes: string[];
            retryAfter: string[];
            seed: string[];
            sleep: string[];
        })[];
        paging: (string | {
            "`$OPEN`": boolean;
            active: string[];
            afterVar: (string | string[])[];
            cursorParam: (string | string[])[];
            firstVar: (string | string[])[];
            limitParam: (string | string[])[];
            pageParam: (string | string[])[];
            startPage: string[];
            limit: string[];
            ops: string[];
        })[];
        proxy: (string | {
            "`$OPEN`": boolean;
            active: string[];
            fromEnv: string[];
            noProxy: string[];
            url: (string | string[])[];
            agent: string[];
        })[];
        ratelimit: (string | {
            "`$OPEN`": boolean;
            active: string[];
            burst: string[];
            rate: string[];
            now: string[];
            sleep: string[];
        })[];
        rbac: (string | {
            "`$OPEN`": boolean;
            active: string[];
            deny: string[];
            permissions: string[];
            rules: string[];
        })[];
        retry: (string | {
            "`$OPEN`": boolean;
            active: string[];
            factor: string[];
            maxDelay: string[];
            minDelay: string[];
            retries: string[];
            statuses: string[];
            jitter: string[];
            sleep: string[];
        })[];
        secrets: (string | {
            "`$OPEN`": boolean;
            active: string[];
            cache: string[];
            exchange: string[];
            name: (string | string[])[];
            providers: string[];
        })[];
        streaming: (string | {
            "`$OPEN`": boolean;
            active: string[];
            chunkDelay: string[];
            chunkSize: string[];
            ops: string[];
            sleep: string[];
        })[];
        telemetry: (string | {
            "`$OPEN`": boolean;
            active: string[];
            exporter: string[];
            headers: string[];
            idgen: string[];
            now: string[];
        })[];
        test: (string | {
            "`$OPEN`": boolean;
            active: string[];
            entity: string[];
            net: string[];
        })[];
        timeout: (string | {
            "`$OPEN`": boolean;
            active: string[];
            ms: string[];
            clearTimer: string[];
            setTimer: string[];
        })[];
        validate: (string | {
            "`$OPEN`": boolean;
            active: string[];
            mode: (string | string[])[];
            request: string[];
            response: string[];
            strict: string[];
            onInvalid: string[];
        })[];
    };
};
declare const ENTITYSPEC: {
    available: {
        data: {
            "`$OPEN`": boolean;
            name: (string | string[])[];
            normalize: string[];
            template: (string | string[])[];
        };
        op: {
            list: {
                "`$OPEN`": boolean;
                name: (string | string[])[];
                normalize: string[];
                template: (string | string[])[];
            };
        };
    };
    blacklist: {
        data: {
            "`$OPEN`": boolean;
            id: (string | string[])[];
        };
        op: {
            create: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
            };
            load: {
                "`$OPEN`": boolean;
                limit: string[];
                offset: string[];
                q: string[];
            };
            remove: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
            };
        };
    };
    callback: {
        data: {
            "`$OPEN`": boolean;
            active: string[];
            api_version: string[];
            id: (string | string[])[];
            invalid: string[];
            receiver: string[];
            receiver_type: (string | string[])[];
            type: (string | string[])[];
            url: (string | string[])[];
        };
        op: {
            create: {
                "`$OPEN`": boolean;
                active: string[];
                api_version: string[];
                id: (string | string[])[];
                invalid: string[];
                receiver: string[];
                receiver_type: (string | string[])[];
                type: (string | string[])[];
                url: (string | string[])[];
            };
            list: {
                "`$OPEN`": boolean;
                active: string[];
                api_version: string[];
                id: (string | string[])[];
                invalid: string[];
                receiver: string[];
                receiver_type: (string | string[])[];
                type: (string | string[])[];
                url: (string | string[])[];
            };
            load: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
            };
            remove: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
            };
            update: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
                active: string[];
                api_version: string[];
                invalid: string[];
                receiver: string[];
                receiver_type: (string | string[])[];
                type: (string | string[])[];
                url: (string | string[])[];
            };
        };
    };
    contact: {
        data: {
            "`$OPEN`": boolean;
            birthday_date: (string | string[])[];
            city: (string | string[])[];
            collection: string;
            contact_expire_after: string;
            contacts_count: string;
            country: (string | string[])[];
            created_by: (string | string[])[];
            date_created: (string | string[])[];
            date_updated: (string | string[])[];
            description: (string | string[])[];
            email: (string | string[])[];
            first_name: (string | string[])[];
            gender: (string | string[])[];
            group_id: (string | string[])[];
            groups: string;
            id: (string | string[])[];
            idx: (string | string[])[];
            last_name: (string | string[])[];
            name: (string | string[])[];
            permissions: string[];
            phone_number: (string | string[])[];
            read: string[];
            send: string[];
            size: string;
            source: (string | string[])[];
            type: (string | string[])[];
            username: (string | string[])[];
            value: (string | string[])[];
            write: string[];
        };
        op: {
            create: {
                "`$OPEN`": boolean;
                birthday_date: (string | string[])[];
                city: (string | string[])[];
                collection: string;
                contact_expire_after: string;
                contacts_count: string;
                country: (string | string[])[];
                created_by: (string | string[])[];
                date_created: (string | string[])[];
                date_updated: (string | string[])[];
                description: (string | string[])[];
                email: (string | string[])[];
                first_name: (string | string[])[];
                gender: (string | string[])[];
                group_id: (string | string[])[];
                groups: string;
                id: (string | string[])[];
                idx: (string | string[])[];
                last_name: (string | string[])[];
                name: (string | string[])[];
                permissions: string[];
                phone_number: (string | string[])[];
                read: string[];
                send: string[];
                size: string;
                source: (string | string[])[];
                type: (string | string[])[];
                username: (string | string[])[];
                value: (string | string[])[];
                write: string[];
            };
            list: {
                "`$OPEN`": boolean;
                birthday_date: string[];
                email: string[];
                first_name: string[];
                gender: (string | string[])[];
                group_id: string[];
                last_name: string[];
                limit: string[];
                offset: string[];
                order_by: (string | string[])[];
                phone_number: string[];
                q: (string | string[])[];
            };
            load: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
            };
            remove: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
            };
            update: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
                birthday_date: (string | string[])[];
                city: (string | string[])[];
                collection: string[];
                contact_expire_after: string[];
                contacts_count: string[];
                country: (string | string[])[];
                created_by: (string | string[])[];
                date_created: (string | string[])[];
                date_updated: (string | string[])[];
                description: (string | string[])[];
                email: (string | string[])[];
                first_name: (string | string[])[];
                gender: (string | string[])[];
                group_id: (string | string[])[];
                groups: string[];
                idx: (string | string[])[];
                last_name: (string | string[])[];
                name: (string | string[])[];
                permissions: string[];
                phone_number: (string | string[])[];
                read: string[];
                send: string[];
                size: string[];
                source: (string | string[])[];
                type: (string | string[])[];
                username: (string | string[])[];
                value: (string | string[])[];
                write: string[];
            };
        };
    };
    contacts_field: {
        data: {
            "`$OPEN`": boolean;
            birthday_date: (string | string[])[];
            city: (string | string[])[];
            contact_expire_after: string;
            contacts_count: string[];
            country: (string | string[])[];
            created_by: (string | string[])[];
            date_created: (string | string[])[];
            date_updated: (string | string[])[];
            description: (string | string[])[];
            email: (string | string[])[];
            first_name: (string | string[])[];
            gender: (string | string[])[];
            group_id: (string | string[])[];
            groups: string;
            id: (string | string[])[];
            idx: (string | string[])[];
            last_name: (string | string[])[];
            name: (string | string[])[];
            permissions: string[];
            phone_number: (string | string[])[];
            read: string[];
            send: string[];
            source: (string | string[])[];
            type: (string | string[])[];
            username: (string | string[])[];
            value: (string | string[])[];
            write: string[];
        };
        op: {
            create: {
                "`$OPEN`": boolean;
                birthday_date: (string | string[])[];
                city: (string | string[])[];
                contact_expire_after: string;
                contacts_count: string[];
                country: (string | string[])[];
                created_by: (string | string[])[];
                date_created: (string | string[])[];
                date_updated: (string | string[])[];
                description: (string | string[])[];
                email: (string | string[])[];
                first_name: (string | string[])[];
                gender: (string | string[])[];
                group_id: (string | string[])[];
                groups: string;
                id: (string | string[])[];
                idx: (string | string[])[];
                last_name: (string | string[])[];
                name: (string | string[])[];
                permissions: string[];
                phone_number: (string | string[])[];
                read: string[];
                send: string[];
                source: (string | string[])[];
                type: (string | string[])[];
                username: (string | string[])[];
                value: (string | string[])[];
                write: string[];
            };
            list: {
                "`$OPEN`": boolean;
                birthday_date: (string | string[])[];
                city: (string | string[])[];
                contact_expire_after: string[];
                contacts_count: string[];
                country: (string | string[])[];
                created_by: (string | string[])[];
                date_created: (string | string[])[];
                date_updated: (string | string[])[];
                description: (string | string[])[];
                email: (string | string[])[];
                first_name: (string | string[])[];
                gender: (string | string[])[];
                group_id: (string | string[])[];
                groups: string[];
                id: (string | string[])[];
                idx: (string | string[])[];
                last_name: (string | string[])[];
                name: (string | string[])[];
                permissions: string[];
                phone_number: (string | string[])[];
                read: string[];
                send: string[];
                source: (string | string[])[];
                type: (string | string[])[];
                username: (string | string[])[];
                value: (string | string[])[];
                write: string[];
            };
            remove: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
            };
            update: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
                birthday_date: (string | string[])[];
                city: (string | string[])[];
                contact_expire_after: string[];
                contacts_count: string[];
                country: (string | string[])[];
                created_by: (string | string[])[];
                date_created: (string | string[])[];
                date_updated: (string | string[])[];
                description: (string | string[])[];
                email: (string | string[])[];
                first_name: (string | string[])[];
                gender: (string | string[])[];
                group_id: (string | string[])[];
                groups: string[];
                idx: (string | string[])[];
                last_name: (string | string[])[];
                name: (string | string[])[];
                permissions: string[];
                phone_number: (string | string[])[];
                read: string[];
                send: string[];
                source: (string | string[])[];
                type: (string | string[])[];
                username: (string | string[])[];
                value: (string | string[])[];
                write: string[];
            };
        };
    };
    contacts_field_option: {
        data: {
            "`$OPEN`": boolean;
            birthday_date: (string | string[])[];
            city: (string | string[])[];
            contact_expire_after: string;
            contacts_count: string[];
            country: (string | string[])[];
            created_by: (string | string[])[];
            date_created: (string | string[])[];
            date_updated: (string | string[])[];
            description: (string | string[])[];
            email: (string | string[])[];
            first_name: (string | string[])[];
            gender: (string | string[])[];
            group_id: (string | string[])[];
            groups: string;
            id: (string | string[])[];
            idx: (string | string[])[];
            last_name: (string | string[])[];
            name: (string | string[])[];
            permissions: string[];
            phone_number: (string | string[])[];
            read: string[];
            send: string[];
            source: (string | string[])[];
            type: (string | string[])[];
            username: (string | string[])[];
            value: (string | string[])[];
            write: string[];
        };
        op: {
            list: {
                "`$OPEN`": boolean;
                field_id: (string | string[])[];
            };
        };
    };
    contactsgroup: {
        data: {
            "`$OPEN`": boolean;
            birthday_date: (string | string[])[];
            city: (string | string[])[];
            contact_expire_after: string;
            contacts_count: string[];
            country: (string | string[])[];
            created_by: (string | string[])[];
            date_created: (string | string[])[];
            date_updated: (string | string[])[];
            description: (string | string[])[];
            email: (string | string[])[];
            first_name: (string | string[])[];
            gender: (string | string[])[];
            group_id: (string | string[])[];
            groups: string;
            id: (string | string[])[];
            idx: (string | string[])[];
            last_name: (string | string[])[];
            name: (string | string[])[];
            permissions: string[];
            phone_number: (string | string[])[];
            read: string;
            send: string;
            source: (string | string[])[];
            type: (string | string[])[];
            username: (string | string[])[];
            value: (string | string[])[];
            write: string;
        };
        op: {
            create: {
                "`$OPEN`": boolean;
                birthday_date: (string | string[])[];
                city: (string | string[])[];
                contact_expire_after: string;
                contacts_count: string[];
                country: (string | string[])[];
                created_by: (string | string[])[];
                date_created: (string | string[])[];
                date_updated: (string | string[])[];
                description: (string | string[])[];
                email: (string | string[])[];
                first_name: (string | string[])[];
                gender: (string | string[])[];
                group_id: (string | string[])[];
                groups: string;
                id: (string | string[])[];
                idx: (string | string[])[];
                last_name: (string | string[])[];
                name: (string | string[])[];
                permissions: string[];
                phone_number: (string | string[])[];
                read: string;
                send: string;
                source: (string | string[])[];
                type: (string | string[])[];
                username: (string | string[])[];
                value: (string | string[])[];
                write: string;
            };
            list: {
                "`$OPEN`": boolean;
                name: string[];
                with: string[];
            };
            remove: {
                "`$OPEN`": boolean;
                group_id: (string | string[])[];
            };
            update: {
                "`$OPEN`": boolean;
                group_id: (string | string[])[];
                username: (string | string[])[];
                birthday_date: (string | string[])[];
                city: (string | string[])[];
                contact_expire_after: string[];
                contacts_count: string[];
                country: (string | string[])[];
                created_by: (string | string[])[];
                date_created: (string | string[])[];
                date_updated: (string | string[])[];
                description: (string | string[])[];
                email: (string | string[])[];
                first_name: (string | string[])[];
                gender: (string | string[])[];
                groups: string[];
                id: (string | string[])[];
                idx: (string | string[])[];
                last_name: (string | string[])[];
                name: (string | string[])[];
                permissions: string[];
                phone_number: (string | string[])[];
                read: string[];
                send: string[];
                source: (string | string[])[];
                type: (string | string[])[];
                value: (string | string[])[];
                write: string[];
            };
        };
    };
    contactstrash: {
        data: {
            "`$OPEN`": boolean;
        };
        op: {};
    };
    field_available: {
        data: {
            "`$OPEN`": boolean;
            built_in: string[];
            id: (string | string[])[];
            name: (string | string[])[];
            options: string[];
            type: (string | string[])[];
        };
        op: {
            list: {
                "`$OPEN`": boolean;
                built_in: string[];
                id: (string | string[])[];
                name: (string | string[])[];
                options: string[];
                type: (string | string[])[];
            };
        };
    };
    group: {
        data: {
            "`$OPEN`": boolean;
            contact_expire_after: string;
            contacts_count: string;
            created_by: (string | string[])[];
            date_created: (string | string[])[];
            date_updated: (string | string[])[];
            description: (string | string[])[];
            id: (string | string[])[];
            idx: (string | string[])[];
            name: (string | string[])[];
            permissions: string[];
        };
        op: {
            load: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
            };
            update: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
                contact_expire_after: string[];
                contacts_count: string[];
                created_by: (string | string[])[];
                date_created: (string | string[])[];
                date_updated: (string | string[])[];
                description: (string | string[])[];
                idx: (string | string[])[];
                name: (string | string[])[];
                permissions: string[];
            };
        };
    };
    mfa_code: {
        data: {
            "`$OPEN`": boolean;
            content: (string | string[])[];
            fast: string;
            from: (string | string[])[];
            phone_number: (string | string[])[];
        };
        op: {
            create: {
                "`$OPEN`": boolean;
                content: (string | string[])[];
                fast: string;
                from: (string | string[])[];
                phone_number: (string | string[])[];
            };
        };
    };
    opt_out: {
        data: {
            "`$OPEN`": boolean;
            date: (string | string[])[];
            id: (string | string[])[];
            links: string[];
            phoneNumber: string[];
        };
        op: {
            list: {
                "`$OPEN`": boolean;
                limit: string[];
                offset: string[];
                phone_number: (string | string[])[];
            };
            remove: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
            };
        };
    };
    opt_out_setting: {
        data: {
            "`$OPEN`": boolean;
            brand: (string | string[])[];
        };
        op: {
            load: {
                "`$OPEN`": boolean;
                brand: (string | string[])[];
            };
            update: {
                "`$OPEN`": boolean;
                brand: (string | string[])[];
            };
        };
    };
    permission: {
        data: {
            "`$OPEN`": boolean;
            group_id: (string | string[])[];
            id: (string | string[])[];
            read: string;
            send: string;
            username: (string | string[])[];
            write: string;
        };
        op: {
            create: {
                "`$OPEN`": boolean;
                group_id: (string | string[])[];
                id: (string | string[])[];
                read: string;
                send: string;
                username: (string | string[])[];
                write: string;
            };
            load: {
                "`$OPEN`": boolean;
                group_id: (string | string[])[];
                id: (string | string[])[];
                username: (string | string[])[];
            };
        };
    };
    ping: {
        data: {
            "`$OPEN`": boolean;
            authorized: string;
            unavailable: string;
        };
        op: {
            list: {
                "`$OPEN`": boolean;
                authorized: string[];
                unavailable: string[];
            };
        };
    };
    profile: {
        data: {
            "`$OPEN`": boolean;
            email: (string | string[])[];
            name: (string | string[])[];
            payment_type: (string | string[])[];
            phone_number: string;
            points: string[];
            user_type: (string | string[])[];
            username: (string | string[])[];
        };
        op: {
            list: {
                "`$OPEN`": boolean;
                type: (string | string[])[];
            };
            load: {
                "`$OPEN`": boolean;
                email: (string | string[])[];
                name: (string | string[])[];
                payment_type: (string | string[])[];
                phone_number: string[];
                points: string[];
                user_type: (string | string[])[];
                username: (string | string[])[];
            };
        };
    };
    rcs: {
        data: {
            "`$OPEN`": boolean;
        };
        op: {};
    };
    sendername: {
        data: {
            "`$OPEN`": boolean;
            created_at: (string | string[])[];
            id: (string | string[])[];
            is_default: string[];
            sender: (string | string[])[];
            status: (string | string[])[];
        };
        op: {
            create: {
                "`$OPEN`": boolean;
                created_at: (string | string[])[];
                id: (string | string[])[];
                is_default: string[];
                sender: (string | string[])[];
                status: (string | string[])[];
            };
            list: {
                "`$OPEN`": boolean;
                created_at: (string | string[])[];
                id: (string | string[])[];
                is_default: string[];
                sender: (string | string[])[];
                status: (string | string[])[];
            };
            load: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
            };
        };
    };
    sendername_statement: {
        data: {
            "`$OPEN`": boolean;
            content: (string | string[])[];
            statements: string[];
            title: (string | string[])[];
        };
        op: {
            list: {
                "`$OPEN`": boolean;
                content: (string | string[])[];
                statements: string[];
                title: (string | string[])[];
            };
        };
    };
    sent_rcs_message: {
        data: {
            "`$OPEN`": boolean;
            content: string[];
            phone_number: (string | string[])[];
            sender: string;
            text: (string | string[])[];
        };
        op: {
            create: {
                "`$OPEN`": boolean;
                content: string[];
                phone_number: (string | string[])[];
                sender: string;
                text: (string | string[])[];
            };
        };
    };
    shipment_country_volume: {
        data: {
            "`$OPEN`": boolean;
            country_code: (string | string[])[];
            country_limit: string[];
            country_name: (string | string[])[];
            usage: string[];
        };
        op: {
            list: {
                "`$OPEN`": boolean;
                month: (string | string[])[];
                year: (string | string[])[];
            };
        };
    };
    short_url: {
        data: {
            "`$OPEN`": boolean;
            description: (string | string[])[];
            expire: (string | string[])[];
            filename: (string | string[])[];
            hits: string[];
            hits_unique: string[];
            id: (string | string[])[];
            name: (string | string[])[];
            short_url: (string | string[])[];
            type: (string | string[])[];
            url: (string | string[])[];
        };
        op: {
            create: {
                "`$OPEN`": boolean;
                description: (string | string[])[];
                expire: (string | string[])[];
                filename: (string | string[])[];
                hits: string[];
                hits_unique: string[];
                id: (string | string[])[];
                name: (string | string[])[];
                short_url: (string | string[])[];
                type: (string | string[])[];
                url: (string | string[])[];
            };
            list: {
                "`$OPEN`": boolean;
                description: (string | string[])[];
                expire: (string | string[])[];
                filename: (string | string[])[];
                hits: string[];
                hits_unique: string[];
                id: (string | string[])[];
                name: (string | string[])[];
                short_url: (string | string[])[];
                type: (string | string[])[];
                url: (string | string[])[];
            };
            load: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
            };
            remove: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
            };
            update: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
                description: (string | string[])[];
                expire: (string | string[])[];
                filename: (string | string[])[];
                hits: string[];
                hits_unique: string[];
                name: (string | string[])[];
                short_url: (string | string[])[];
                type: (string | string[])[];
                url: (string | string[])[];
            };
        };
    };
    smsdo: {
        data: {
            "`$OPEN`": boolean;
            allow_duplicates: string[];
            check_idx: string;
            date: string;
            date_validate: string[];
            details: string;
            encoding: (string | string[])[];
            expiration_date: string;
            fallback: string[];
            fast: string[];
            flash: string[];
            format: (string | string[])[];
            from: (string | string[])[];
            group: (string | string[])[];
            idx: (string | string[])[];
            max_parts: string[];
            message: (string | string[])[];
            normalize: string[];
            notify_url: (string | string[])[];
            test: string;
            time_restriction: (string | string[])[];
            to: (string | string[])[];
        };
        op: {
            create: {
                "`$OPEN`": boolean;
                allow_duplicates: string[];
                check_idx: string;
                date: string;
                date_validate: string[];
                details: string;
                encoding: (string | string[])[];
                expiration_date: string;
                fallback: string[];
                fast: string[];
                flash: string[];
                format: (string | string[])[];
                from: (string | string[])[];
                group: (string | string[])[];
                idx: (string | string[])[];
                max_parts: string[];
                message: (string | string[])[];
                normalize: string[];
                notify_url: (string | string[])[];
                test: string;
                time_restriction: (string | string[])[];
                to: (string | string[])[];
            };
        };
    };
    smssendername: {
        data: {
            "`$OPEN`": boolean;
        };
        op: {
            create: {
                "`$OPEN`": boolean;
                sendername_id: (string | string[])[];
            };
            remove: {
                "`$OPEN`": boolean;
                sender: (string | string[])[];
            };
        };
    };
    smstemplate: {
        data: {
            "`$OPEN`": boolean;
            id: (string | string[])[];
        };
        op: {
            remove: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
            };
        };
    };
    subuser: {
        data: {
            "`$OPEN`": boolean;
            active: string[];
            credentials: string;
            description: (string | string[])[];
            id: (string | string[])[];
            points: string[];
            username: (string | string[])[];
        };
        op: {
            create: {
                "`$OPEN`": boolean;
                active: string[];
                credentials: string;
                description: (string | string[])[];
                id: (string | string[])[];
                points: string[];
                username: (string | string[])[];
            };
            list: {
                "`$OPEN`": boolean;
                q: (string | string[])[];
            };
            load: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
            };
            remove: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
            };
            update: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
                active: string[];
                credentials: string[];
                description: (string | string[])[];
                points: string[];
                username: (string | string[])[];
            };
        };
    };
    template: {
        data: {
            "`$OPEN`": boolean;
            id: (string | string[])[];
            name: (string | string[])[];
            normalize: string[];
            template: (string | string[])[];
        };
        op: {
            create: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
                name: (string | string[])[];
                normalize: string[];
                template: (string | string[])[];
            };
            list: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
                name: (string | string[])[];
                normalize: string[];
                template: (string | string[])[];
            };
            load: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
            };
            update: {
                "`$OPEN`": boolean;
                id: (string | string[])[];
                name: (string | string[])[];
                normalize: string[];
                template: (string | string[])[];
            };
        };
    };
    user_rcs_sender_collection: {
        data: {
            "`$OPEN`": boolean;
            deliveredAt: (string | string[])[];
            expiredAt: (string | string[])[];
            id: (string | string[])[];
            interface: (string | string[])[];
            messageType: (string | string[])[];
            readAt: (string | string[])[];
            recipient: (string | string[])[];
            sender: (string | string[])[];
            senderId: (string | string[])[];
            sentAt: (string | string[])[];
        };
        op: {
            list: {
                "`$OPEN`": boolean;
                deliveredAt: (string | string[])[];
                expiredAt: (string | string[])[];
                id: (string | string[])[];
                interface: (string | string[])[];
                messageType: (string | string[])[];
                readAt: (string | string[])[];
                recipient: (string | string[])[];
                sender: (string | string[])[];
                senderId: (string | string[])[];
                sentAt: (string | string[])[];
            };
        };
    };
};
export { OPTSPEC, ENTITYSPEC, };
