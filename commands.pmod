import .IRCBot;
void handle_pm(IRCBot bot, string to, string from, string body, string raw) {
	if ( body[0] != '!' ) {
		return;
	}
	switch(body[1..]) {
		case "ping":
			bot.say(to,"!pong");
			break;
		case "botsnack": // the classics never go out of style
			bot.say(to,"Yum!");
			break;
	}
}
