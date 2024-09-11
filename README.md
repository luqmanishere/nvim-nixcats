# nvim-nixcats

A neovim config made with nixCats-nvim.

## Usage

This flake has exports for NixOS & Home Manager modules, aswell as standalone packages.
Theoretically, it should also work on Windows and non-NixOS in general, but
this use case is untested.

### Flake Usage

To use in a flake, configure your inputs:

```nix
inputs = {
    nvim-nixcats.url = "github:luqmanishere/nvim-nixcats";
};
```

## Testing

| OS            | Test     |
| ------------- | -------- |
| NixOS         | Works    |
| Windows       | Errors?  |
| MacOS w/ Nix  | Works    |
| Linux w/ Nix  | Works    |
| Linux wo/ Nix | Untested |

I totally did not make that table just to test markdown rendering...

## Credits

- BirdeeHub for [`nixCats-nvim`](https://github.com/BirdeeHub/nixCats-nvim)
- Nix team for Nix
- And the neovim parts to whoever their respective owners
