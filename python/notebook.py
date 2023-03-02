# ---
# jupyter:
#   jupytext:
#     formats: ipynb,py:percent
#     text_representation:
#       extension: .py
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.14.0
#   kernelspec:
#     display_name: Python 3 (ipykernel)
#     language: python
#     name: python3
# ---

# %%
import numpy as np
import matplotlib.pylab as plt
import matplotlib as mpl
mpl.rcParams["figure.facecolor"]='lightgrey'
mpl.rcParams["figure.dpi"]=200

# %%
fig, AX = plt.subplots(1, 4, figsize=(7,1.5))
plt.subplots_adjust(wspace=0.5, top=.7, left=.35)
# fig.patch.set_facecolor('tab:grey')
AX[0].imshow(np.random.randn(10,10))
AX[0].set_ylabel('y-label')
AX[1].scatter(np.arange(100), np.random.randn(100))
AX[2].plot(np.arange(100), np.linspace(-1,1,100)**2)
for ax in AX:
    ax.set_title('title')

# %%
