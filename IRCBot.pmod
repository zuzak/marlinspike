import .IRC;
class IRCBot {
	inherit IRC;
	/*
	int init(string s, int p, string n) {
		::init(s, p, n);
	}*/
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
				write(" connected!\n%s\n\n", msg->body);
				break;
			case "NOTICE":
			case "PRIVMSG":
				.commands.handle_pm(this, msg->params[0], msg->prefix, msg->body, msg->raw);
			default:
				break;
				write("%-.3s || %.73s\n",msg->command,msg->raw);
		}
	}
}
