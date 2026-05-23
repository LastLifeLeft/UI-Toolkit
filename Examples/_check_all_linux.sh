#!/bin/bash
export PUREBASIC_HOME=/opt/purebasic
cd /mnt/d/Documents/GitHub/UI-Toolkit/Examples
for f in "LinuxMinimal.pb" "Example 3 - Timeline.pb" "Debug.pb" "_phase3_cleanup_test.pb" "AeroSnapTest.pb"; do
  /opt/purebasic/compilers/pbcompiler "$f" --check 2>&1 | tail -2
  echo "=== $f ==="
done
