# bookmark-cli

This is an extremely simple tool for use in shell scripting. It allows you to convert a filename into bookmark data using the Cocoa APIs, returning a base64-encoded string that you can store. You can then locate the referenced file using that string, even if it's been renamed or moved.

## Installation

Installation requires Xcode. Before running the commands below, make sure Xcode is selected for command line use with `sudo xcode-select -s /Applications/Xcode.app`.

1. Clone the repo with
2. Go to the cloned directory
3. Run make

```
git clone https://github.com/ttscoff/bookmark-cli.git
cd bookmark-cli
make
```

## Usage:

example:

    $ BOOKMARK=$(bookmark save filename.ext)
    $ mv filename.ext filename.bak
    $ bookmark find "$BOOKMARK"

In a script, capture the response of `bookmark save ...` and save it instead of a filename in an object and be able to restore it no matter where it goes. Within reason, of course.