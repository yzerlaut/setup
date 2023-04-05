# Set up of Music Production environment

## Synchronize Phone and Laptop


1. mount your phone via MTP (choose MTP)
    ```
    jmtpfs ~/phone
    ```

    N.B. on KDE, the kiod thing blocks any other app to use the mtp devices, you can fix this with the nasty fix: `chmod 000 /usr/lib/x86_64-linux-gnu/qt5/plugins/kf5/kiod/kmtpd.so` 

2. run the synchronization script:
    ```
    python ~/work/setup/zic/synchronize.py
    ```

## Audacity Settings
`
## Ardour setting

- add [Alt+v] as a shortcut to the "virtual keyboard"
