string getNickFromHostmask(string hostmask) {
	// MC8!~zu@wikimedia/microchip08
	array split = hostmask / "@";
	string ident = split[0];
	return (ident / "!")[0];
}
