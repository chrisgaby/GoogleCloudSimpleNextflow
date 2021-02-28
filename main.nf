params.star_index = "gs://sra-pub-run-6/SRR12660755/SRR12660755.1"

params.project = "SRR12660755"

params.resultdir = 'results'

projectSRId = params.project


int threads = Runtime.getRuntime().availableProcessors()

process getSRAIDs {
	
	cpus 1

	input:
	val projectID from projectSRId
	
	output:
	file 'sra.txt' into sraIDs
	
	script:
	"""
	esearch -db sra -query $projectID  | efetch --format runinfo | grep SRR | cut -d ',' -f 1 > sra.txt
	"""
}

sraIDs.splitText().map { it -> it.trim() }.set { singleSRAId }

process fastqDump {

	publishDir params.resultdir, mode: 'copy'

	cpus threads

	input:
	val id from singleSRAId

	output:
	file '*.fastq.gz' into reads

	script:
	"""
	parallel-fastq-dump --sra-id $id --threads ${task.cpus} --gzip
	"""	
}

process mash {

	publishDir params.resultdir, mode: 'copy'

	cpus threads # This might not be needed if only one SRA read file is processed on 1 thread at a time?

	input:
	file read from reads
	file index from star_index.collect()

	output:
	file '*.msh' into publishDir # Did I do this right?
	
	script:
	readName = read.toString() - ~/(\.fastq\.gz)?$/
	
	"""
	mash sketch -r -c 30 -s 1000 -k 21 -m 2 -o $readName $read -p ${task.cpus}
	"""
}
