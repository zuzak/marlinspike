class Bot
{

	int init(string server, int port, string nick) {
		write("Connecting to %s:%d as %s...\n", server, port, nick);
		if (Stdio.File socket = connect(server, port, nick)) {
			//listen(socket);
			return 0;
		} else {
			return 1;
		}
	}

	Stdio.File connect(string server, int port, string nick) {
		Stdio.File socket=Stdio.File();
		array host = Protocols.DNS.client()->gethostbyname(server);
		string curr;
		foreach(host[1], string curr) { // loop through pool
			write("Connecting to %s...", Protocols.DNS.client()->gethostbyaddr(curr)[0] );
			if (!socket->connect(curr, port)) {
				write(" failed (%s)\n", strerror(socket->errno()));
			} else {
				write(" ok!\n");
				server = curr;
				break;
			}
		}
		if (!server) {
			werror("Unable to connect.\n");
			return 0;
		} else {
			socket.write( "NICK %s\r\n", nick );
			socket.write( "USER %s %s - %s", "pike", server, .miscellany.get_version() );
			return socket;
		}
	}
}
