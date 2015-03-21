#!/bin/sh

if ! test -z "$1"
then
    HOST="$1"
else
    HOST="localhost"
fi

if ! test -z "$2"
then
    BASEPORT="$2"
else
    BASEPORT="59125"
fi

ENABLER_NAME="FA-TTS SE"

echo "Entering $ENABLER_NAME smoke test sequence. $ENABLER_NAME validation procedure engaged. Target host: $HOST, port: $BASEPORT"


REQUEST_URL=/info/version
echo "Run smoke test for $REQUEST_URL"

# During the first test we will tollerate some retries because the server
# may not be immediately available.
n=0
retry=1
until [ $n -ge 8 ]
do
    ITEM_RESULT=`curl -s --connect-timeout 5 -o /dev/null -w "%{http_code}" http://"$HOST:$BASEPORT$REQUEST_URL"`
    if [ "$ITEM_RESULT" -eq "200" ]; then
	break
    fi
    n=$(($n+1))
    sleep $retry
    retry=$(($retry*2))
done
if [ "$ITEM_RESULT" -ne "200" ]; then
        echo "Curl command for $REQUEST_URL failed. Validation procedure terminated."
        echo "Debug information: HTTP code $ITEM_RESULT instead of expected 200 from $HOST:$BASEPORT"
        exit 1;
else
        echo "Curl command for $REQUEST_URL OK."
fi

REQUEST_URL=/info/voices/all
echo "Run smoke test for $REQUEST_URL"

ITEM_RESULT=`curl -s -o /dev/null -w "%{http_code}" http://"$HOST:$BASEPORT$REQUEST_URL"`
if [ "$ITEM_RESULT" -ne "200" ]; then
        echo "Curl command for $REQUEST_URL failed. Validation procedure terminated."
        echo "Debug information: HTTP code $ITEM_RESULT instead of expected 200 from $HOST:$BASEPORT"
        exit 1;
else
        echo "Curl command for $REQUEST_URL OK."
fi

VOICE_ID=`curl -s http://"$HOST:$BASEPORT$REQUEST_URL" | sed -e 's/.*"id":"\([^"]*\)".*/\1/' | head -n 1`
REQUEST_URL=/info/voice/"$VOICE_ID"/inputs/all
echo "Run smoke test for $REQUEST_URL"

ITEM_RESULT=`curl -s -o /dev/null -w "%{http_code}" http://"$HOST:$BASEPORT$REQUEST_URL"`
if [ "$ITEM_RESULT" -ne "200" ]; then
        echo "Curl command for $REQUEST_URL failed. Validation procedure terminated."
        echo "Debug information: HTTP code $ITEM_RESULT instead of expected 200 from $HOST:$BASEPORT"
        exit 1;
else
        echo "Curl command for $REQUEST_URL OK."
fi

echo "Smoke test completed. $ENABLER_NAME validation procedure succeeded. Over."
