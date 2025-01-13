# Arnis | Nix Flake
This is a flake to install [Arnis](https://github.com/mn6/arnis) on systems using the Nix package manager.

###### (Only tested on x86_64)

## Usage

### Run directly
```sh
nix run github:sammypanda/nixos-arnis
```

### Or install to your system

Add the following in your flake inputs:

```nix
{
    inputs = {
        # the rest of your inputs here

        arnis = {
            url = "github:sammypanda/nixos-arnis";
            inputs.nixpkgs.follows = "nixpkgs";
        }
    };

    # ...
```

...and in outputs you can overlay and add to system or user packages as ``pkgs.arnis``. Or instead just add ``arnis.packages.YOURPLATFORM.default`` to system or user packages without overlaying.

```nix
    # ...

    outputs = { arnis, ... } @ inputs:
    let
        pkgs = import nixpkgs {
            overlays = [self.overlays.default];
        }
    in {
        overlays.default = final: prev: {
            arnis = inputs.arnis.packages.YOURPLATFORM.default;
            # OR 
            # arnis = inputs.arnis.packages."${system}".default;
        }
    }

    # ...
}
```
