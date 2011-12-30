#sudo chmod 755 ~/.xinitrc 
#xrdb -load ~/.Xdefaults &
#! /bin/sh

feh --bg-scale ~/Pictures/blackcity.png &

wifi(){
     STATUS="X`/sbin/iwgetid`"
     if test "$STATUS" != "X" ; then
       ESSID="`/sbin/iwgetid |awk -F ":" '{print $2}'|sed -e 's/"//g'`"
       LINK="`awk '/wlan0:/ {print $3}' /proc/net/wireless |sed -e 's/\.//g'`"
     echo " $ESSID:$LINK"
     fi
   }

batt(){
     FULL=`cat /sys/class/power_supply/BAT1/charge_full`
     PRESENT=`cat /sys/class/power_supply/BAT1/present`
     CHARGE=`cat /sys/class/power_supply/BAT1/charge_now`
     STATUS=`cat /sys/class/power_supply/BAT1/status`
   if test "$PRESENT" != "0" ; then
     CHARGE=$((${CHARGE}*100/${FULL}))
     case $STATUS in
       Full)
         SIGN="=";;
       Charging)
         SIGN="+";;
       Discharging)
         SIGN="-";;
     esac
     echo " ${CHARGE}${SIGN}"
   else
     echo " AC"
   fi
   }

weather(){
WEATHERTEXT=`w3m -dump "http://mobile.weather.gov/port_mp_ns.php?CityName=Juncos&site=SJU&State=PR&warnzone=PRZ004" -config none | grep -o '[A-Za-z /:-]* [0-9-][0-9]* .F' | sed -e 's/ //g'`
 echo "W:$WEATHERTEXT"
}

mem(){
MEMTOTAL=`awk '/MemTotal/{print $2}' < /proc/meminfo`
 MEMCACHED=`awk '/^Cached/{print $2}' < /proc/meminfo`
 MEMBUFFERS=`awk '/Buffers/{print $2}' < /proc/meminfo`
 MEMFREE=`awk '/MemFree/{print $2}' < /proc/meminfo`
 MEMORY=`expr $MEMTOTAL / 1024`
 MEMUSED=`expr \( $MEMTOTAL - $MEMFREE - $MEMBUFFERS - $MEMCACHED \) / 1024`
 echo "Mem:$MEMUSED""MB"
}

volume(){
     STATUS="`amixer |awk '/Front\ Left:/ {print $4}'`"
     if test "$STATUS" != "[on]" ; then
       echo " `/usr/bin/amixer get PCM |awk '/Front\ Left:/ {print $5}' | sed -e 's/\[//g'|sed -e 's/%\]//g'`v"
     fi
   }

while true; do
 xsetroot -name "`volume` | `batt` | `mem` | `wifi` | `weather` | `date '+%a %b %d %Y %R'`"
 sleep 1
done &
exec dwm
