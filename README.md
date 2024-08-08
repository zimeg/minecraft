# minecraft

> a small home server for the block game

## starting a server

run a process in some [flaked][flakes] environment with:

```sh
$ minecraft-server
```

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

[bukkit]: https://dev.bukkit.org
[default]: https://minecraft.fandom.com/wiki/Server.properties#Keys
[flakes]: https://wiki.nixos.org/wiki/Flakes
[papermc]: https://docs.papermc.io/paper
[spigot]: http://www.spigotmc.org/wiki/spigot-configuration/
