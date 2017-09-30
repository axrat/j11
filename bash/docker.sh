
dockernonermiall(){
  docker images | awk '/<none/{print $3}' | xargs sudo docker rmi
}
