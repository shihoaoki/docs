FROM ubuntu:18.04

WORKDIR /app/docs

RUN apt update -y && \
    apt update -y
RUN apt install -y make
RUN apt install evince -y && \
    # apt install texlive-fonts-extra -y && \
    # apt install texlive-fonts-recommended -y && \
    apt install texlive-lang-cjk -y && \
    apt install xdvik-ja -y && \
    apt install yatex -y

COPY Makefile .

VOLUME src /app/docs/src
