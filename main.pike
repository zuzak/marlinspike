#!/usr/bin/pike
import Getopt;

int main(int argc, array(string) argv)
{
	string server = "irc.freenode.net";
	string nick = "Pikebot" + random(1000);
	int port = 6667;
	foreach(find_all_options(argv, ({
		({ "version", NO_ARG, ({ "-v", "--version" }) }),
		({ "license", NO_ARG, ({ "--license", "--licence" }) }),
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
		}
	}

	.IRCBot.IRCBot bot = .IRCBot.IRCBot();
	return bot.init(server, port, nick);
}

