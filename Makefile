all : up

req:
	@sudo mkdir -p /home/$(USER)/data/mariadb
	@sudo mkdir -p /home/$(USER)/data/wordpress

compose:
	@sudo docker-compose -f ./srcs/docker-compose.yml build --no-cache

up: req compose
	@sudo docker-compose -f srcs/docker-compose.yml up -d

down:
	@sudo docker-compose -f srcs/docker-compose.yml down -v --remove-orphans

clean: down
	@sudo docker system prune -af
	@sudo docker network prune -f
	@sudo rm -rf /home/$(USER)/data/mariadb/*
	@sudo rm -rf /home/$(USER)/data/wordpress/*
	@sudo rm -rf /home/$(USER)/data

re: clean up

.PHONY: all req compose up down clean re
