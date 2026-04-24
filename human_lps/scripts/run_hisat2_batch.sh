#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$HOME/projects/rna-seq-variant-portfolio/human_lps"
TRIM_DIR="$PROJECT_DIR/data/trimmed"
REF_DIR="$PROJECT_DIR/data/reference"
BAM_DIR="$PROJECT_DIR/results/bam"
COUNT_DIR="$PROJECT_DIR/results/counts"
LOG_DIR="$PROJECT_DIR/logs/hisat2"

INDEX_PREFIX="$REF_DIR/hisat2_index/grch38"
GTF="$REF_DIR/Homo_sapiens.GRCh38.110.gtf"

THREADS=4

mkdir -p "$BAM_DIR" "$COUNT_DIR" "$LOG_DIR"

for R1 in "$TRIM_DIR"/*_1_val_1.fq.gz; do
    SAMPLE=$(basename "$R1" | sed 's/_1_val_1\.fq\.gz//')
    R2="$TRIM_DIR/${SAMPLE}_2_val_2.fq.gz"

    if [[ ! -f "$R2" ]]; then
        echo "[WARNING] R2 file not found for $SAMPLE"
        continue
    fi

    echo "===== Processing $SAMPLE ====="

    hisat2 \
        -p "$THREADS" \
        -x "$INDEX_PREFIX" \
        -1 "$R1" \
        -2 "$R2" \
        --dta \
        -S "$BAM_DIR/${SAMPLE}.sam" \
        2> "$LOG_DIR/${SAMPLE}.hisat2.log"

    samtools view -@ "$THREADS" -bS "$BAM_DIR/${SAMPLE}.sam" \
        | samtools sort -@ "$THREADS" -o "$BAM_DIR/${SAMPLE}.sorted.bam"

    samtools index "$BAM_DIR/${SAMPLE}.sorted.bam"

    featureCounts \
        -T "$THREADS" \
        -p \
        -a "$GTF" \
        -o "$COUNT_DIR/${SAMPLE}.counts.txt" \
        "$BAM_DIR/${SAMPLE}.sorted.bam"

    echo "===== Done: $SAMPLE ====="
done
