#!/usr/bin/env bash
set -euo pipefail

INPUT_DIR="data/raw"
OUTPUT_DIR="data/trimmed"
CORES=4

mkdir -p "$OUTPUT_DIR"

echo "[INFO] Input directory : $INPUT_DIR"
echo "[INFO] Output directory: $OUTPUT_DIR"
echo "[INFO] Cores          : $CORES"

R1_FILES=("$INPUT_DIR"/*_1.fastq)

if [[ ! -e "${R1_FILES[0]}" ]]; then
    echo "[ERROR] No *_1.fastq files found in $INPUT_DIR"
    exit 1
fi

TOTAL=${#R1_FILES[@]}
echo "[INFO] Found $TOTAL sample(s)"

for R1 in "${R1_FILES[@]}"; do
    R2="${R1/_1.fastq/_2.fastq}"
    SAMPLE=$(basename "$R1" _1.fastq)

    if [[ ! -f "$R2" ]]; then
        echo "[WARN] Missing R2 for $SAMPLE, skipping"
        continue
    fi

    if [[ -f "$OUTPUT_DIR/${SAMPLE}_1_val_1.fq.gz" ]]; then
        echo "[SKIP] Output already exists for $SAMPLE"
        continue
    fi

    echo "[RUN] $SAMPLE"
    trim_galore \
        --paired \
        --cores "$CORES" \
        --gzip \
        --fastqc \
        --output_dir "$OUTPUT_DIR" \
        "$R1" "$R2"

    echo "[DONE] $SAMPLE"
done

echo "[INFO] Trimming complete"
