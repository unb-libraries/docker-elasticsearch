#!/usr/bin/env bash

for GLUSTER_FILESYSTEM_LINK in `echo "${GLUSTER_FILESYSTEM_LINK_DATA}"`; do
  IFS=',' read -a FILESYSTEM_LINK_DATA <<< "$GLUSTER_FILESYSTEM_LINK"
  if [ -d "${GLUSTER_VOL_PATH}${FILESYSTEM_LINK_DATA[0]}" ]; then
    rm -rf "${FILESYSTEM_LINK_DATA[1]}"
    ln -s "${GLUSTER_VOL_PATH}${FILESYSTEM_LINK_DATA[0]}/" "${FILESYSTEM_LINK_DATA[1]}"
  fi
done
