import multiprocessing as mp
import numpy as np
from itertools import product
import zipfile, os, pathlib, sys
import tempfile

class Parallel:
    """
    a class to run parallel simulations of
    an arbitrary function:

        `running_sim_func(a=0, b='long', c=False, ...
                          filename='test.npy')`

    over a multi-dimentsional grid of parameters

    and put all results into a zip file
    """

    def __init__(self,
                 scan_seed=1,
                 filename='data.zip',
                 temp_folder=tempfile.gettempdir()):

        np.random.seed(scan_seed)
        self.temp_folder=temp_folder
        self.PARAMS_SCAN = None

        self.filename = filename
        self.basename = os.path.basename(filename).replace('.zip', '')
        self.scan_file = os.path.join(self.temp_folder,
                                        self.basename+'_scan.npy')

    def build_filename_single_sim(self, KEYS, VAL):
        FN = self.temp_folder+os.path.sep+self.basename
        for key, val in zip(KEYS, VAL):
            FN += '_'+key+'_'+str(val)
        FN += '_'+str(np.random.randint(100000))+'.npy'
        return FN


    def build(self, KEYS, VALUES):
        """ 
        build the set of simulations with their filenames !
        """
        self.PARAMS_SCAN = {'filenames':[], 'keys':KEYS}
        self.KEYS = KEYS
        for key in self.KEYS:
            self.PARAMS_SCAN[key] = []

        for VAL in product(*VALUES):
            # params for each sim
            for key, val in zip(KEYS, VAL):
                self.PARAMS_SCAN[key].append(val)
            # with a given filename
            self.PARAMS_SCAN['filenames'].append(\
                    self.build_filename_single_sim(KEYS, VAL))

    def run(self, running_sim_func,
            parallelize=True,
            fix_missing_only=False,
            Nmax_simultaneous_processes=None):

        if self.PARAMS_SCAN is not None:

            zf = zipfile.ZipFile(self.filename,
                                 mode='w')

            if parallelize:
                PROCESSES = []
                # Define an output queue
                output = mp.Queue()
            else:
                output = None

            def run_func(i, output):
                params = {}
                for key in self.KEYS:
                    params[key] = self.PARAMS_SCAN[key][i]
                params['filename'] = self.PARAMS_SCAN['filenames'][i]
                running_sim_func(**params)
            
            for i, FN in enumerate(self.PARAMS_SCAN['filenames']):
                if parallelize:
                    if fix_missing_only:
                        if not os.path.isfile(FN): # if it doesn't exists !
                            print('running configuration ', FN)
                            PROCESSES.append(mp.Process(target=run_func, args=(i, output)))
                        else:
                            print('configuration DONE: ', FN)
                    else:
                        PROCESSES.append(mp.Process(target=run_func, args=(i, output)))
                else:
                    run_func(i, 0)
             
            if parallelize:
                if Nmax_simultaneous_processes is None:
                    Nmax_simultaneous_processes = int(mp.cpu_count())
                print('parallelizing %i processes over %i cores' % (len(PROCESSES),\
                        Nmax_simultaneous_processes))

                # Run processes
                for i in range(len(PROCESSES)//Nmax_simultaneous_processes+1):
                    for p in PROCESSES[Nmax_simultaneous_processes*i:Nmax_simultaneous_processes*(i+1)]:
                        p.start()
                    # # Exit the completed processes
                    for p in PROCESSES[Nmax_simultaneous_processes*i:Nmax_simultaneous_processes*(i+1)]:
                        p.join()
                    print('multiprocessing loop: %i/%i' % (i, len(PROCESSES)//Nmax_simultaneous_processes))
                    print('   n=%i/%i' % (i*len(PROCESSES), len(PROCESSES)))
                    
            # write all single sim files in the zip file
            for FN in self.PARAMS_SCAN['filenames']:
                zf.write(FN, arcname=os.path.basename(FN))

            # add the scan metadata to the zip
            np.save(self.scan_file, self.PARAMS_SCAN)
            zf.write(self.scan_file, arcname='scan.npy')

            # close the zip file
            zf.close()

        else:
            print(' need to build the simulation with the varied parameters ! ')


    def load(self,
             unzip=True,
             with_data=False):

        zf = zipfile.ZipFile(self.filename, mode='r')
     
        data = zf.read('scan.npy')
        with open(self.scan_file, 'wb') as f:
            f.write(data)

        self.PARAMS_SCAN =  np.load(self.scan_file,
                               allow_pickle=True).item()
        

        if unzip:
            for fn in self.PARAMS_SCAN['filenames']:
                data = zf.read(os.path.basename(fn))
                FN = os.path.join(self.temp_folder, os.path.basename(fn)) 
                with open(FN, 'wb') as f:
                    f.write(data)

        if with_data:
            self.DATA = []
            for fn in self.PARAMS_SCAN['filenames']:
                data = np.load(os.path.join(self.temp_folder, fn),
                               allow_pickle=True).item()
                self.DATA.append(data)

        zf.close()
    
if __name__=='__main__':

    ##################################################
    # the "running_sim_func" should look like that  ##
    ##################################################
    def running_sim_func(SEED=0, 
                         a=0,
                         b=1,
                         c=3,
                         filename='test.npy',
                         delay=0.1):
        """
        it should have the "filename" argument at least
        """
        time.sleep(delay)
        np.save(filename, {'x':np.arange(10)})

    sim = Parallel(filename=\
            os.path.join(tempfile.gettempdir(), 'data.zip'))

    if sys.argv[-1]=='load':

        sim.load(unzip=True, with_data=True)
        print(sim.DATA)

    else:
        # means run !
     
        # build the scan over parameters
        sim.build(['SEED', 'a', 'b'],
                  [np.arange(3), np.arange(5, 8), [True, False]])
        

        import time
        start_time = time.time()
        print('-----------------------------------')
        print(' Without parallelization')
        sim.run(running_sim_func,
                parallelize=False)
        print("--- %s seconds ---" % (time.time() - start_time))        
        print('-----------------------------------')


        start_time = time.time()
        print(' With parallelization')
        sim.run(running_sim_func,
                parallelize=True)
        print("--- %s seconds ---" % (time.time() - start_time))        

        print('')
        print('open now with: `python parallel.py load` ')
