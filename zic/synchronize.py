import os, pathlib

Phone = '/run/user/28050/gvfs/mtp\:host\=Xiaomi_Redmi_Note_11_5c1e757/Internal\ shared\ storage'
if not os.path.isdir(Phone):
    Phone = os.path.join('/run', 'user')
    Phone = os.path.join(Phone, os.listdir(Phone)[0], 'gvfs')
    Phone = os.path.join(Phone, os.listdir(Phone)[0])
    Phone = os.path.join(Phone, os.listdir(Phone)[0])

# look for the FLstudio folder on the phone
FLM = os.path.join(Phone, 'Android', 'data', 'com.imageline.FLM', 'files')

audacity_folder = os.path.join(os.path.expanduser('~'), 'Music', 'Audacity')
flstudio_folder = os.path.join(os.path.expanduser('~'), 'Music', 'FLM-files')
recordings_folder = os.path.join(os.path.expanduser('~'), 'Music', 'Recordings')
samples_folder = os.path.join(os.path.expanduser('~'), 'Music', 'Samples')
tracks_folder = os.path.join(os.path.expanduser('~'), 'Music', 'Tracks')
songs_folder = os.path.join(os.path.expanduser('~'), 'Music', 'Songs')

# let's look at the Audacity folder and create this folder in all
for f in os.listdir(audacity_folder):
    for root in [flstudio_folder, samples_folder, songs_folder]:
        pathlib.Path(os.path.join(root, f)).mkdir(parents=True, exist_ok=True)


