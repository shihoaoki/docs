IMAGE_NAME   = shihoase/tex
TAG          = 0.1
COTEINA_NAME = tex-env

help:
	@cat Makefile

# converter
.PHONY: convert-pdf
convert-pdf: main.txt
	platex main.txt
	dvipdfmx main.dvi
	evince main.pdf &

# env
.PHONY: up
up:
	dokcer-compose up

.PHONY: up/d
up/d:
	ifeq ($(BASH), true)
		dokcer-compose up -d
		dokcer-compose exec /bin/bash
	else
		docker-compose up -d
	endif

.PHONY: stop
stop:
	docker-compose stop

.PHONY: down
down:
	docker-compose down

.PHONY: rm
rm: 
	docker-compose down --rmi all --volumes --remove-orphans

.PHONY: logs
logs:
	docker-compose logs -f

# health check
.PHONY: docker-ichekc
docker-ichekc:
	docker image ls
.PHONY: docker-chekc
docker-chekc:
	docker ps -a

# dokcer native
.PHONY: docker-build
docker-build:
	docker build -t $(IMAGE_NAME):$(TAG) .

.PHONY: docker-up
docker-up: 
	# this command need arg = IID
	# chekc IID: make docker-ichekc
	docker run --name $(COTEINA_NAME) -itd $(IID)
	docker exec -it $(COTEINA_NAME) bash

.PHONY: docker-stop
docker-stop:
	docker stop $(COTEINA_NAME)

.PHONY: docker-down
docker-down:
	docker stop $(COTEINA_NAME)
	docker rm $(COTEINA_NAME)
	docker rmi $(IMAGE_NAME):$(TAG)