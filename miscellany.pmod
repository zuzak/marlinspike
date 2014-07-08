string get_version() {
	string ver = "0.0";
	string git = get_commit();
	if (git) {
		string url = get_github_url("zuzak/marlinspike/commit/" + git);
		if (url == 0) {
			url = "https://github.com/zuzak/marlinspike";
		}
		int status = get_status();
		if (status == 1) {
			git = git + "+";
		}
		return sprintf("Marlinspike %s (%s) · %s", ver, git, url);
	} else {
		return sprintf("Marlinspike %s · %s", ver, "https://github.com/zuzak/marlinspike");
	}
}

void output_license() {
	Stdio.File license_file = Stdio.File();
	license_file->open("LICENSE", "r");
	write(license_file->read());
	license_file->close();
}
string get_commit() {
	string commit = Process.popen("git rev-parse --short HEAD");
	return (commit / "\n")[0]; // strip \n from end
}
int get_status() {
	string status = Process.popen("git status -s");
	if (status != 0) {
		return 1;
	} else {
		return 0;
	}
}

string get_github_url(string url) {
	url = "https://github.com/" + url;
	array query = Protocols.HTTP.post_url("http://git.io", (["url": url]))->cast("array");
	return query[0]->location;
}
