{
  description = "";

  inputs.nixpkgs.url = "github:nixos/nixpkgs";

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      packages.x86_64-linux.default = pkgs.stdenv.mkDerivation {
        pname = "ttype";
        version = "v1.1.0";

        src = ./.;

        buildInputs = [ pkgs.bash pkgs.nodejs_20 ];

        buildPhase = "bash ./scripts/build.sh";

        installPhase = ''
          mkdir -p $out/bin
          cp ./build/ttype-x86_64 $out/bin/ttype
          chmod +x $out/bin/ttype
        '';

        cleanPhase = "bash ./scripts/clean.sh";
      };

      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = [ pkgs.gcc pkgs.gnumake ];
      };
    };
}
