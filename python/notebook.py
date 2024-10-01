# ---
# notebook template
# ---

# %% Load Modules
import os
import numpy as np
import matplotlib as mpl
import matplotlib.pylab as plt
mpl_style_sheet = os.path.join(os.path.expanduser('~'), 
                               'work', 'setup', 'python', 
                               'matplotlib_style.py')
if os.path.isfile(mpl_style_sheet):
    plt.style.use(mpl_style_sheet)
mpl.rcParams["figure.facecolor"]='grey'
# mpl.rcParams["figure.dpi"]=100

# %% Plot Some Data
fig, AX = plt.subplots(1, 4, figsize=(7,1.5))
plt.subplots_adjust(wspace=0.5, top=.7, left=.35)
# fig.patch.set_facecolor('tab:grey')
AX[0].imshow(np.random.randn(10,10))
AX[0].set_ylabel('y-label')
AX[1].scatter(np.arange(100), np.random.randn(100))
AX[2].plot(np.arange(100), np.linspace(-1,1,100)**2)
for ax in AX:
    ax.set_title('title')
fig.savefig(os.path.join(os.path.expanduser('~'), 'Desktop', 'fig.png'))

# %% Some Quick Calculations
from numpy import *
def f(x,b=-3):
    return (3 * 0.5*(1-sign(x-b)) + 5 * 0.5*(1+sign(x-b)))

x = np.linspace(-8,8)
plt.plot(x, f(x))

# %%
