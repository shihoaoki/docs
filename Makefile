IMAGE_NAME   = shihoase/tex
TAG          = 0.1
COTEINA_NAME = tex-env

help:
	@echo cat Makefile

convert-pdf: main.tet
	platex main.tet
	dvipdfmx main.dvi
	evince main.pdf &

docker-build:
	docker build -t $(IMAGE_NAME):$(TAG) .

docker-up: 
	docker run --name $(COTEINA_NAME) -itd $(IID)
	docker exec -it $(COTEINA_NAME) bash

docker-stop:
	docker stop $(COTEINA_NAME)

docker-down:
	docker stop $(COTEINA_NAME)
	docker rm $(COTEINA_NAME)
	docker rmi $(IMAGE_NAME):$(TAG)