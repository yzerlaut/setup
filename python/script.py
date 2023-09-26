""" documentation for this file is written at the end
 (use of argparse) """
import numpy as np
import matplotlib.pylab as plt
import os, sys, time
sys.path.append('../../common_libraries/')
from data_analysis import fourier_for_real
import sys, pathlib
sys.path.append(str(pathlib.Path(__file__).resolve().parents[1]))

# some functions
def generate_white_noise(mean, std, nsample=100):
    return mean+std*np.random.randn(nsample)

# CORE function to be run
def run():
    z = np.log(np.abs(generate_white_noise(args.mean, args.std,\
                                           nsample=args.n)))
    print(time.strftime("%c"))
    Z = []
    for i in range(10):
        Z.append(generate_white_noise(\
            args.mean+10*i, args.std, nsample=args.n))
    np.savez(args.filename, args=args, date=time.strftime("%c"),\
             script=os.path.abspath('./')+'/'+__file__,\
             z=z, Z=Z, plot=get_plotting_instructions())


def get_plotting_instructions():
    return """
args = data['args'].all()
sys.path.append('../../')
from common_libraries.graphs.my_graph import set_plot
fig, ax = plt.subplots(figsize=(5,3))
plt.subplots_adjust(left=.2,bottom=.2)
plt.hist(data['z'], color='lightgray', edgecolor='k', lw=3)
set_plot(ax, xlabel='xlabel (unit)', ylabel='ylabel (#)')
fig, ax = plt.subplots(figsize=(17,3))
plt.subplots_adjust(bottom=.2)
for z in data['Z']:
    plt.hist(z, lw=3)
set_plot(ax, xlabel='xlabel (unit)', ylabel='ylabel (#)')
"""

# in case not used as a modulus
if __name__=='__main__':
    
    import argparse
    # First a nice documentation 
    parser=argparse.ArgumentParser(description="script description",
                                   formatter_class=argparse.RawTextHelpFormatter)

    parser.add_argument("task",\
        help="""
        Task to be performed, either:
        - run
        - analyze
        - plot
        """, default='plot')
    
    parser.add_argument("--mean",help="mean of the random values",\
                        type=float, default=5.)
    parser.add_argument("--std",help="std of the random values",\
                        type=float, default=10.)
    parser.add_argument("--n",help="number of random events",\
                        type=int, default=2000)
    parser.add_argument("-v", "--verbose", help="increase output verbosity",
                        action="store_true")
    parser.add_argument("-s", "--save", help="save the figures",
                        action="store_true")
    parser.add_argument("-u", "--update_plot", help="plot the figures", action="store_true")
    parser.add_argument("--filename", '-f', help="filename",type=str, default='data.npz')
    args = parser.parse_args()
    

    args_dict = vars(args) # dictionary version of the Namespace
    
    if args.update_plot:
        data = dict(np.load(args.filename))
        data['plot'] = get_plotting_instructions()
        np.savez(args.filename, **data)
    else:
        run()
