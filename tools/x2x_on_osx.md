# X2X on MacOS

It works! Sort of.

## Using X2X from MacOS

1. Install [XQuartz](https://www.xquartz.org/)
2. Set up your Linux host with X11, x2x, and a SSH server.
3. Add your host to ~/.ssh/config so you can use `ssh myhost` to connect.
4. Open XQuartz. Select in the top menu: Applications -> Terminal
5. Hold option and double-click the bottom right corner of the terminal to make it fullscreen.
6. Make sure the Terminal is focused. Do not click on any other windows or you need to restart x2x.
7. `ssh -YC myhost x2x -north -to :0.0`
8. Move your mouse off the top of the screen and onto your other Linux host!

Known issues:

- If you focus a different window outside XQuartz you will need to restart x2x.

## Installing X2X on MacOS

1. Install [XQuartz](https://www.xquartz.org/)
2. `brew install libxtst automake autoconf`
3. `git clone https://github.com/dottedmag/x2x`
4. `cd ./x2x`
5. `bash bootstrap.sh`
6. `bash configure`
7. `make -j10`
8. Set up your Linux host with X11 and a SSH server.
9. Add your host to ~/.ssh/config so you can use `ssh myhost` to connect.
10. Open XQuartz. Select in the top menu: Applications -> Terminal
11. `cd ./x2x/`
12. `./x2x`
