function uptime_int()
{
  if [ -e /proc/uptime ] ; then
    echo `cat /proc/uptime | awk '{printf "%0.f", $1}'`
  else
    set +e
    sysctl kern.boottime &> /dev/null
    if [ $? -eq 0 ] ; then
      local kern_boottime=`sysctl kern.boottime 2> /dev/null | sed "s/.* sec\ =\ //" | sed "s/,.*//"`
      local time_now=`date +%s`
      local uptime=$(($time_now - $kern_boottime))
      echo $uptime
    else
      echo "-1"
    fi
    set -e
  fi
}

echo `uptime_int`