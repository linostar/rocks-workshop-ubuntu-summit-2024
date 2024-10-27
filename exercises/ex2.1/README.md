# Instructions for Exercise 2.1

1. Run `rockcraft init` to create a boilerplate `rockcraft.yaml` file
2. Open `rockcraft.yaml` with your favorite editor
3. Change `name` field to `mysql`
4. Change the `base` field value `ubuntu@24.04`
4. Change `summary` and `description` fields to something meaningful
5. Change the value(s) under `platforms` to match your architectures (e.g. `arm64`, `riscv64`, `ppc64le`, `s390x`)
6. Under `parts`, remove the existing part and add the following:
```yaml
    mysql:
        plugin: dump
        source: scripts/
        source-type: local
        overlay-packages:
            - mysql-server-8.0 
```
7. Add the following services at top-level of the yaml:
```
services:
    mysql-server:
        override: replace
        startup: enabled
        command: bash -c "mysqld --initialize-insecure; mysqld --bind-address=0.0.0.0"

    add-root-user:
        override: replace
        startup: enabled
        command: /add-root.sh
        on-success: ignore
        on-failure: ignore
```
8. create a folder called `scripts`, a file called `add-root.sh` inside it and paste the following in the file:
```
#!/bin/bash

sleep 5
mysql -u root -e "CREATE USER 'root'@'%' IDENTIFIED BY 'mypass'; GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"

```
9. give execute permission to the `add-root.sh` file
