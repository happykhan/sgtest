process PERISCOPE {
 
    conda '/home/ubuntu/miniconda3/envs/periscope'

    tag "$sample_id"
    label 'process_medium'

    publishDir "$params.outdir/periscope/$sample_id", 
      //  pattern: "*human*gz",
        mode: 'copy'

    input:
    tuple val(sample_id), path(r1), path(r2)  
    
    output:
    path("${sample_id}.bam"), emit: bam
    path("${sample_id}.bam.bai"), emit: bai
    path("${sample_id}_header.txt"), emit: header    
    path("${sample_id}_periscope_amplicons.csv"), emit: amplicons
    path("${sample_id}_periscope_counts.csv"), emit: count
    path("${sample_id}_periscope_novel_counts.csv"), emit: novel_counts

    script:
    """
    periscope  --fastq ${r1} ${r2} \\
    --output-prefix ${sample_id} \\
    --sample ${sample_id} \\
    --technology illumina \\
    -t ${task.cpus} \\
    --artic-primers V4 \\    
    """  
}  
