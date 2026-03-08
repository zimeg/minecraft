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

one world is [saved in safekeepings](https://github.com/zimeg/.DOTFILES/blob/6583d96b2024d1fbcf185a65dcb555a8bc18dd92/machines/tom/services/restic/default.nix#L25-L44) from deletion.
