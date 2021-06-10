
#!/bin/bash
#env:base
names=`ls`
for name in ${names[@]};
do
fastq-dump --gzip --split-3 --defline-qual '+'   ${name}
rm ${name}
done