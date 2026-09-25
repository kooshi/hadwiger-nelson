#!/bin/bash
cd "$(dirname "$0")"
python3 -u shapes.py 348 "1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2" 167 > s348.out 2>&1
python3 -u shapes.py 420 "1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2" 167 > s420.out 2>&1
python3 -u shapes.py 30 "1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2" 131 > s131.out 2>&1
echo DONE > run167.done
