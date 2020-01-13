*Warning: this is a work-in-progress. Probably it will not work on your machine.*

# TIL daily

When you don't have time to organize your notes but you need a fast way to dump them:

- `postit.sh`: single command which adds a notes on a daily markdown post in a given folder 
- & some other fancy features:  
  - commit everything with one command
  - modify previous notes
  - private notes

 The result is a big  folder of markdown files barely stitched together. 



## Basic usage

`postit.sh` 

- create a file for the current day or opens it if it already exists
- add a new post section with title, tags and some useful stuff

The command is registered as a system command in the setup with a given target folder, so that you can invoke it from everywhere.



## Other features

The script accepts the following arguments:

#### Modification 

- `-r`: "read mode", display the last note in your default Markdown viewer/editor
- `-z`: "modify mode", edit the last note instead of adding a post to it
- `-c`: "commit mode", commit everything in the folder with one click and push it upstream. Poor man backup. The default commit message is  just the current day.

#### Search

- `-d`: open file from `d` days before, or yesterday file if no argument is given
- `-D`: open file which matches  `D` regex (via `grep`) , or yesterday file if no argument is given

TIP: to get a list of all the notes by day just run `grep -r "### *"`

#### Setup

- `-s`:  rerun the setup script. Useful if you want to modify the target folder or the `postit.sh` script. 

#### Private notes mode

- `-p`: by default notes are pushed to an upstream git folder, which you can choose to leave public. The assumption here is that these notes could be safely converted in blog posts (hence the markdown format), as developer diaries. 

  On the contrary, if you want some notes to be private, by default a `personal` folder is set up in the target folder which commits to a separate git repository and is *never pushed upstream* (TODO: push to private repo).

  All the other commands, when `-p` is used, work as before with the `personal` folder as target.



# Setup

Download the `postit.sh` and `setup_postit.sh` scripts in a folder. Run `bash setup_postit.sh` for the default installation. 

By default the setup script does the following:

1. registers the current folder as target in a config file (optional)
2. creates the `notes` and `personal` folders in the target folder
3. initiates two separate `git` repository in the two above folders (optional)
4. register `postit.sh` as a system wide command (optional)
   1. here the customized procedure allow non sudoers to use the script without any hussle
5. TODO: registers the current editor to make posts (optional). For the moment I have just used mine (micro)
6. TODO: set upstream git folders

Optional elements can be customized by running the script with the`-u` switch. TODO: allow setting the options separately. 