#!/bin/bash

sensors_output=$(sensors)

system_temp=$(echo "$sensors_output" | \
  awk '/^acpitz-acpi-0/ {getline; getline; print $2}')

cpu_overall=$(echo "$sensors_output" | \
  awk '/Package id 0:/ {print $4}')
core0=$(echo "$sensors_output" | awk '/Core 0:/ {print $3}')
core1=$(echo "$sensors_output" | awk '/Core 1:/ {print $3}')
core2=$(echo "$sensors_output" | awk '/Core 2:/ {print $3}')
core3=$(echo "$sensors_output" | awk '/Core 3:/ {print $3}')

pch_temp=$(echo "$sensors_output" | \
  awk '/^pch_skylake-virtual-0/ {getline; getline; print $2}')

nvme_temp=$(echo "$sensors_output" | \
  awk '/Composite:/ {print $2}')

echo "$sensors_output"
echo ""
echo "Debug values:"
echo "System: $system_temp"
echo "CPU: $cpu_overall"
echo "Cores: $core0 $core1 $core2 $core3"
echo "PCH: $pch_temp"
echo "NVMe: $nvme_temp"

notify-send "Temperatures" "System: ${system_temp}
CPU: ${cpu_overall} (${core0}, ${core1}, ${core2}, ${core3})
PCH: ${pch_temp}
NVME: ${nvme_temp}"
