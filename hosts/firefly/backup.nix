{ ... }: {

  services.borgbackup.jobs."firefly" = {
    paths = [
      "/mnt/ironwolf"
    ];

    exclude = [
      "/mnt/ironwolf/media"
    ];

    repo = "sysadmin@100.112.8.4:/mnt/backups/firefly.serenity.lan";

    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /root/borgbackup/passphrase";
    };

    environment.BORG_RSH = "ssh -i /root/borgbackup/ssh_key";
    compression = "auto,lzma";
    startAt = "daily";
  };
}
