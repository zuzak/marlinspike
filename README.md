# marlinspike
An IRC bot written in [Pike](http://pike.lysator.liu.se/) 7.8.

## Usage
To run: `pike main.pike` or `./main.pike`.
The command line arguments `--version` and `--license` work.

## Commands
The following commands, when issued via IRC, cause the bot to react.

### Basic commands
* `!ping`
* `!botsnack`
Cause the bot to respond with a simple message, to confirm that it's still alive.

### Version
* `!src`
Cause the bot to respond with a link to its source code.
* `!commit`
* `!git`
* `!version`
Cause the bot to respond with, as appropriate, its version number, git commit hash, and a link to the repository.
### Network utilities
* `!dns <hostname>`
* `!rdns <ip address>`
Cause the bot to look up DNS records and respond appropriately.
