{
services.samba = {
  enable = true;
  securityType = "user";
  openFirewall = true;
  shares = {
    slab1 = {
      path = "/home/whatever/mnt/slab1";
      browseable = "yes";
      "read only" = "no";
      "valid users" = "whatever";
      "force group" = "sharedgroup";
    };
    slab2 = {
      path = "/home/whatever/mnt/slab2";
      browseable = "yes";
      "read only" = "no";
      "valid users" = "whatever";
      "force group" = "sharedgroup";
    };
    eldrajw = {
      path = "/home/whatever/mnt/slab1/eldrajw";
      browseable = "yes";
      "read only" = "no";
      "valid users" = "whatever, justyna";
      "force group" = "sharedgroup";
    };
  };
  settings = {
    global = {
      "workgroup" = "WORKGROUP";
      "server string" = "smbnix";
      "netbios name" = "smbnix";
      "security" = "user";
      #"use sendfile" = "yes";
      #"max protocol" = "smb2";
      # note: localhost is the ipv6 localhost ::1
      "hosts allow" = "192.168.0. 127.0.0.1 localhost";
      "hosts deny" = "0.0.0.0/0";
      "guest account" = "nobody";
      "map to guest" = "bad user";
    };
    "public" = {
      "path" = "/mnt/Shares/Public";
      "browseable" = "yes";
      "read only" = "no";
      "guest ok" = "yes";
      "create mask" = "0644";
      "directory mask" = "0755";
      "force user" = "username";
      "force group" = "groupname";
    };
    "private" = {
      "path" = "/mnt/Shares/Private";
      "browseable" = "yes";
      "read only" = "no";
      "guest ok" = "no";
      "create mask" = "0644";
      "directory mask" = "0755";
      "force user" = "username";
      "force group" = "groupname";
    };
  };
};

services.samba-wsdd = {
  enable = true;
  openFirewall = true;
};

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
    extraServiceFiles = {
      smb = ''
        <?xml version="1.0" standalone='no'?><!--*-nxml-*-->
        <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
        <service-group>
          <name replace-wildcards="yes">%h</name>
          <service>
            <type>_smb._tcp</type>
            <port>445</port>
          </service>
        </service-group>
      '';
    };
  };
}
 # $ sudo smbpasswd -a yourusername
