#!/bin/bash

IMAGE="vitreus/glyphs"

DOCKER_BUILDKIT=1 docker build \
    --build-arg BUILDKIT_INLINE_CACHE=1 \
    --target base \
    --cache-from ${IMAGE}:base \
    --tag ${IMAGE}:base .

DOCKER_BUILDKIT=1 docker build \
    --build-arg BUILDKIT_INLINE_CACHE=1 \
    --target build \
    --cache-from ${IMAGE}:base \
    --cache-from ${IMAGE}:build \
    --tag ${IMAGE}:build .

DOCKER_BUILDKIT=1 docker build \
    --build-arg BUILDKIT_INLINE_CACHE=1 \
    --target dev \
    --cache-from ${IMAGE}:build \
    --cache-from ${IMAGE}:dev \
    --tag ${IMAGE}:dev .

DOCKER_BUILDKIT=1 docker build \
    --build-arg BUILDKIT_INLINE_CACHE=1 \
    --target test \
    --cache-from ${IMAGE}:build \
    --cache-from ${IMAGE}:test \
    --tag ${IMAGE}:test .

DOCKER_BUILDKIT=1 docker build \
    --build-arg BUILDKIT_INLINE_CACHE=1 \
    --target prod \
    --cache-from ${IMAGE}:build \
    --cache-from ${IMAGE}:prod \
    --tag ${IMAGE}:prod .