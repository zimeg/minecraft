# minecraft

> a small home server for the block game

## starting a server

find process to run a server with [`@theorderingmachine`](https://github.com/zimeg/.DOTFILES/blob/a5d17c4e1019fbcea417e0af89453f0030f61054/machines/tom/services/minecraft-server/default.nix):

```sh
$ systemctl start minecraft-server.service
```

### following the logs

inspect service outputs with machine startup:

```sh
$ journalctl -u minecraft-server.service
```

## joining the world

connect to the server with a hostname and port:

```sh
tom:25565
```

### changing the saves

update the `server.properties` then restart:

```diff
- level-name=world
+ level-name=skyblock
```

## backups

one world is saved in safekeepings from deletion.

### creating the cloud

a unique bucket on amazon web services is needed:

```sh
$ vim ./backup/tofu.auto.tfvars.json
```

some changes to the backend backups can happen:

```sh
$ vim ./backup/main.tf
```

then configuration can change the currents cloud:

```sh
$ tofu init
$ tofu apply
```

### saving a backup

[it is often a scheduled time to perform backups](https://github.com/zimeg/.DOTFILES/blob/a5d17c4e1019fbcea417e0af89453f0030f61054/machines/tom/services/restic/default.nix):

```sh
$ systemctl start restic-backups-minecraft.service
```

### reloading from save

with more luck past files can be used for game:

```sh
$ systemctl stop minecraft-server.service
$ restic -r s3:s3.us-east-1.amazonaws.com/tom.25565 restore latest --target /tmp/backup
$ rsync -av --delete /tmp/backup/srv/minecraft/world/ /persistent/srv/minecraft/world/
$ chown -R minecraft:minecraft /persistent/srv/minecraft/world
$ systemctl start minecraft-server.service
```
