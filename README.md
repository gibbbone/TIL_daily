# TIL daily
This is what happens when you don't have time to organize your notes but you need some place to dump them because you keep forgetting stuff: a big dump of markdown files stitched together.



## Usage

To jot down notes easily I use a Bash script (`postit.sh`). If called without arguments it automatically opens a single preformatted note for every day of the week. It then adds a new post section every time you call it, hence you keep updating the same file everyday instead of opening a new file for each note.

The script then accept the following arguments:

- `-r`: "read mode", display the last note in your default Markdown viewer/editor
- `-z`: "modify mode", edit the last note instead of adding a post to it
- `-c`: "commit mode", commit everything in the folder with one click. Poor man backup.

The script is in the `bin` folder of my system, hence I can call it from everywhere and it saves notes always in the same folder.

