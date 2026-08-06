
{config, ... }:

{
  fileSystems."/dev/nvme0n1p4" = {
    device = "/dev/disk/by-uuid/EDBF-E603";
    fsType = "exfat";
  };  
}
