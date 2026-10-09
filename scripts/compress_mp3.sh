#!/usr/bin/env bash
# compress_mp3.sh — 多段播客拼接 + 压缩到 20MB 以下（飞书消息上限）
# 用法:
#   1) 拼接多段:  ./compress_mp3.sh concat list.txt out.mp3
#   2) 单文件压缩: ./compress_mp3.sh compress in.mp3 [out.mp3]
set -euo pipefail

mode="${1:?usage: compress_mp3.sh <concat|compress> ...}"

case "$mode" in
  concat)
    list="$2"; out="$3"
    ffmpeg -y -f concat -safe 0 -i "$list" -c copy "$out"
    echo "拼接完成: $out"
    ;;
  compress)
    in="$2"; out="${3:-${in%.*}_压缩版.mp3}"
    ffmpeg -y -i "$in" -ac 1 -b:a 64k "$out"
    size=$(du -k "$out" | cut -f1)
    echo "压缩完成: $out (${size}KB)"
    if [ "$size" -gt 20480 ]; then
      echo "警告: 仍超过 20MB，可降低码率到 48k 或再分段"
    fi
    ;;
  *)
    echo "未知模式: $mode" >&2; exit 1 ;;
esac
