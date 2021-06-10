
#!/bin/bash
#env:RNAseq
names=`ls`
for name in ${names[@]};
do
cd ./${name}
STAR \
--readFilesIn clean${name}_1.fq clean${name}_2.fq  \
--alignIntronMax 1000000 \
--alignIntronMin 20 \
--alignMatesGapMax 1000000 \
--alignSJDBoverhangMin 1 \
--alignSJoverhangMin 8 \
--alignSoftClipAtReferenceEnds Yes \
--chimJunctionOverhangMin 15 \
--chimMainSegmentMultNmax 1 \
--chimOutType Junctions SeparateSAMold \
--chimSegmentMin 15 \
--genomeDir  /together_sdb/zhoujiaqi/index/TCGA-index  \
--genomeLoad NoSharedMemory \
--limitSjdbInsertNsj 1200000 \
--outFileNamePrefix ${name} \
--outFilterIntronMotifs None \
--outFilterMatchNminOverLread 0.33 \
--outFilterMismatchNmax 999 \
--outFilterMismatchNoverLmax 0.1 \
--outFilterMultimapNmax 20 \
--outFilterScoreMinOverLread 0.33 \
--outFilterType BySJout \
--outSAMattributes NH HI AS nM NM ch \
--outSAMstrandField intronMotif \
--outSAMtype SAM \
--outSAMunmapped Within \
--quantMode TranscriptomeSAM GeneCounts \
--runThreadN 16 \
--twopassMode Basic

#########################################
nohup htseq-count \
-f sam \
-r pos \
-s no \
-a 10 \
-t exon \
-i gene_id \
-m intersection-nonempty \
${name}Aligned.out.sam \
/together_sdb/zhoujiaqi/index/gencode.v22.annotation.gtf > ${name}.count 2> htseq.log &

cd ../

done