# Command dump - Sep. 2022

The longer you use them, the oftener you forget them.

---

- Find all file with dimension lower than 4kb and print their name and dimension:
```bash
find <folder_name/file_glob> -type f -size -4096c -print0 | xargs -0 ls -lh |  awk '{print $5, $9}'
```
Useful to: check logfiles and results file why a script is running. 

- Launch Jupyter notebook in the background, without browser, on a specific port:
```bash
nohup jupyter notebook --no-browser --port=5678 &
```
Useful to: ssh to jupyter on a remote server

- Connect to server and forward to local port:
```bash
ssh -L <port number>:localhost:<port number>  <username>@<server name or IP>
```

Useful to: open jupyter on your local machine

- Get running list of jupyter notebooks
```bash
jupyter notebook list
```
If this doesn't work and you need the token:
```bash
# Get folder with notebook details
jupyter --runtime
# sort by most recent
ls -t -l 
```
Then inspect the corresponding JSON files

