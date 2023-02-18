{
  description = "Basic shadow-cljs/node.js environment";

  inputs.nixpkgs.url = "nixpkgs";

  outputs = { self, nixpkgs, ... }:
    let shell = { system ? "x86_64-linux" }:
        # Kinda ugly? Dunno how to do it without let - in
        let pkgs = import nixpkgs { system = system; };
        in pkgs.mkShell {
        buildInputs = with pkgs; [ nodejs openjdk ];
        shellHook = ''
          if command -v fish > /dev/null
            then fish && exit
          fi
        '';
      };
    in
    {
      devShell.x86_64-linux = shell { system = "x86_64-linux"; };
      devShell.x86_64-darwin = shell { system = "x86_64-darwin"; };
    };
}
