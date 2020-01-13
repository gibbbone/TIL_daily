# TODO
`postit.sh`

- `-s` : "simple mode", do not add a full post but just a new section to add notes fastly
- `cat`ing from terminal to the script



`setup_postit.sh`

- set editor of choice in the config parameters
- set upstream git folder and merge with it
  - port your notes from one workstation to another
- create a switch to skip some stage of the setup (at the moment you can safely launch the setup only from the default folder)



# DONE

V 1.2

- add CLI arguments to
  - just modify today note (i.e without adding another one) `[X]`
  - open last note in a markdown viewer `[X]`
    - work only on Windows for the moment
  - git shortcut: merge + add + commit + push `[X]` 
- set execution attributes of the bash command `[X]`
- `-d` : open note from d days before `[X]` 
- `-D` : do a `grep` search on the notes and open the first matching file
- configuration:
  - create notes and personal folders
  - initiate git repositories
  - register commands 
  - set starting folder



# Ideas

- how to stitch together different markdown files?
  - a for loop with cat?
    - must respect order: easy with dates
  - `mdmerge`
- Rewrite everything as a prompt_toolkit app (probably too ambitious)

