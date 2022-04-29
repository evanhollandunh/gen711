# gen711
gen711 final project

Enter the QIIME2 environment via RON:

source activate qiime2-2020.2

Import sequences into QIIME2 artifact:

qiime tools import --type SampleData[PairedEndSequencesWithQuality] --input-path ./evan_reads/ --input-format CasavaOneEightSingleLanePerSampleDirFmt --output-path ./imported_reads.qza

Read data is already demultiplexed. Summarize into visualization file:

qiime demux summarize --i-data imported_reads.qza --o-visualization qualityplot.qzv

Observe resulting quality plots and make determination where to cut reads:

Cut reads at 244 for reverse, no cut for forward (denoising with DADA2)

Converted output files (dns.qza, table.qza, rep-seqs.qza) to qzv files

Downloaded metadata from dns.qzv and added to gen711_metadata.csv

Trained classifier for establishing phylogeny
