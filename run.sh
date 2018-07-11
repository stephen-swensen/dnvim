# docker run --name dnvim -it -u `id -u`:`id -g` -v $(pwd):/dnvim dnvim

docker run --name dnvim -it -v $(pwd):/dnvim dnvim
docker rm dnvim
