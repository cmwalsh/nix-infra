{ ... }:

{
  programs.starship = {
    enable = true;

    settings = {
      add_newline = true;
      aws.disabled = true;
      gcloud.disabled = true;
    };
  };
}
