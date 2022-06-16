#!/bin/bash
git clone "http://gerrit.uniontech.com/deepin-kwin"
cd deepin-kwin/
git checkout dev/pad
git fetch "http://ut003093@gerrit.uniontech.com/a/deepin-kwin" refs/changes/82/95482/2 && git checkout FETCH_HEAD 
git status
exit 0
