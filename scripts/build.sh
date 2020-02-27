#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# fide 项目构建脚本
# @author Zhang Peng
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------ load libs
SCRIPTS_DIR=$(cd `dirname $0`; pwd)
if [[ ! -x ${SCRIPTS_DIR}/lib/maven.sh ]]; then
    logError "必要脚本库 ${SCRIPTS_DIR}/lib/maven.sh 不存在！"
    exit ${ENV_FAILED}
fi
source ${SCRIPTS_DIR}/lib/maven.sh

# ------------------------------------------------------------------------------ main
if [[ ! $1 ]] ; then
    logError "you must input following params in order:"
    echo -e "${ENV_COLOR_B_RED}"
    echo "    (1) maven lifecycle oper"
    echo "    (2) maven profile             [optional]"
    echo -e "\nExample: build.sh package prod"
    echo -e "${ENV_COLOR_RESET}"
    exit ${ENV_FAILED}
fi

ROOT_DIR=$(cd `dirname $0`/..; pwd)
logInfo ">>>> maven build begin\n"
logInfo "项目构建路径：${ROOT_DIR}\n"

mavenOperation ${ROOT_DIR} $1 $2
if [[ "$?" == "${ENV_SUCCEED}" ]]; then
    logInfo "<<<< maven build succeed\n"
    exit ${ENV_SUCCEED}
else
    logError "<<<< maven build failed\n"
    exit ${ENV_FAILED}
fi