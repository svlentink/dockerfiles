#!/bin/bash

help () {
cat << EOF

This build tester is created to solve a very unusual edge case.
On RHEL7 you are likely to work with an old Podman (0.12),
which saves intermediate layers to /tmp/buildah1234/layer,
which requires your /tmp directory to be at least the size of your container.
If this is not the case and you still want to test if your
Dockerfile is able to build, you can use this script.

Just run call this script in the directory your Dockerfile lives.
NOTE: we only support one FROM and ENV, ARG, RUN, COPY and WORKDIR.
EOF
}

which podman && docker=podman

CONTAINERNAME=`grep FROM Dockerfile|head -1|awk '{print $2}'`

SCRIPT=/tmp/temp-build-tester
echo "#!/bin/sh" > $SCRIPT
chmod +x $SCRIPT
grep -E "ENV|ARG|RUN|COPY|WORKDIR" Dockerfile >> $SCRIPT
sed -i "s/^ENV/export\ /g" $SCRIPT
sed -i "s/^ARG/export\ /g" $SCRIPT
sed -i "s/^RUN//g"         $SCRIPT
sed -i "s/^COPY/cp\ /g"    $SCRIPT
sed -i "s/^WORKDIR/cd\ /g" $SCRIPT

docker run \
  --rm \
  -v $PWD:/workdir:ro \
  --workdir "/workdir" \
  -v $SCRIPT:/entrypoint.sh \
  --entrypoint /entrypoint.sh \
  $CONTAINERNAME

