{ devPkgs ? import <nixpkgs> {} }:

devPkgs.mkShell {

  packages = [ devPkgs.cargo devPkgs.rustc devPkgs.rustup devPkgs.rustlings ];

  inputsFrom = [ ];

  shellHook = ''
    echo "welcome to the shell!"
  '';
}
