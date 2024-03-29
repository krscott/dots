{ lib }:
{
  mkEnableOptionTrue = name: lib.mkOption {
    default = true;
    example = false;
    description = "Whether to enable ${name}.";
    type = lib.types.bool;
  };
}
