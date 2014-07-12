# marlinspike
An IRC bot written in [Pike](http://pike.lysator.liu.se/) 7.8.

## Usage
To run: `pike main.pike` or `./main.pike`.

### Configuration
Configuration is done via command line arguments or environment variables.

| Argument                    | Variable | Default          |
|-----------------------------|----------|------------------|
|`--port`, `-p`               | `PORT`   | 6667             |
|`--server`                   | `SERVER` | irc.freenode.net |
|`--nick`, `-n`, `--nickname` | `NICK`   | Pikebot          |
|`--channel`, `--channels`    | `CHAN`   |                  |

To decrease the likelihood of unconfigured bots colliding, a random number is
appended to the default nickname.

The `--version` and `--license` arguments will also work.

## Commands
The following commands, when issued via IRC, cause the bot to react.

* The use of angle brackets `<>` denote required arguments.
* The use of square brackets `[]` denote optional arguments.

### Basic commands
#### Ping
* *Usage:* `!ping`, `!botsnack`
Cause the bot to respond with a simple message, to confirm that it's still alive.

### Source control
#### Source
* *Usage:* `!src`
Cause the bot to respond with a link to its source code.
#### Version
* *Usage:* `!version`
* *Aliases:* `!git`, `!commit`
Cause the bot to respond with, as appropriate, its version number, git commit hash, and a link to the repository.
### Network utilities
#### DNS
* *Usage:* `!dns <hostname>`
* *Aliases:* `!rdns`
Cause the bot to look up DNS records and respond appropriately.
