#!/usr/bin/env bash

set -u

THREADS=2
INDEX="../data/reference/hisat2_index/grch38"
GTF="../data/reference/Homo_sapiens.GRCh38.110.gtf"

mkdir -p ../results/bam ../logs/hisat2 ../results/counts

SAMPLES=(SRR11994200 SRR11994201 SRR11994202 SRR11994203 SRR11994204 SRR11994205)

for SAMPLE in "${SAMPLES[@]}"; do
    echo "===== $SAMPLE ====="

    if [[ -f ../results/bam/${SAMPLE}.sorted.bam ]]; then
        echo "$SAMPLE already done → skip"
        continue
    fi

    hisat2 \
      -p $THREADS \
      -x $INDEX \
      -1 ../data/trimmed/${SAMPLE}_1_val_1.fq.gz \
      -2 ../data/trimmed/${SAMPLE}_2_val_2.fq.gz \
      -S ../results/bam/${SAMPLE}.sam \
      2> ../logs/hisat2/${SAMPLE}.log

    samtools view -@ $THREADS -bS ../results/bam/${SAMPLE}.sam | \
    samtools sort -@ $THREADS -m 512M -o ../results/bam/${SAMPLE}.sorted.bam

    samtools index ../results/bam/${SAMPLE}.sorted.bam

    featureCounts \
      -T $THREADS \
      -p \
      -t exon \
      -g gene_id \
      -a $GTF \
      -o ../results/counts/${SAMPLE}.counts.txt \
      ../results/bam/${SAMPLE}.sorted.bam

    rm ../results/bam/${SAMPLE}.sam

    echo "$SAMPLE DONE"
done

echo "ALL DONE"
