{ ... }:

{
	imports = [ ../shared/default.nix ];

	programs.git = {
		enable = true;
		settings.user = {
			name = "lini";
			email = "no@thanks.com";
		};
	};
}
