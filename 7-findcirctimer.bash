

#!/bin/bash
names=`ls`
#env:python2.7
for name in ${names[@]};
do
cd ${name}
####CIRI2,findcirc ,circfinder,CIRCexplorer
genome=/together_sdb/zhoujiaqi/index/GRCh38.p13.genome.fa
ciri=/together_sdb/zhoujiaqi/software/CIRI_v2.0.6/CIRI2.pl
bwa=/together_sdb/zhoujiaqi/software/bwa-0.7.3a/bwa
bwa_index=/together_sdb/zhoujiaqi/index/chr_acfs/GRCh38.p13.genome.fa
bowtie2_index=/together_sdb/zhoujiaqi/index/bowtie2index-beta/bowtie.index
find_circ=/together_sdb/zhoujiaqi/software/find_circ
star_index=/together_sdb/zhoujiaqi/index/star-3-index-beta
circRNA_finder=/together_sdb/zhoujiaqi/software/circRNA_finder
#############################################################
## find_circ https://github.com/marvin-jens/find_circ.git
#有circ的seq！
#bowtie2：version 2.3.5.1
#samtools: 0.1？
#env:python2.7
#需进行修正！！！
mkdir ${name}_find_circ
cd ${name}_find_circ
bowtie2 -p 32 --very-sensitive --phred33 --mm -M20 --score-min=C,-15,0 -x $bowtie2_index -q -1 ../clean${name}_1.fq -2 ../clean${name}_2.fq > ${name}.beta.bowtie2.sam 2> bowtie2.beta.log
samtools sort -@ 32 -o ${name}.bowtie2.bam ${name}.beta.bowtie2.sam
samtools view -hf 4 ${name}.bowtie2.bam | samtools view -Sb - > ${name}_unmapped_bowtie2.bam
$find_circ/unmapped2anchors.py ${name}_unmapped_bowtie2.bam > ${name}_anchor.fastq
bowtie2 -p 8 --score-min=C,-15,0 --reorder --mm -q -U ${name}_anchor.fastq -x $bowtie2_index > ${name}.anchor.bowtie2.sam 2> bowtie2.second.anchor.log
cat ${name}.anchor.bowtie2.sam | $find_circ/find_circ.py -G $genome -p ${name} -s ./${name}.sites.log > ./${name}.sites.bed 2> ./${name}.sites.reads
cd /together_sdb/zhoujiaqi/rawdata
done