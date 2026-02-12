# An environment for oracle cloud cli
#
pkgs:
let
  oci-acquire = pkgs.writeShellScriptBin "oci-acquire" ''
    OciAvailabilityDomain="$1"
    OciCompartmentId="$2"
    OciSubnetId="$3"

    export OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING=True

    false ; while [ $? ]; do
      oci compute instance launch \
          --availability-domain "$OciAvailabilityDomain" \
          --compartment-id "$OciCompartmentId" \
          --subnet-id "$OciSubnetId" \
          --image-id "ocid1.image.oc1.phx.aaaaaaaaf6r2o2eybs2cnlmrhfnmzg546g2tpy3estztocaugnp7egxabmlq" \
          --boot-volume-size-in-gbs "100" \
          --shape "VM.Standard.A1.Flex" \
          --shape-config '{"ocpus": 2,"memory_in_gbs": 12}' \
          --assign-public-ip "true" \
          --assign-ipv6-ip "true"
    done
  '';
in
pkgs.mkShell {
  name = "oci-devshell";
  packages = with pkgs; [
    oci-cli
    oci-acquire
  ];
}
