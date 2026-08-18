THIS WE USE A VAULT TO HANDLE ENV FILE FOR APPLICATION:

Our Setup is docker based application:

Vault Design:

                    ┌──────────────────────┐
                    │    HashiCorp Vault   │
                    │                      │
                    │ KV v2: my/backend    │
                    └──────────┬───────────┘
                               │
                         AppRole Auth
                               │
                    ┌──────────▼───────────┐
                    │     Vault Agent       │
                    │       container       │
                    └──────────┬───────────┘
                               │
                       shared Docker volume
                               │
                    ┌──────────▼───────────┐
                    │   Backend container   │
                    │                       │
                    │ Node / Python / etc.  │
                    └───────────────────────┘

  1. Create VAULT /folder

  2. Vault Policy and mention path 

  3. Authentication

  4. Vault Agent
