import .IRC;
import .User;
class IRCBot {
	inherit IRC;
	/*
	int init(string s, int p, string n) {
		::init(s, p, n);
	}*/
	int messageCount;
	int connected;
	void process(mapping msg) {
		/* msg:
			prefix - string
			body (string)
			command (string)
			params (array)
			raw (string)
		*/
		switch( msg->command ) {
			case "001": // WELCOME
				write(" connected!\n%s\n", msg->body);
				signal(signum("SIGINT"), ::on_sigint);
				connected = 1;
				break;
			case "PING":
				send(sprintf("PONG :%s", msg->body));
				break;
			case "QUIT":
				if(getNickFromHostmask(msg->prefix) == nick) {
					werror("Client exited (%s)\n",msg->body);
					exit(1);
				}
				break;
			case "PRIVMSG":
				.commands.handle_pm(this, msg->params[0], msg->prefix, msg->body, msg->raw);
				break;
			default:
				//write("%-.3s || %.73s\n",msg->command,msg->raw);
				break;
		}
		messageCount = messageCount + 1;
		if (connected != 0) {
			write("\rProcessed %3d messages", messageCount);
		}
	}
}
