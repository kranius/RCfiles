function FindProxyForURL(url, host) {
	
	if (isInNet(host, "10.0.0.0", "255.0.0.0")) { return "DIRECT"; }
	if (isInNet(host, "127.0.0.1", "255.255.255.255")) { return "DIRECT"; }
	
	if (dnsDomainIs(host,"localhost")) { return "DIRECT"; }
	if (dnsDomainIs(host,"email.accenture.com")) { return "DIRECT"; }
	if (dnsDomainIs(host,"webmail.hosteam.fr")) { 	return "DIRECT"; }
	
	return "PROXY 10.4.119.1:3128";
}
