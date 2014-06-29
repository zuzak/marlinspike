string get_version() {
	 return "Pikebot - Version 0.0";
}

void output_license() {
	Stdio.File license_file = Stdio.File();
	license_file->open("LICENSE", "r");
	write(license_file->read());
	license_file->close();
}
