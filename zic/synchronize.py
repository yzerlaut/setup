"""

```
jmtpfs ~/phone
```

"""
import os, pathlib, shutil

################
##   phone    ##
################
# Phone = '/run/user/1000/gvfs/mtp\:host\=Xiaomi_Redmi_Note_11_5c1e757/Internal\ shared\ storage'
# if not os.path.isdir(Phone):
    # Phone = os.path.join('/run', 'user')
    # Phone = os.path.join(Phone, os.listdir(Phone)[0], 'gvfs')
    # Phone = os.path.join(Phone, os.listdir(Phone)[0])
    # Phone = os.path.join(Phone, os.listdir(Phone)[0])
Phone_root_path = os.path.join(os.path.expanduser('~'), 'phone')
Phone = os.path.join(Phone_root_path, 
                     os.listdir(Phone_root_path)[0])

# look for the FLstudio folder on the phone
FLM = os.path.join(Phone, 
                   'Android', 'data', 'com.imageline.FLM', 'files')

################
##   laptop   ##
################

Laptop = os.path.join(os.path.expanduser('~'), 'Music')
audacity_folder = os.path.join(Laptop, 'Audacity')
flstudio_folder = os.path.join(Laptop, 'FLstudio')

# let's look at the content of the Audacity folder and create the song folders in all Samples and Tracks 
for song in os.listdir(audacity_folder):
    for root in [os.path.join(Laptop, 'Tracks'),
                 os.path.join(FLM, 'My Tracks'),
                 os.path.join(Laptop, 'Samples'),
                 os.path.join(FLM, 'My Samples')]:
        pathlib.Path(os.path.join(root, song)).mkdir(parents=True, exist_ok=True)

# backup FLM files from Phone to Laptop
for song in os.listdir(os.path.join(FLM, 'My Songs')):
    # tracks from Laptop to Phone
    if os.path.isfile(song):
        print(' saving "%s" [...] ' % os.path.join(FLM, 'My Songs', song))
        shutil.copyfile(os.path.join(FLM, 'My Songs', song),
                        os.path.join(flstudio_folder, 'FLM-files', song))


#######################################
##   "Samples" from Laptop to Phone  ##
#######################################

for song in os.listdir(audacity_folder):
    # tracks from Laptop to Phone
    for track in os.listdir(os.path.join(Laptop, 'FLM', 'Samples', song)):
        shutil.copyfile(os.path.join(Laptop, 'FLM', 'Samples', song, track),
                        os.path.join(FLM, 'My Samples', song, track))

#######################################
##   "Tracks" from Phone to Laptop   ##
#######################################

# in root folder
for track in os.listdir(os.path.join(FLM, 'My Tracks')):
    if os.path.isfile(os.path.join(FLM, 'My Tracks', track)):
        shutil.copyfile(os.path.join(FLM, 'My Tracks', track),
                        os.path.join(Laptop, 'Tracks', track))

# in subfolders
for song in os.listdir(audacity_folder):
    # tracks from Phone to Laptop
    for track in os.listdir(os.path.join(FLM, 'My Tracks', song)):
        shutil.copyfile(os.path.join(FLM, 'My Tracks', song, track),
                        os.path.join(Laptop, 'Tracks', song, track))





