# minecraft

> a small home server for the block game

## starting a server

run a process in some [flaked][flakes] environment with:

```sh
$ minecraft-server
```

[or inspect service patterns on machine startup][service].

## joining the world

connect to the server with a hostname and port:

```sh
tom:25565
```

## plugins

the minimal experience is sought so few changes here.

- [default][default]: basic outlines for this game - `server.properties`
- [papermc][papermc]: simple server configurations - `config/paper-*.yml`
- [bukkit][bukkit]: compiled build settings - `bukkit.yml`
- [spigot][spigot]: compiled build settings - `spigot.yml`

the `plugins` path has more setting but hides builds.

## backups

[saving worlds is instead a task for another repo][backup].

### creating the cloud

a unique bucket on amazon web services is needed:

```sh
$ vim ./backup/backup.sh
$ vim ./backup/tofu.auto.tfvars.json
```

some changes to the backend backups can happen:

```sh
$ vim ./backup/main.tf
```

then configuration can change the currents cloud:

```sh
$ nix develop .#backup
$ tofu init
$ tofu apply
```

### saving a backup

[it is often a scheduled time to perform backups][timer]:

```sh
$ nix develop .#backup
$ ./backup/backup.sh
```

[backup]: https://github.com/zimeg/.DOTFILES/blob/abdb288a3e62712a49c01c97f408aa73a874e9ca/machines/tom/systemd/services/default.nix#L29-L40
[bukkit]: https://dev.bukkit.org
[default]: https://minecraft.fandom.com/wiki/Server.properties#Keys
[flakes]: https://wiki.nixos.org/wiki/Flakes
[papermc]: https://docs.papermc.io/paper
[service]: https://github.com/zimeg/.DOTFILES/blob/abdb288a3e62712a49c01c97f408aa73a874e9ca/machines/tom/systemd/services/default.nix#L41-L56
[spigot]: http://www.spigotmc.org/wiki/spigot-configuration/
[timer]: https://github.com/zimeg/.DOTFILES/blob/abdb288a3e62712a49c01c97f408aa73a874e9ca/machines/tom/systemd/timers/default.nix#L4-L9
