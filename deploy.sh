#!/bin/bash

set -e

WORKING_DIR=$1
SCHEMA_DIR=$3 # schemaを記述したjsonがあるdirを指定
DATE_PREFIX=`date +'%Y%m%d'`
$DATASET="appannie_export_data"


for file in $WORKING_DIR/App_Annie_Intelligence*.csv; do
  gsutil cp $file gs://$BUCKET/$DATE_PREFIX/ ;
done

# downloads_and_revenue
bq --location=asia-northeast1 load \
--noreplace \
--source_format=CSV \
--time_partitioning_type=DAY \
$PROJECT.$DATASET.$TARGET \
gs://$BUCKET/$DATE_PREFIX/App_Annie_Intelligence_Downloads*.csv \
$SCHEMA/downloads_and_revenue.json

# usage_app_report
# TODO: どちらか片方だけimportしたいみたいな需要に対応する
bq --location=asia-northeast1 load \
--noreplace \
--source_format=CSV \
--time_partitioning_type=DAY \
$PROJECT.$DATASET.$TARGET \
gs://$BUCKET/$DATE_PREFIX/App_Annie_Intelligence_Usage*.csv \
$SCHEMA/usage_app_report.json
