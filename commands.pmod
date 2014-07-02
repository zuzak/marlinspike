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
		case "say":
			bot.say(to,body[5..]);
			break;
		case "src":
			bot.say(to,sprintf("%s: https://github.com/zuzak/marlinspike", from));
			break;
		case "rdns":
			bot.say(to,rdns(body[6..]));
			break;
	}
}

string rdns(string host) {
	string ret = host + " →";
	array hosts = Protocols.DNS.client()->gethostbyname(host);
	foreach(hosts[1], string curr) {
		array rdns = Protocols.DNS.client()->gethostbyaddr(curr);
		if(rdns[0] != 0) {
			ret = ret + " " + rdns[0];
		} else {
			ret = " " + curr;
		}
	}
	return ret;
}


