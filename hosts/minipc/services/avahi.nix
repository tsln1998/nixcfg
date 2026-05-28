_: {
  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      userServices = true;
    };
    openFirewall = true;
    extraServiceFiles = {
      samba = ''
        <?xml version="1.0" standalone='no'?>
        <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
        <service-group>
          <name>MK's MiniPC</name>

          <service>
            <type>_smb._tcp</type>
            <port>445</port>
            <txt-record>u=samba</txt-record>
          </service>

          <service>
            <type>_device-info._tcp</type>
            <port>0</port>
            <txt-record>model=Macmini</txt-record>
          </service>
        </service-group>
      '';
    };
  };
}
