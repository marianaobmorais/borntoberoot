#!/bin/bash

#Architecture
ARCH=$(uname -- all)

#CPU physical
CPUF=$(grep "physical id" /proc/cpuinfo | wc -l)

#vCPU
CPUV=$(grep processor /proc/cpuinfo | wc -l)

#Memory usage
USED_RAM=$(free --mega | awk '$1 == "Mem:" {print $3}')
TOTAL_RAM=$(free --mega | awk '$1 == "Mem:" {print $2}')
RAM_PERCENT=$(free --mega | awk '$1 == "Mem:" {printf("%.2f%%"), $3/$2*100}')

#Disk usage
USED_DISK=$(df -m | grep "/dev" | grep -v "/boot" | awk '{used_mem += $3} END {print used_mem}')
DISK_TOTAL=$(df -m | grep "/dev" | grep -v "/boot" | awk '{total_mem += $2} END {printf("%.0fGb"), total)mem/1024}')
DISK_PERCENT=$(df -m | grep "/dev" | grep -v "/boot" | awk '{used += $3} {total += $2} END {printf("%d%%), used/total *100}')

#CPU load
CPU_LOAD=$(vmstat | tail -1 | awk '{print $15}')

#Last boot
LB=$(who -b | awk '$1 == "system" {print $3 " " $4}')

#LVM use
LVMU=$(if [ $(lsblk | grep "lvm" | wc -l) -gt 0]; then echo yes; else echo no; fi)

#Connections TCP
TCPC=$(ss -ta | grep ESTAB | wc -l)

#User log
ULOG=$(users | wc -w)

#Network
IP=$(hostname -I)
MAC=$(ip link | grep "link/ether" | awk '{printf ("%s"), $2}')

#Sudo
CMND=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall "  #Architecture: $ARCH
        #CPU physical: $CPUF
        #vCPU: $CPUV
        #Memory usage: $USED_RAM/${TOTAL_RAM}MB ($RAM_PERCENT)
        #Disk usage: $USED_DISK/${DISK_TOTAL} ($DISK_PERCENT)
        #CPU load: $CPU_LOAD%
        #Last boot: $LB
        #LVM use: &LVMU
        #Connections TCP: $TCPC ESTABLISHED
        #User log: $ULOG
        #Network: IP $IP ($MAC)
        #Sudo: $CMND"
