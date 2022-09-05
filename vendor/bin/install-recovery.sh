#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):67633152:530a0684249d0a2f6a05b79226393bf383fb3766; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):57671680:100e89c1bfe628a7c23348ae8e4efca51dd629e8 \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):67633152:530a0684249d0a2f6a05b79226393bf383fb3766 && \
      (log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi

