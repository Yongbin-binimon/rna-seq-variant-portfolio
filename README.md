# Human RNA-seq Analysis of LPS-Stimulated Immune Cells

## Project Overview
This project analyzes human RNA-seq data to identify transcriptional changes after LPS stimulation in immune cells.

## Objective
- Perform RNA-seq quality control
- Trim raw reads
- Align reads to the human reference genome (GRCh38)
- Generate gene count matrix
- Perform differential expression analysis
- Explore RNA-seq-based variant calling

## Dataset
- Organism: Human
- Condition: Control vs LPS-treated
- Replicates: 3 vs 3
- Layout: Paired-end RNA-seq

## Pipeline
FastQC → Trim Galore → STAR → featureCounts → DESeq2 → GATK

## Tools
- FastQC
- MultiQC
- Trim Galore
- STAR
- samtools
- featureCounts
- DESeq2
- GATK

## Status
- [x] FASTQ preparation
- [x] FastQC
- [x] MultiQC (optional)
- [ ] Trimming
- [ ] Alignment
- [ ] Counting
- [ ] DE analysis
- [ ] Variant calling
