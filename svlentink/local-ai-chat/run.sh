#!/bin/bash
if [ -z "`podman images|grep local-ai-chat`" ]; then
	podman build -t local-ai-chat .
fi
podman run --rm --memory-swap=5g --memory=4g -it local-ai-chat

