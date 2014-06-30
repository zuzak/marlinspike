import .IRC;
class IRCBot {
	inherit IRC;
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
			case "PRIVMSG":
				handle_pm(msg->params[0], msg->prefix, msg->body, msg->raw);
			default:
				break;
				write("%-.3s || %.73s\n",msg->command,msg->raw);
		}
	}
	void handle_pm(string to, string from, string body, string raw) {
		if ( body == "!ping" ) {
			say(to,"!pong");
		}
	}
}
