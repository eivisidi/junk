java

install:
download Linux (self-extracting file) from www.java.com to ~/Downloads
cd /usr/local/bin
sudo mkdir java
cd java
sudo mkdir 32
sudo mv ~/Downloads/jre-6u31-linux-i586.bin /usr/local/bin/java/32
sudo chmod 755 or a+x /usr/local/bin/java/32/jre-6u31-linux-i586.bin
cd /usr/local/bin/java/32
sudo ./jre-6u31-linux-i586.bin
sudo update-alternatives --install "/usr/bin/java" "java" "/usr/local/bin/java/32/jre1.6.0_31/bin/java" 1
when updating from previous removed java version then you'll need to execute the above command twice
sudo update-alternatives --set java /usr/local/bin/java/32/jre1.6.0_31/bin/java
sudo ln -s /usr/local/bin/java/32/jre1.6.0_31/lib/i386/libnpjp2.so /usr/lib/chromium/plugins
/usr/local/bin/java/32/jre1.6.0_31/bin/ControlPanel (optional control panel) 


uninstall:
sudo rm /usr/lib/chromium/plugins/libnpjp2.so
sudo rm -rf /usr/local/bin/java
