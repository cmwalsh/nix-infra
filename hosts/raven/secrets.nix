{ inputs, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.sshKeyPaths = [ "/home/craig/.ssh/id_ed25519" ];
    age.generateKey = true;

    secrets = {
      hello = { };
      hetzner = { };
    };
  };
}
