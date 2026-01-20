# RobinCLI

A useful toolkit of CLI binaries for common tasks.

## Binaries Included

- `generate-env`: Generates a `.env` file from Kubernetes secrets ending in `-creds`.
- `kill-port`: Quickly kills a process running on a specific port.
- `base64decode`: Decodes a base64 string from the terminal.
- `clean-url`: (Description based on common functionality or assumed need) Cleans or normalizes URLs.
- `list`: (Description based on common functionality) Lists items, potentially with customization.

## Installation

To install these binaries so they are accessible from anywhere in your terminal, run the installation script:

```bash
./install.sh
```

By default, it installs to `~/.local/bin`. You can specify a different directory if needed:

```bash
./install.sh ~/bin
```

### Requirements

- `kubectl` (for `generate-env`)
- `jq` (for `generate-env`)
- `base64` (for `base64decode` and `generate-env`)
- `git` (if using within a git repository)

## Development

The binaries are located in the `bin/` directory.

### Adding a new binary

1. Add your script to the `bin/` directory.
2. Ensure it has a shebang (e.g., `#!/bin/bash`).
3. Run `./install.sh` to update the symlinks.
