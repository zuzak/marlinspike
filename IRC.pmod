class IRC {
	Stdio.File socket=Stdio.File();
	string server;
	string nick;
	int port;

	int init(string s, int p, string n) {
		server = s;
		nick = n;
		port = p;
		write("Connecting to %s...", server);
		connect();
		signal(signum("SIGINT"), on_sigint);
		read(); // this won't return!
	}

	Stdio.File connect() {
		array host = Protocols.DNS.client()->gethostbyname(server);
		string curr;
		foreach(host[1], string curr) { // loop through pool
			array rdns = Protocols.DNS.client()->gethostbyaddr(curr);
			if (rdns[0] != 0) {
				write("\rConnecting to %s...", rdns[0] );
			} else {
				write("\nConnecting to %s (%s)...", server, curr);
			}
			if (!socket->connect(curr, port)) {
				write(" failed (%s)\n", strerror(socket->errno()));
			} else {
				write(" waiting for response...");
				server = curr;
				send(sprintf("USER %s 0 * :%s", nick, .miscellany.get_version() ));
				send(sprintf("NICK %s\r", nick ));
				send("JOIN ##zuzakistan-lab" );
				break;
			}
		}
		if (!socket.is_open()) {
			werror("Unable to connect.\n");
			return 0;
		} else {
			//socket.set_nonblocking();
		}
	}

	int read() { // I don't like this
		string buffer = "";
		while(socket.is_open()) {
			string curr = socket.read();
			if ( curr != 0 ) {
				buffer = buffer + curr;
				array data = buffer / "\r\n";
				if ( data[-1] != '\n' ) {
					data = Array.pop(data);
					buffer = data[0];
					data = data[1];
					foreach(data, string datum) {
						parse(datum);
					}
				}
			}
		}
	}

	void parse(string datum) {
		// need to parse the string
		// string format is defined in rfc 2812
		int prefixEnd, suffixStart;
		mapping message = ([]);
		if(datum[0] == ':') { // there is a prefix
			prefixEnd = search(datum, " ");
			message->prefix = datum[1..prefixEnd];
		}
		suffixStart = search(datum, " :");
		if (suffixStart != 0) {
			message->body = datum[suffixStart + 2..];
		} else { // put at end
			suffixStart = sizeof(datum);
		}
		//suffixStart = sizeof(datum) - suffixStart;
		prefixEnd = prefixEnd + 1;
		string|array params;
		if (suffixStart != -1) {
			params = datum[prefixEnd..suffixStart];
		} else {
			params = datum[prefixEnd..];
		}
		if ( params == "" ) {
			write("-ø- |%s|\n",datum);
			write("    `> Prefix end: %d; suffix start: %d", prefixEnd, suffixStart);
			if ( prefixEnd > suffixStart ) {
				write(" !!!\n");
			} else {
				write("\n");
			}
			return;
		}
		params = params / " ";
		params = Array.shift(params);
		message->command = params[0];
		message->params = params[1];
		message->raw = datum;

		if ( message->command == "PING" ) {
			// special case, do handling here
			send("PONG :%s" + message->body);
		} else {
			process(message);
		}

	}

	void process(mapping message) {
		// this should be overwritten by the inheriting class
		write("IRC | %s\n", message->raw);
		werror("No inheriting class!");
		return;
	}

	int send(string msg) {
		socket.write(msg + "\r\n");
	}

	int say(string to, string msg) {
		send(sprintf("PRIVMSG %s :%s", to, msg));
	}

	void on_sigint(int sig) {
		werror("\nSent quit command...\n");
		send(sprintf("QUIT :Received %s", signame(sig)));
	}
}
