assembly=$1

mkdir blast_results/${assembly}

tblastn -max_target_seqs 10 -db blast_results/${assembly}.fa -evalue 1e-10 -outfmt "6 std sseq" -query rplC_P9WH87.fa -out blast_results/${assembly}/rplC_test.blast
tblastn -max_target_seqs 10 -db blast_results/${assembly}.fa -evalue 1e-10 -outfmt "6 std sseq" -query rplD_P9WH85.fa -out blast_results/${assembly}/rplD_test.blast
tblastn -max_target_seqs 10 -db blast_results/${assembly}.fa -evalue 1e-10 -outfmt "6 std sseq" -query rlmN_P9WH15.fa -out blast_results/${assembly}/rlmN_test.blast
tblastn -max_target_seqs 10 -db blast_results/${assembly}.fa -evalue 1e-10 -outfmt "6 std sseq" -query tsnR_P94978.fa -out blast_results/${assembly}/tsnR_test.blast
blastn -max_target_seqs 10 -db blast_results/${assembly}.fa -evalue 1e-10 -outfmt "6 std sseq" -query rrs_mycobrowser.fna -out blast_results/${assembly}/rrs_test.blast
blastn -max_target_seqs 10 -db blast_results/${assembly}.fa -evalue 1e-10 -outfmt "6 std sseq" -query rrl_mycobrowser.fna -out blast_results/${assembly}/rrl_test.blast
