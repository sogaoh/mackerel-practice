#!/bin/bash

SECONDS=`date '+%s'`

cd .

COMMAND="speedtest -s 6087 -f json"
JSONFILE="./speedtest-attempts.json"
LOGFILE="./speedtest-attempts.log"
JUDGE_KEY=".type"
OK_VALUE="\"result\""

# json に result がなかったら45秒待ってリトライ。３回目も失敗したら exit -1
NUM_OF_ATTEMPTS=0
COMMAND_STATUS=1
until [ $COMMAND_STATUS -eq 0 -o $NUM_OF_ATTEMPTS -eq 4 ]; do
  DATETIME=`date "+%Y/%m/%d %H:%M:%S"`
  echo "[$DATETIME] #$NUM_OF_ATTEMPTS" >> $LOGFILE
  $COMMAND > $JSONFILE
  if [[ -e $JSONFILE ]]; then
    COMMAND_RESULT=`cat $JSONFILE | jq $JUDGE_KEY`
    if [[ $COMMAND_RESULT = $OK_VALUE ]]; then
      COMMAND_STATUS=0
    else
      COMMAND_STATUS=1
    fi
  else
    COMMAND_STATUS=2
  fi
  sleep 45
  let NUM_OF_ATTEMPTS=NUM_OF_ATTEMPTS+1
  DATETIME=`date "+%Y/%m/%d %H:%M:%S"`
  echo "[$DATETIME] #$NUM_OF_ATTEMPTS -> $COMMAND_STATUS ($COMMAND_RESULT)" >> $LOGFILE
done

if [ $NUM_OF_ATTEMPTS -ge 4 -a $COMMAND_STATUS -ne 0 ]; then
  exit -1
fi


NAME1='bandwidth.download'
BW1=`cat $JSONFILE | jq ".download.bandwidth"`
VALUE1=`echo "scale=2; ${BW1} * 8 / 1000 / 1000" | bc`
echo -e "${NAME1}\t${VALUE1}\t${SECONDS}"

NAME2='bandwidth.upload'
BW2=`cat $JSONFILE | jq ".upload.bandwidth"`
VALUE2=`echo "scale=2; ${BW2} * 8 / 1000 / 1000" | bc`
echo -e "${NAME2}\t${VALUE2}\t${SECONDS}"

rm -f $JSONFILE

exit 0