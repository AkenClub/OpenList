#!/bin/bash

# 构建Docker镜像的脚本，支持正式版和beta版本
# 用法：
# ./build-docker.sh                  # 自动检测分支并构建对应版本
# ./build-docker.sh beta             # 强制构建beta版本，标签为beta和beta-日期
# ./build-docker.sh release v1.0.0   # 构建指定版本号的正式版，标签为v1.0.0和latest

set -e

# 默认用户名，可以通过环境变量覆盖
USERNAME=${DOCKER_USERNAME:-"openlist"}
IMAGE_NAME="${USERNAME}/openlist"

# 获取当前日期，格式为YYYYMMDD
CURRENT_DATE=$(date +%Y%m%d)

# 检查构建类型
BUILD_TYPE=${1:-"auto"}

# 如果是自动模式，则检测当前分支
if [ "$BUILD_TYPE" = "auto" ]; then
    # 获取当前分支名
    CURRENT_BRANCH=$(git branch --show-current)
    
    echo "检测到当前分支: ${CURRENT_BRANCH}"
    
    # 根据分支名确定构建类型
    if [ "$CURRENT_BRANCH" = "dev-compression" ]; then
        BUILD_TYPE="beta"
        echo "在开发分支上，将构建beta版本..."
    else
        BUILD_TYPE="release"
        echo "在非开发分支上，将构建正式版本..."
    fi
fi

if [ "$BUILD_TYPE" = "beta" ]; then
    echo "构建beta版本镜像..."
    
    # 构建多平台镜像
    docker buildx create --use --name openlist-builder || true
    
    # 构建并推送beta镜像
    docker buildx build --platform linux/amd64,linux/arm64 \
        -t "${IMAGE_NAME}:beta" \
        -t "${IMAGE_NAME}:beta-${CURRENT_DATE}" \
        --push .
    
    echo "Beta版本镜像已构建并推送，标签: beta, beta-${CURRENT_DATE}"
elif [ "$BUILD_TYPE" = "release" ]; then
    # 获取版本号
    VERSION=${2:-"latest"}
    
    echo "构建正式版镜像，版本: ${VERSION}..."
    
    # 构建多平台镜像
    docker buildx create --use --name openlist-builder || true
    
    # 构建标签列表
    TAGS="-t ${IMAGE_NAME}:${VERSION}"
    
    # 如果不是latest，则添加latest标签
    if [ "$VERSION" != "latest" ]; then
        TAGS="$TAGS -t ${IMAGE_NAME}:latest"
    fi
    
    # 构建并推送正式版镜像
    docker buildx build --platform linux/amd64,linux/arm64 \
        $TAGS \
        --push .
    
    echo "正式版镜像已构建并推送，版本: ${VERSION}"
else
    echo "未知的构建类型: ${BUILD_TYPE}"
    echo "用法:"
    echo "  ./build-docker.sh                  # 自动检测分支并构建对应版本"
    echo "  ./build-docker.sh beta             # 强制构建beta版本，标签为beta和beta-日期"
    echo "  ./build-docker.sh release v1.0.0   # 构建指定版本号的正式版，标签为v1.0.0和latest"
    exit 1
fi 