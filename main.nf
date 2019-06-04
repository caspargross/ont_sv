#!/usr/bin/env/ nextflow
fast5folder = params.input
id = "testID"

process basecall_flappie {
// Use flappie to do flip-flop basecalling on files

    input:
    set id, fast5folder 

    output:
    set id,  assembly, file('reads_filtered.fastq') into samples_filtered

    script:
    """
    flappie ${fast5folder} > basecalled.fastq
    """"
}

