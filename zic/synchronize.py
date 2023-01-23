import os, pathlib, shutil

################
##   phone    ##
################
Phone = '/run/user/28050/gvfs/mtp\:host\=Xiaomi_Redmi_Note_11_5c1e757/Internal\ shared\ storage'
if not os.path.isdir(Phone):
    Phone = os.path.join('/run', 'user')
    Phone = os.path.join(Phone, os.listdir(Phone)[0], 'gvfs')
    Phone = os.path.join(Phone, os.listdir(Phone)[0])
    Phone = os.path.join(Phone, os.listdir(Phone)[0])

# look for the FLstudio folder on the phone
FLM = os.path.join(Phone, 'Android', 'data', 'com.imageline.FLM', 'files')

################
##   laptop   ##
################

Laptop = os.path.join(os.path.expanduser('~'), 'Music')
audacity_folder = os.path.join(Laptop, 'Audacity')
flstudio_folder = os.path.join(Laptop, 'FLM-files')
recordings_folder = os.path.join(FLM, 'My Recordings')
tracks_src_folder = os.path.join(Laptop, 'Tracks')
tracks_dest_folder = os.path.join(FLM, 'My Tracks')
# recordings_folder = os.path.join(os.path.expanduser('~'), 'Music', 'Recordings')


# recordings_folder = os.path.join(os.path.expanduser('~'), 'Music', 'Recordings')
samples_folder = os.path.join(Laptop, 'Samples')
# tracks_folder = os.path.join(os.path.expanduser('~'), 'Music', 'Tracks')
songs_folder = os.path.join(os.path.expanduser('~'), 'Music', 'Songs')

# let's look at the content of the Audacity folder and create the song folders in all
for song in os.listdir(audacity_folder):
    for root in [flstudio_folder, recordings_folder, samples_folder, songs_folder,
                 tracks_src_folder, tracks_dest_folder]:
        pathlib.Path(os.path.join(root, song)).mkdir(parents=True, exist_ok=True)

for song in os.listdir(audacity_folder):
    # tracks from Laptop to Phone
    for track in os.listdir(os.path.join(tracks_src_folder, song)):
        shutil.copyfile(os.path.join(tracks_src_folder, song, track),
                        os.path.join(tracks_dest_folder, song, track))




