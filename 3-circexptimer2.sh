
#!/bin/bash
#env:RNAseq
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
#### circexplorer
#env: RNAseq
#最好跑
if [ ! -d ${name}_circexplorer ];
then
        mkdir ${name}_circexplorer
        cd ${name}_circexplorer
fi
STAR --readFilesIn ../clean${name}_1.fq ../clean${name}_2.fq --outFileNamePrefix ./${name} --genomeDir  /together_sdb/zhoujiaqi/index/STAR-index-2   --chimSegmentMin 10 --runThreadN 3  --outFilterType BySJout
star_parse.py ${name}Chimeric.out.junction ${name}fusion_junction.txt 
CIRCexplorer.py -j  ${name}fusion_junction.txt -g /together_sdb/zhoujiaqi/index/GRCh38.p13.genome.fa -r /together_sdb/zhoujiaqi/index/gencode.v22_refGene_awk.txt
cd /together_sdb/zhoujiaqi/PAAD
done

