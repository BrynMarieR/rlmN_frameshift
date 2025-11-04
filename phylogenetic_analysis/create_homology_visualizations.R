# Bryn Reimer
# 15 Aug 2025

# Libraries for reading and visualization
library(readr)
library(pheatmap)
library(RColorBrewer)

lines <- readLines(paste0("simple_phylogeny_output/",
                   "simple_phylogeny-I20250815-145913-0234-81701652-p1m.pim"))

# Remove the leading row number and colon, then split by whitespace
parsed <- lapply(lines, function(line) {
  parts <- strsplit(line, ":\\s*")[[1]][2]         # Remove the line number
  parts <- strsplit(parts, "\\s+")[[1]]            # Split by spaces
  return(parts)
})

# Remove the first 6 lines (empty)
parsed = parsed[7:length(parsed)]

# Extract gene names
gene_names <- sapply(parsed, function(x) x[1])
# Some of the gene names got shorted, so make sure to add those back in
gene_names <- gsub("MT$", "MTB", gene_names)

# Create dataframe and set with names
numeric_data <- t(sapply(parsed, function(x) as.numeric(x[-1])))
df <- as.matrix(numeric_data)
rownames(df) <- gene_names
colnames(df) <- gene_names

# Sort by phylogenetic order
phylo_order = c(
  "Rv0881_MTB",
  "tsnR_MTB",
  "Rv3579c_MTB",
  "spoU_MTB",
  "rsmE_MTB",
  "rsmI_MTB",
  "Rv0380c_MTB",
  "Rv2689c_MTB",
  "rlmN_MTB",
  "rlmN_saur",
  "trmD_MTB",
  "erm_37__MTB",
  "trmB_MTB",
  "trmI_MTB",
  "ksgA_MTB",
  "Rv2966c_MTB",
  "tlyA_MTB",
  "Rv1407_MTB",
  "rsmG_MTB",
  "rsmH_MTB"
)
df <- df[phylo_order,phylo_order]

# readable names
readable_names = c(
  "Rv0881",
  "tsnR",
  "Rv3579c",
  "spoU",
  "rsmE",
  "rsmI",
  "Rv0380c",
  "Rv2689c",
  "rlmN (MTB)",
  "rlmN (S aur)",
  "trmD",
  "erm(37)",
  "trmB",
  "trmI",
  "ksgA",
  "Rv2966c",
  "tlyA",
  "Rv1407",
  "rsmG",
  "rsmH"
)
colnames(df) <- readable_names
rownames(df) <- readable_names

# To facilitate visualization, NA out the diagonal
diag(df) <- NA

# For clarity, bold relevant genes
newnames <- lapply(
  rownames(df),
  function(x) { 
    if (x %in% c("tsnR", "rlmN (MTB)", "rlmN (S aur)")) {
      bquote(bold(.(x)))
    } else {
      x
    }
    })

pheatmap(df, color=colorRampPalette(brewer.pal(n=9,name="Blues"))(100),
         labels_row = as.expression(newnames), 
         labels_col = as.expression(newnames),
         cluster_rows=FALSE, cluster_cols = FALSE, cellwidth=15, cellheight=15)

par(mar=c(6.1, 4.1, 4.1, 2.1))
barplot(sort(df[10,], decreasing=TRUE), las=2, col="lightblue",ylim=c(0,40),
        ylab="Percent identity (%) to S. aureus rlmN")
abline(h=30, col="black", lty=2,lwd=1)
text(10, 31, "homology threshold")

##

