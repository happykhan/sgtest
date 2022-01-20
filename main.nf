
/* 
 
*/

/* 
 *   Input parameters 
 */
nextflow.enable.dsl = 2
params.input = "$baseDir/nano/*_R{1,2}.fastq.gz"
params.outdir = "$baseDir/sgtest"




// if (params.input) { ch_input = file(params.input) } else { exit 1, 'Input samplesheet not specified!' }


        
// prints to the screen and to the log
log.info """
         Denovo Pipeline (version 5)
         ===================================
         reads directory: ${params.reads}
         outdir       : ${params.outdir}
         """
         .stripIndent()


/*
  Modules
*/

include { PERISCOPE } from './modules/periscope'

// reads = Channel
//         .fromFilePairs(params.reads, checkIfExists: true)

reads = Channel
    .fromPath(params.input)
    .splitCsv(header:true)
    .map{ row-> tuple(row.sample, file(row.r1), file(row.r2)) }

 
workflow {

    PERISCOPE(reads)
 
}