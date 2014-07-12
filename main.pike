#!/usr/bin/pike
import Getopt;

int main(int argc, array(string) argv)
{
	string server = "irc.freenode.net";
	string nick = "Pikebot" + random(1000);
	int port = 6667;
	string channel;
	foreach(find_all_options(argv, ({
		({ "version", NO_ARG, ({ "-v", "--version" }) }),
		({ "license", NO_ARG, ({ "--license", "--licence" }) }),
		({ "server", HAS_ARG, "--server", "SERVER" }),
		({ "port", HAS_ARG, ({ "--port", "-p" }), "PORT" }),
		({ "nick", HAS_ARG, ({ "--nick", "-n", "--nickname" }), "NICK" }),
		({ "channel", HAS_ARG, ({ "--channel" }), "CHAN" })
		})), mixed option)
	{
		switch(option[0])
		{
			case "version":
				write( "%s\n", .miscellany.get_version() );
				return 1;
			case "license":
				.miscellany.output_license();
				return 1;
			case "server":
				server = option[1];
				break;
			case "port":
				port = option[1];
				break;
			case "nick":
				nick = option[1];
				break;
			case "channel":
				channel = option[1];
				break;
		}
	}

	.IRCBot.IRCBot bot = .IRCBot.IRCBot();
	return bot.init(server, port, nick, channel);
}

