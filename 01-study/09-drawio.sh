#!/bin/bash
nohup drawio "$1"  >00-nohup.out 2>&1 &
exit 0
