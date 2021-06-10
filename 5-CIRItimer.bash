
#!/bin/bash
names=`ls`
#env:STAR
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
######################################################################
#### CIRI-full_v2 https://sourceforge.net/projects/ciri/files/CIRI2/
#env: STAR
#进行过修正，成功
mkdir ${name}_CIRI
cd ${name}_CIRI
$bwa mem -t 4 $bwa_index ../clean${name}_1.fq ../clean${name}_2.fq > ./${name}.bwa.sam
perl $ciri -T 8 -I ./${name}.bwa.sam -F $genome  -A /together_sdb/zhoujiaqi/index/gencode.v22.annotation.gtf -G ./${name}.log -O ./${name}.CIRI.txt
cd /together_sdb/zhoujiaqi/rawdata
done