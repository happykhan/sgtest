# Read seqeuecing dir and find ARCH. 
import os 

INPUT = '/home/ubuntu/transfer/incoming/QIB_Sequencing/Nextseq_2_runs/211210_NB501061_0113_AHG53CAFX3/deplexed-zero-mismatch/basecall/REACT_V4/'

sample_sheet = open('scripts/samplesheet.csv', 'w')
sample_sheet.write('sample,r1,r2\n')


for x in os.listdir(INPUT):
    if x.endswith('R1_001.fastq.gz'):
        sample_name = x.split('_')[0]
        r1 = os.path.join(INPUT, x)
        r2 = os.path.join(INPUT, x.replace('R1_001', "R2_001"))
        if os.path.exists(r1) and os.path.exists(r2):
            sample_sheet.write(f'{sample_name},{r1},{r2}\n')



# Look in output directory for extra 

