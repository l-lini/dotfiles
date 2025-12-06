{ ... }:

{
	imports = [ ../shared/default.nix ];

	programs.git = {
		enable = true;
		settings.user = {
			name = "Lini";
			email = "no@thanks.com";
		};
	};
}
