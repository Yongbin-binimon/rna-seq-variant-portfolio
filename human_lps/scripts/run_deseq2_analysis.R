# Load DESeq2
library(DESeq2)

# Set project directory
project_dir <- "~/projects/rna-seq-variant-portfolio/human_lps"
setwd(project_dir)

# Load count matrix and metadata
count_data <- read.csv("results/count_matrix.csv", row.names = 1)
meta_data <- read.csv("metadata/sample_metadata.csv", row.names = 1)

# Set condition order: Control as reference, LPS as treatment
meta_data$condition <- factor(meta_data$condition, levels = c("Control", "LPS"))

# Check sample order
print(colnames(count_data))
print(rownames(meta_data))

# Create DESeq2 object
dds <- DESeqDataSetFromMatrix(
    countData = count_data,
    colData = meta_data,
    design = ~ condition
)

# Filter low-count genes
dds <- dds[rowSums(counts(dds)) > 10, ]

# Run DESeq2
dds <- DESeq(dds)

# Extract result: LPS vs Control
res <- results(dds, contrast = c("condition", "LPS", "Control"))

# Order by adjusted p-value
res_ordered <- res[order(res$padj), ]

# Create output directory
dir.create("results/tables", recursive = TRUE, showWarnings = FALSE)

# Save result
write.csv(as.data.frame(res_ordered), "results/tables/deseq2_results_LPS_vs_Control.csv")

# Save significant DEG
sig_res <- subset(as.data.frame(res_ordered), padj < 0.05)
write.csv(sig_res, "results/tables/significant_DEG_padj_0.05.csv")

# Print summary
print(summary(res))
print(head(res_ordered))
print(paste("Number of significant DEGs:", nrow(sig_res)))
