#!/usr/bin/env bash
set -euo pipefail

FILE="$1"

echo "== Measurements =="
jq -r '.measurement' "$FILE" | sort -u

echo
echo "== Pod startup latency =="
jq -r '
select(.measurement=="StatelessPodStartupLatency_PodStartupLatency") |
[
  .data.labels.Metric,
  .data.data.Perc50,
  .data.data.Perc90,
  .data.data.Perc99,
  .data.unit
] | @tsv
' "$FILE"
