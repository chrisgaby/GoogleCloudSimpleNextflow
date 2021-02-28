params.index = "gs://usda-salmonella-data-extracts/dataInputs/entericaSRAAccessions.txt"

params.project = "SRR12660755"

params.resultdir = 'results'

projectSRId = params.project


int threads = Runtime.getRuntime().availableProcessors()



process getSRAIDs {
		
	publishDir params.resultdir, mode: 'copy'

	cpus 1

	input:
	path 'accIDs' from params.index
	val projectID from projectSRId
	
	output:
	file 'sra.txt' into sraIDs
	
	script:
	"""
	tail accIDs -n +2 > sra.txt
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

process mashSketch {

	publishDir params.resultdir, mode: 'copy'

	cpus threads 

	input:
	file read from reads
	

	output:
	file '*.msh' into publishDir 
	
	script:
	readName = read.toString() - ~/(\.fastq\.gz)?$/
	
	"""
	mash sketch -r -c 30 -s 1000 -k 21 -m 2 -o $readName $read # -p ${task.cpus}
	"""
}
