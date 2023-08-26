# Murica
A mod for Baldur’s Gate 3 that replaces British English with the far better US English.

[Download the latest version here! (1.1)](https://github.com/ancestral/Murica/releases/download/1.0/Murica1.1.zip)

![Insert overtly patriotic image with an eagle and an American flag.](america.jpg)

## About
I quickly became tired of seeing British spellings. After the umpteenth time seeing “Armour Class”, I decided to take matters into my own hands.

At first, I was skeptical, as it wasn’t a glamorous endeavor, laboring over tons of unforgivable and unsavory words. However, I realized the idea was reconcilable, skillfully utilizing my marvelous judgment.

## Goals
* Provide American spellings of English words instead of their British counterparts.
* Maintain the choice words in the dialogue (dialog?) so it still matches the audio.

## FAQ

#### What is this?
This is a mod that just changes the text in the game to US English spellings.

#### Are there new classes?
No.

#### Is there any new content?
No.

#### I don’t get it. What does this do again?
Words like “armour” and “colour” are now “armor” and “color”. That’s it.

## How to Build
Dependencies:
* Some UNIX commands like `tr`
* Perl 5

Build Instructions:
1. Unpack the `English.pak` file (which is found in the BG3 Data directory) using the [ExportTool](https://github.com/Norbyte/lslib/releases) into a new directory.
2. Convert the `.loca` file to XML.
3. Move or copy the XML file to this directory. (Rename it to `English.xml` if necessary.)
4. Run `translate.sh`. A file named `Murica.xml` will be created.
5. Convert the XML file back to `.loca`.
6. Pack the file back in the proper directory back to `.pak`.

## Notes
The entire mod is just a localization patch for `English.pak`. All the strings in the game are in a localization file. Loading this mod patches, or overwrites the existing strings.

This project is both a record on which strings to change in the localization file, and a compiled `.pak` mod for people to download and install with all the changes.

## Contribute
If you’d like to contribute, you must first pronounce the word “contribute” with the stress on the second syllable. Then create an issue or a pull request. Bonus points if you can identify the “contentuid” of the line to change.

You can also find me on the official [Larian Studios Discord server](https://discord.com/invite/larianstudios) in the Baldur’s Gate 3 modding section.
