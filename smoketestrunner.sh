#Copyright (c) 2015, Fraunhofer IAIS, Thales and many others FIC2Lab contributors
#All rights reserved.
#(adaptation from https://github.com/fraunhoferfokus/particity/blob/master/LICENSE)

#Redistribution and use in source and binary forms, with or without
#modification, are permitted provided that the following conditions are met:

#* Redistributions of source code must retain the above copyright notice, this
#  list of conditions and the following disclaimer.

#* Redistributions in binary form must reproduce the above copyright notice,
#  this list of conditions and the following disclaimer in the documentation
#  and/or other materials provided with the distribution.

#* Neither the name of particity nor the names of its
#  contributors may be used to endorse or promote products derived from
#  this software without specific prior written permission.

#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
#FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
#SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
#CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
#OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
#OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


# use this script in a Software Production Line system (aka CI/CD/DevOps) for rapid integration testing

#!/bin/bash

# generic runner for container smoke tests
#call parameters

#PRODUCT_NAME=se_productname
#TAG=domain/productname:latest
#VENDOR_PORT=123456
#SMOKETEST=[OPTIONALPATH]smoketest.sh # call iface smoketest.sh $HOST $PORT
#SUBDIR=optional # then cd
PRODUCT_NAME=$1
TAG=$2
VENDOR_PORT=$3
SMOKETEST=$4
WAITFOR=120

if [ -n "$5" ]; then
    WAITFOR=$5
fi

HOST=localhost

echo "listing test runner params:"
echo "PRODUCT_NAME=$PRODUCT_NAME"
echo "TAG=$TAG"
echo "VENDOR_PORT=$VENDOR_PORT"
echo "SMOKETEST=$SMOKETEST"
echo "WAITFOR=$WAITFOR"


if [ -n "$SMOKETEST" ];
then
   echo "Smoketest param check: $SMOKETEST"
else
   echo "Smoketest not specified. Test failed."
   exit 1
fi



echo "purge obsolete container with same name (if exists); if this action fails, this means only that no obsolete container is to purge."
docker rm -f $PRODUCT_NAME || true
echo "ending obsolete container purge step; proceeding test procedure."


# get next free port, launch test container, run vendor smoke test, tear down test container
echo "enter smokerunner.sh for container unit test. ... ENGAGE THE FIRESTARTER.."

echo "check for availability of the vendor component unit test file"


if [ -f $SMOKETEST ];
then
   echo "Vendor component unit test exists: $SMOKETEST. Check passed."
else
   echo "Vendor component unit test $SMOKETEST cannot be located. Test failed."
   exit 1
fi

echo "Now check the system environment for docker executable and its version."
 
which docker
docker --version
which curl
curl --version

#FREEPORT=$(($(netstat -tn | sed -e "s#.*:##" -e "s# .*##" | sort -n | tail -n 1)+1))
#echo "identified next free port: $FREEPORT"

ls
echo "setup test container"

# Running container exposing to random ports
DOCKER_COMMAND="docker run -d -P --name $PRODUCT_NAME $TAG"
echo "docker command: $DOCKER_COMMAND"
docker run -d -P --name $PRODUCT_NAME $TAG


echo "scan for docker port mapping"
# Finding out what port VENDOR_PORT is mapped to
PORT=$(docker port $PRODUCT_NAME $VENDOR_PORT | cut -d: -f2)

if [ -n "$PORT" ];
then
   echo "Docker container is mapped to local port $PORT"
else
   echo "Could not retrieve the local port binding for container $PRODUCT_NAME. Are you sure the container listens on port $VENDOR_PORT ?"
   echo "try to tear off container if created"
   docker rm -f $PRODUCT_NAME

   exit 1
fi


#chmod u+x $SMOKETEST

echo "Waiting $WAITFOR seconds to make sure the service is ready... Get you a glas of water :-)"
sleep $WAITFOR

#while ! (netcat -vz $HOST $PORT 2> /dev/null); do echo -n "."; sleep 5; done
#echo ""
#echo "Service is running on port $PORT."


bash $SMOKETEST $HOST $PORT
RET=$?

if [ $RET != 0 ]; then
         echo Vendor unit test failed with code $RET
        echo 'Container logs:'
        docker logs --timestamps=true $PRODUCT_NAME
fi

echo "tear off test container to release system resources"
docker rm -f $PRODUCT_NAME

exit $RET
