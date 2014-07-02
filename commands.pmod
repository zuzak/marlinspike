import .IRCBot;
void handle_pm(IRCBot bot, string to, string from, string body, string raw) {
	if ( body[0] != '!' ) {
		return;
	}
	array args = (body + " ") / " ";
	switch(args[0][1..]) {
		case "ping":
			bot.say(to,"!pong");
			break;
		case "botsnack": // the classics never go out of style
			bot.say(to,"Yum!");
			break;
		case "src":
			bot.say(to,"https://github.com/zuzak/marlinspike");
			break;
		case "dns":
		case "rdns":
			bot.say(to, rdns(args[1]));
			break;
	}
}
string dns(string host) {
	string ret = host + " → ";
	array rdns = Protocols.DNS.client()->gethostbyaddr(host);
	if(rdns[0] != 0) {
		return ret + rdns[0];
	} else {
		// no rdns, let's go the other way
		array hosts = Protocols.DNS.client()->gethostbyname(host);
		if (Array.count(hosts[1]) == 0) {
			return ret + "not found";
		} else if (Array.count(hosts[1]) == 1) {
			return ret + hosts[1];
		} else {
			foreach(hosts[1], string curr) {
				rdns = Protocols.DNS.client()->gethostbyaddr(host);
				if(rdns[0] != 0) {
					ret = ret + " " + rdns[0];
				} else {
					ret = ret + " " + curr;
				}
			}
			return ret;
		}
	}
}

string get(string url) {
	Protocols.HTTP.Query query = Protocols.HTTP.get_url(url);
	if (query.ok == 0) {
		return sprintf("Could not connect to %s.", url);
	}
	return "ok";
}



