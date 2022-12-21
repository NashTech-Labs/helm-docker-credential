if [[ $# < 1 ]]; then
echo -e "[Error] Missing 1 arguement - helm chart name"
echo
echo "Usage: ./dock.sh HELM_CHART_DIR"
exit 1
fi

HELM_CHART=$1

VALUES_FILE=$HELM_CHART/values.yaml
EXTENDS=extended-values.yaml

usage(){
  echo -e "[Error] Missing environment variables $1"
  echo 
  echo -e "Usage:\n\nexport CONTAINER_REGISTRY=<CONTAINER_REGISTRY>\nexport REGISTRY_USERNAME=<REGISTRY_USERNAME>\nexport REGISTRY_PASSWORD=<REGISTRY_PASSWORD>\n"
  echo "./dock.sh HELM_CHART_DIR"
}

if [[ $CONTAINER_REGISTRY == null || $CONTAINER_REGISTRY == "" ]]; then
usage CONTAINER_REGISTRY
exit 1
elif [[ $REGISTRY_USERNAME == null || $REGISTRY_USERNAME == "" ]];then
usage REGISTRY_USERNAME
exit 1
elif [[ $REGISTRY_PASSWORD == null || $REGISTRY_PASSWORD == "" ]];then
usage REGISTRY_PASSWORD
exit 1
fi

if [[ -f ~/.docker/config.json  ]]; then
sudo rm ~/.docker/config.json
fi
docker login $CONTAINER_REGISTRY -u $REGISTRY_USERNAME -p $REGISTRY_PASSWORD
DOCKER_SECRET=$(cat ~/.docker/config.json|jq -c|base64|tr -d "\n")
echo -e "dockerRegistryCredentials: $DOCKER_SECRET\n" >> $EXTENDS

echo >> $VALUES_FILE
cat $EXTENDS >> $VALUES_FILE
rm $EXTENDS