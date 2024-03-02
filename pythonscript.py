import pandas as pd
import glob
import os

input_path = '/home/hlai8/Desktop/DE-firstproject/download'
output_path = '/home/hlai8/Desktop/DE-firstproject/output'
file_pattern = '*.csv'

print('Extracting files')
csvs = glob.glob(os.path.join(input_path,file_pattern))
dataframes=[pd.read_csv(c) for c in csvs]
#for c in csvs:
    #dataframes=dataframes.append(pd.read_csv(c))

print('Concating')
concatedfiles = pd.concat(dataframes,axis=0,ignore_index=True)

print('Exporting new files')
concatedfiles.to_csv(os.path.join(output_path,"all-years.csv"),index=False)
