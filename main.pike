import Getopt;

int main(int argc, array(string) argv)
{
	foreach(find_all_options(argv, ({
		({ "version", NO_ARG, ({ "-v", "--version" }) }),
		({ "license", NO_ARG, ({ "--license" }) })
		})), mixed option)
	{
		switch(option[0])
		{
			case "version":
				output_version();
				break;
			case "license":
				output_license();
		}
	}
}

void output_version() {
	 write("Version 0.0\n");
}

void output_license() {
	Stdio.File license_file = Stdio.File();
	license_file->open("LICENSE", "r");
	write(license_file->read());
	license_file->close();
}
