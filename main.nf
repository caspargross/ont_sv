#!/usr/bin/env/ nextflow
fast5folders_ch = Channel.from([['test1', '/mnt/SRV018/projects/external/promethion/basecall_test/']])

params.nreads = 10000

process basecall_flappie {
// Flappie is not able to use current multi-read Fast5 files. Use ont-fast5-api to convert single to multi fast5

    input:
    set id, folder from fast5folders_ch

    output:
    set id, file('**/*.fast5') into multi_fast5_ch

    script:
    """
    multi_to_single_fast5 -i ${folder} -s \$(pwd) -t ${task.cpus} --recursive
    ls -d */ | parallel -p ${task.cpus} -X flappie > ${id}_flipflop.fastq
    """
}

multi_fast5_ch
	.map{it[1]}
	.view()
	.set{multi_fast5_separate_ch}

process basecall_flappie {
// Use flappie to do flip-flop basecalling on files
    publishDir "${params.outDir}/flipflop/", mode:'copy'	
   
    input:
    set id, fast5 from multi_fast5_separate_ch

    output:
    file("${id}_flipflop.fastq")

    script:
    """
    echo ${fast5} | tr -d [], | parallel -p ${task.cpus} -X flappie > ${id}_flipflop.fastq
    """
}

