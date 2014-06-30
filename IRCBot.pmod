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
				handle_pm(msg->params[0], msg->prefix, msg->body, msg->raw);
			default:
				break;
				write("%-.3s || %.73s\n",msg->command,msg->raw);
		}
	}
	void handle_pm(string to, string from, string body, string raw) {
		if ( body[0] != '!' ) {
			return;
		}
		array args = body / ' ';
		switch(args[1]) {
			case "ping":
				say(to,"!pong");
				break;
			case "botsnack": // the classics never go out of style
				say(to,"Yum!");
				break;
		}
	}
}
