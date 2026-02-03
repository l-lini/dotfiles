{ pkgs, secrets, ... }:

{
        programs.git = {
                enable = true;
                config = {
			init.defaultBranch = "main";
			user = {
                        	name = "l-lini";
                        	email = "119787571+l-lini@users.noreply.github.com";
                	};
			credential.helper = "!${pkgs.writeShellScript "git-cred" ''
				echo "username=l-lini"
				echo "password=${secrets.github}"
			''}";
		};
        };
}
# Git default pull/push with current branch
# Git default pull with rebase
