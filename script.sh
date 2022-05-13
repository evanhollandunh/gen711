source activate qiime2-2020.2

qiime tools import --type SampleData[PairedEndSequencesWithQuality] --input-path ./evan_reads/ --input-format CasavaOneEightSingleLanePerSampleDirFmt --output-path ./imported_reads.qza

qiime demux summarize –i-data imported_reads.qza –o-visualization qualityplot.qzv

qiime dada2 denoise-paired --i-demultiplexed-seqs /home/users/esh1023/imported_reads.qza --p-trunc-len-f 0 --p-trunc-len-r 244 --p-n-threads 8 --o-representative-sequences /home/users/esh1023/rep-seqs.qza --o-table /home/users/esh1023/table.qza --o-denoising-stats /home/users/esh1023/dns.qza --verbose

qiime metadata tabulate --m-input-file dns.qza --o-visualization dns.qzv

qiime feature-table summarize --i-table table.qza --o-visualization table.qzv

qiime feature-table tabulate-seqs --i-data rep-seqs.qza --o-visualization rep-seqs.qzv

qiime feature-classifier classify-consensus-blast --i-query /mnt/home/poleatewich/hbn1002/QDM011/16s/evan/rep-seqs.qza --i-reference-reads /mnt/home/poleatewich/hbn1002/QDM009/data/16s/silva-training-classifier/silva-ref-seqs.qza --i-reference-taxonomy /mnt/home/poleatewich/hbn1002/QDM009/data/16s/silva-training-classifier/majority_taxonomy_7_levels.qza --p-perc-identity 0.97 --o-classification blast-tax.qza --verbose

qiime phylogeny align-to-tree-mafft-fasttree --i-sequences ./rep-seqs.qza --o-alignment ./aligned-rep-seqs.qza --o-masked-alignment ./masked-align-rep-seqs.qza --o-tree ./unrooted-tree.qza --o-rooted-tree ./rooted-tree.qza

qiime diversity core-metrics-phylogenetic --i-phylogeny ./rooted-tree.qza --i-table ./table.qza --p-sampling-depth 1000 --m-metadata-file ./gen711_metadata.tsv --output-dir ./core-div-metrics

qiime taxa barplot --i-table ./table.qza --i-taxonomy blast-tax.qza --o-visualization blast-tax.qzv
