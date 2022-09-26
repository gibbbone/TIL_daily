# Command dump - Sep. 2022
The longer you use them, the oftener you forget them.

- Find all file with dimension lower than 4kb and print their name and dimension:
```
find <folder_name/file_glob> -type f -size -4096c -print0 | xargs -0 ls -lh |  awk '{print $5, $9}'
```
Useful to: check logfiles and results file why a script is running. 

- Launch Jupyter notebook in the background, without browser, on a specific port:
```
nohup jupyter notebook --no-browser --port=5678 &
```
Useful to: ssh to kupyter on a remote server

- Connect to server and forward to local port:
ssh -L 1234:localhost:1234  <username>@<server name or IP>
Useful to: open jupyter on your local machine
