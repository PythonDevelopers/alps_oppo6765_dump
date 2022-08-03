#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):102760448:e0f30221e08d42506ba9b5f44269e2df3f036e96; then
  applypatch  \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):33554432:ed5d4441589dfa48f34065cc809fce939837a11e \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):102760448:e0f30221e08d42506ba9b5f44269e2df3f036e96 && \
      log -t recovery "Installing new recovery image: succeeded" && \
      setprop ro.boot.recovery.updated true || \
      log -t recovery "Installing new recovery image: failed" && \
      setprop ro.boot.recovery.updated false
else
  log -t recovery "Recovery image already installed"
  setprop ro.boot.recovery.updated true
fi
