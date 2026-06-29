# Human RNA-seq Analysis of LPS-Stimulated Immune Cells

## Project Overview

This project analyzes human RNA-seq data to identify transcriptional changes after lipopolysaccharide (LPS) stimulation in human immune cells. The project follows a complete RNA-seq workflow from raw sequencing data to differential gene expression analysis and will be extended to RNA-seq-based variant calling.

---

## Project Objectives

* Perform RNA-seq quality assessment
* Trim low-quality reads and adapter sequences
* Align reads to the human reference genome (GRCh38)
* Generate gene-level count matrix
* Perform differential expression analysis using DESeq2
* Interpret biologically relevant immune-response genes
* Perform RNA-seq variant calling using GATK (planned)

---

## Dataset

| Item                | Description            |
| ------------------- | ---------------------- |
| Organism            | Homo sapiens           |
| Experimental Design | Control vs LPS-treated |
| Replicates          | 3 Control / 3 LPS      |
| Sequencing          | Paired-end RNA-seq     |
| Reference Genome    | GRCh38                 |

---

## Analysis Pipeline

```
FASTQ
    ↓
FastQC
    ↓
MultiQC
    ↓
Trim Galore
    ↓
HISAT2
    ↓
SAMtools
    ↓
featureCounts
    ↓
Count Matrix
    ↓
DESeq2
    ↓
Biological Interpretation
    ↓
GATK Variant Calling (Planned)
```

---

## Software & Tools

* Ubuntu (WSL)
* Bash
* HISAT2
* SAMtools
* FastQC
* MultiQC
* Trim Galore
* featureCounts
* Python (Pandas, Jupyter Notebook)
* R
* DESeq2
* biomaRt
* Git & GitHub

---

## Current Progress

### Completed

* [x] FASTQ preparation
* [x] FastQC
* [x] MultiQC
* [x] Read trimming (Trim Galore)
* [x] HISAT2 index construction
* [x] Read alignment (HISAT2)
* [x] BAM sorting and indexing (SAMtools)
* [x] Gene quantification (featureCounts)
* [x] Count matrix generation
* [x] Sample metadata generation
* [x] Differential expression analysis (DESeq2)
* [x] Initial DEG identification
* [x] Gene annotation using biomaRt

### In Progress

* [ ] Interpretation of immune-response genes (IL6, TNF, CXCL8, NFKBIA)
* [ ] Visualization (Volcano plot, MA plot, PCA)

### Planned

* [ ] RNA-seq Variant Calling (GATK)
* [ ] Functional enrichment analysis (GO / KEGG)
* [ ] Portfolio documentation
* [ ] Final project report

---

## Current Results

* Successfully generated count matrix from six RNA-seq samples.
* Successfully performed DESeq2 differential expression analysis.
* Initial significant DEG identified:

  * **XIST (ENSG00000229807)**
* Additional biological interpretation of immune-related genes is currently in progress.

---

## Repository Structure

```
human_lps/
├── data/
├── metadata/
├── notebooks/
├── results/
│   ├── bam/
│   ├── counts/
│   ├── tables/
│   └── figures/
├── scripts/
└── logs/
```
