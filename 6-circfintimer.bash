
#!/bin/bash
names=`ls`
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
#################################################################
#### STAR and circ finder
#runstar.pl is edited on "gunzip"
#STAR versionGenome	2.7.0d
#env: STAR
#超久，成功
mkdir ${name}_circ_finder
cd ./${name}_circ_finder
perl $circRNA_finder/runStar.pl --inFile1 ../clean${name}_1.fq --inFile2 ../clean${name}_2.fq --genomeDir $star_index --outPrefix ./${name} 
#samtools view -Sb ${sample}Aligned.sortedByCoord.out.bam > ${sample}Chimeric.out.sam #不可以
perl $circRNA_finder/postProcessStarAlignment.pl  --starDir ./  --outDir ./${name}_circfinder_out 
cd /together_sdb/zhoujiaqi/rawdata
done
