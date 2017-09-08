#!/bin/bash
cases(){
mkdir -p case1
mkdir -p case2
mkdir -p case3
touch case1/.gitkeep
touch case2/.gitkeep
touch case3/.gitkeep
}
skelversion(){
bash -c "cat << 'EOF' > VERSION
1.0.0
EOF"
}
skelbash(){
OUTPUT=bootstrap.sh
if [ ! -f "$OUTPUT" ]; then
cat << 'EOF' > $OUTPUT
#!/usr/bin/env bash

if [[ "$(id -u)" != "0" ]]; then
    PASS=$(zenity --entry --text="input:")
    CMD=$0
    expect -c "
      set timeout -1
      spawn sudo $CMD
      expect \"assword\" {
        send \"$PASS\n\"
      }
      interact
    "
    exit
fi
sudo bash -c "cat << 'EOF' > ok
$(date +%Y%m%d%H%M%S)
EOF"

EOF
chmod +x $OUTPUT
fi
}
skelmakefile(){
cat >> Makefile << 'EOF'
#!/usr/bin/make -f
define README
# README
endef
export README
RUN := /bin/bash
all:
	@echo make readme
readme:
	@echo "$$README"
version:
	$(RUN) \
	--version
EOF
chmod +x Makefile
}

skelpython(){
OUTPUT=main.py
if [ ! -f "$OUTPUT" ]; then
bash -c "cat << 'EOF' > $OUTPUT
#!/usr/bin/env python3
# coding:utf-8

EOF"
chmod +x $OUTPUT
fi
}

