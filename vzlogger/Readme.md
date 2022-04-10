# Parameters:

With SOCAT="false" just configure vzlogger in (/usr/share/hassio/homeassistant)/vzlogger_cfg/vzlogger.cfg  

With SOCAT="true" set the serverip, port, and name of the virtual serial port in a rw directory (outside /dev) e.g. "/ttyV0"  
This must me referenced in the vzlogger.cfg as well. 

