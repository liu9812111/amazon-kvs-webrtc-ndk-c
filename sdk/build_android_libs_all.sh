#!/bin/bash

set -e

export PATH=/home/ubuntu/project/amazon-kvs-webrtc-ndk-c/src/third_party/llvm-build/Release+Asserts/bin:$PATH

#PY=/home/ubuntu/project/amazon-kvs-webrtc-ndk-c/depot_tools/python2-bin/python2
#PY=/home/ubuntu/project/amazon-kvs-webrtc-ndk-c/src/third_party/depot_tools/python2-bin/python2
PY=python2

pushd third_party/ffmpeg

echo "echo "This is line $LINENO""

git reset --hard
git apply ../../sdk/ffmpeg-others-build.diff

rm -rf build.x64.linux

$PY chromium/scripts/build_ffmpeg.py android arm-neon --branding Chrome -- \
    --disable-asm \
    --disable-encoders --enable-encoder=h264 --enable-encoder=hevc \
	--disable-hwaccels --disable-bsfs --disable-devices --disable-filters \
    --disable-protocols --enable-protocol=file \
    --disable-parsers --enable-parser=mpegaudio --enable-parser=h264 --enable-parser=hevc \
    --disable-demuxers --enable-demuxer=mov --enable-demuxer=mp3 --enable-demuxer=mpegts --enable-demuxer=h264 --enable-demuxer=hevc \
    --disable-decoders --enable-decoder=mp3 --enable-decoder=aac --enable-decoder=h264 --enable-decoder=hevc \
    --disable-muxers --enable-muxer=matroska --enable-muxer=mp4 \
    --enable-swresample

$PY chromium/scripts/build_ffmpeg.py android ia32 --branding Chrome -- \
    --disable-asm \
    --disable-encoders --enable-encoder=h264 --enable-encoder=hevc \
	--disable-hwaccels --disable-bsfs --disable-devices --disable-filters \
    --disable-protocols --enable-protocol=file \
    --disable-parsers --enable-parser=mpegaudio --enable-parser=h264 --enable-parser=hevc \
    --disable-demuxers --enable-demuxer=mov --enable-demuxer=mp3 --enable-demuxer=mpegts --enable-demuxer=h264 --enable-demuxer=hevc \
    --disable-decoders --enable-decoder=mp3 --enable-decoder=aac --enable-decoder=h264 --enable-decoder=hevc \
    --disable-muxers --enable-muxer=matroska --enable-muxer=mp4 \
    --enable-swresample

$PY chromium/scripts/build_ffmpeg.py android arm64 --branding Chrome -- \
    --disable-asm \
    --disable-encoders --enable-encoder=h264 --enable-encoder=hevc \
	--disable-hwaccels --disable-bsfs --disable-devices --disable-filters \
    --disable-protocols --enable-protocol=file \
    --disable-parsers --enable-parser=mpegaudio --enable-parser=h264 --enable-parser=hevc \
    --disable-demuxers --enable-demuxer=mov --enable-demuxer=mp3 --enable-demuxer=mpegts --enable-demuxer=h264 --enable-demuxer=hevc \
    --disable-decoders --enable-decoder=mp3 --enable-decoder=aac --enable-decoder=h264 --enable-decoder=hevc \
    --disable-muxers --enable-muxer=matroska --enable-muxer=mp4 \
    --enable-swresample

$PY chromium/scripts/build_ffmpeg.py android x64 --branding Chrome -- \
    --disable-asm \
    --disable-encoders --enable-encoder=h264 --enable-encoder=hevc \
	--disable-hwaccels --disable-bsfs --disable-devices --disable-filters \
    --disable-protocols --enable-protocol=file \
    --disable-parsers --enable-parser=mpegaudio --enable-parser=h264 --enable-parser=hevc \
    --disable-demuxers --enable-demuxer=mov --enable-demuxer=mp3 --enable-demuxer=mpegts --enable-demuxer=h264 --enable-demuxer=hevc \
    --disable-decoders --enable-decoder=mp3 --enable-decoder=aac --enable-decoder=h264 --enable-decoder=hevc \
    --disable-muxers --enable-muxer=matroska --enable-muxer=mp4 \
    --enable-swresample

./chromium/scripts/copy_config.sh

echo "*****************************************************************"
echo "*****************************************************************"
echo "*****************************************************************"
echo "run ./chromium/scripts/generate_gn.py on macOS with conda py2 env"
echo "*****************************************************************"
echo "*****************************************************************"
echo "*****************************************************************"
#exit

./chromium/scripts/generate_gn.py

popd

echo "buid debug version"

gn gen out/android_debug_arm --args='target_os="android" target_cpu="arm" is_debug=true ffmpeg_branding="Chrome"'
ninja -C out/android_debug_arm libjingle_peerconnection_so
ninja -C out/android_debug_arm libwebrtc
mkdir -p out/dist/debug/armeabi-v7a/
cp out/android_debug_arm/libjingle_peerconnection_so.so out/dist/debug/armeabi-v7a/
cp out/android_debug_arm/lib.java/sdk/android/libwebrtc.jar out/dist/debug/

gn gen out/android_debug_arm64 --args='target_os="android" target_cpu="arm64" is_debug=true ffmpeg_branding="Chrome"'
ninja -C out/android_debug_arm64 libjingle_peerconnection_so
ninja -C out/android_debug_arm64 libwebrtc
mkdir -p out/dist/debug/arm64-v8a/
cp out/android_debug_arm64/libjingle_peerconnection_so.so out/dist/debug/arm64-v8a/
cp out/android_debug_arm64/lib.java/sdk/android/libwebrtc.jar out/dist/debug/

gn gen out/android_debug_x86 --args='target_os="android" target_cpu="x86" is_debug=true ffmpeg_branding="Chrome"'
ninja -C out/android_debug_x86 libjingle_peerconnection_so
ninja -C out/android_debug_x86 libwebrtc
mkdir -p out/dist/debug/x86/
cp out/android_debug_x86/libjingle_peerconnection_so.so out/dist/debug/x86/
cp out/android_debug_x86/lib.java/sdk/android/libwebrtc.jar out/dist/debug/

gn gen out/android_debug_x64 --args='target_os="android" target_cpu="x64" is_debug=true ffmpeg_branding="Chrome"'
ninja -C out/android_debug_x64 libjingle_peerconnection_so
ninja -C out/android_debug_x64 libwebrtc
mkdir -p out/dist/debug/x86_64/
cp out/android_debug_x64/libjingle_peerconnection_so.so out/dist/debug/x86_64/
cp out/android_debug_x64/lib.java/sdk/android/libwebrtc.jar out/dist/debug/



echo "buid release version"

gn gen out/android_release_arm --args='target_os="android" target_cpu="arm" is_debug=false ffmpeg_branding="Chrome"'
ninja -C out/android_release_arm libjingle_peerconnection_so
ninja -C out/android_release_arm libwebrtc
cp out/android_release_arm/libjingle_peerconnection_so.so out/dist/release/armeabi-v7a/
cp out/android_release_arm/lib.java/sdk/android/libwebrtc.jar out/dist/release/

gn gen out/android_release_arm64 --args='target_os="android" target_cpu="arm64" is_debug=false ffmpeg_branding="Chrome"'
ninja -C out/android_release_arm64 libjingle_peerconnection_so
ninja -C out/android_release_arm64 libwebrtc
mkdir -p out/dist/release/arm64-v8a/
cp out/android_release_arm64/libjingle_peerconnection_so.so out/dist/release/arm64-v8a/
cp out/android_release_arm64/lib.java/sdk/android/libwebrtc.jar out/dist/release/

gn gen out/android_release_x86 --args='target_os="android" target_cpu="x86" is_debug=false ffmpeg_branding="Chrome"'
ninja -C out/android_release_x86 libjingle_peerconnection_so
ninja -C out/android_release_x86 libwebrtc
mkdir -p out/dist/release/x86/
cp out/android_release_x86/libjingle_peerconnection_so.so out/dist/release/x86/
cp out/android_release_x86/lib.java/sdk/android/libwebrtc.jar out/dist/release/


gn gen out/android_release_x64 --args='target_os="android" target_cpu="x64" is_debug=false ffmpeg_branding="Chrome"'
ninja -C out/android_release_x64 libjingle_peerconnection_so
ninja -C out/android_release_x64 libwebrtc
mkdir -p out/dist/release/x86_64/
cp out/android_release_x64/libjingle_peerconnection_so.so out/dist/release/x86_64/
cp out/android_release_x64/lib.java/sdk/android/libwebrtc.jar out/dist/release/

