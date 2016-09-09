#!/bin/bash -x



# build the docker container
function build_container() {

    echo "Building AVR Tools container"

    mkdir -p VAR && docker build --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
    --build-arg VCS_REF=`git rev-parse --short HEAD` \
    -t ubirch/avr-build:v${GO_PIPELINE_LABEL} .


    if [ $? -eq 0 ]; then
        echo ${GO_PIPELINE_LABEL} > VAR/${GO_PIPELINE_NAME}_${GO_STAGE_NAME}
    else
        echo "Docker build failed"
        exit 1
    fi

}

# publish the new docker container
function publish_container() {
  echo "Publishing Docker Container with version: ${GO_PIPELINE_LABEL}"
  docker push ubirch/avr-build:v${GO_PIPELINE_LABEL}

  if [ $? -eq 0 ]; then
    echo ${GO_PIPELINE_LABEL} > VAR/GO_PIPELINE_NAME_${GO_PIPELINE_NAME}
  else
    echo "Docker push faild"
    exit 1
  fi

}


case "$1" in
    build)
        build_container
        ;;
    publish)
        publish_container
        ;;
    *)
        echo "Usage: $0 {build|publish}"
        exit 1
esac

exit 0
