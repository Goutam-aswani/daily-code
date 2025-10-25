"""
Sample Python script

This module contains a small example function and a CLI entrypoint.
"""

import argparse
import sys


def greet(name: str) -> str:
    """Return a greeting for name."""
    return f"Hello, {name}!"


def main(argv=None) -> int:
    parser = argparse.ArgumentParser(description="Sample script that greets a name")
    parser.add_argument("name", nargs="?", default="World", help="Name to greet")
    args = parser.parse_args(argv)

    print(greet(args.name))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
