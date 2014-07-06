# bookmark-cli

This is an extremely simple tool for use in shell scripting. It allows you to convert a filename into bookmark data using the Cocoa APIs, returning a base64-encoded string that you can store. You can then locate the referenced file using that string, even if it's been renamed or moved.

## Usage:

example:

    $ BOOKMARK=$(bookmark save filename.ext)
    $ mv filename.ext filename.bak
    $ bookmark find "$BOOKMARK"

In a script, capture the response of `bookmark save ...` and save it instead of a filename in an object and be able to restore it no matter where it goes. Within reason, of course.
