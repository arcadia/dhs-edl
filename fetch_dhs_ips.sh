#!/bin/bash
# Fetch and clean DHS IP list

EDL_URL="https://rules.vm.cyber.dhs.gov/all.txt"
OUTPUT_FILE="dhs-ips.txt"

# Fetch and extract only valid IPs
curl -s $EDL_URL | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}(/[0-9]+)?' > $OUTPUT_FILE

# Check for changes and push only if there are updates
if [[ -n $(git status --porcelain) ]]; then
  git config --global user.email "github-actions@github.com"
  git config --global user.name "GitHub Actions"
  git add $OUTPUT_FILE
  git commit -m "Updated DHS IP list"
  git push origin main
fi
