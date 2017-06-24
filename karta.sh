#!/bin/bash
GPU=$1
CLOCK_OFFSET=$2
MEMORY_OFFSET=$3
CLOCK=$4
MEMORY=$5
POWER_LIMIT=$6

CMD='sudo /usr/bin/nvidia-settings'
sudo nvidia-smi -acp UNRESTRICTED
sudo nvidia-smi -pm 1

sudo nvidia-smi -i ${GPU} -pl ${POWER_LIMIT}
sudo nvidia-smi -i ${GPU} -ac ${MEMORY},${CLOCK}
${CMD} -a [gpu:${GPU}]/GPUPowerMizerMode=1
#${CMD} -a [gpu:${i}]/GPUFanControlState=1
#${CMD} -a [fan:${i}]/GPUTargetFanSpeed=80

for x in {3..3}
  do
    ${CMD} -a [gpu:${GPU}]/GPUGraphicsClockOffset[${x}]=${CLOCK_OFFSET}
    ${CMD} -a [gpu:${GPU}]/GPUMemoryTransferRateOffset[${x}]=${MEMORY_OFFSET}
done
