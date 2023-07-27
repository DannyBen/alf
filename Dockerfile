# This dockerfile is designed for testing alf in isolation
FROM alpine

RUN apk --no-cache add bash git diffutils grep curl zsh

ENV PS1 "\n\n>> alf \W \$ "

WORKDIR /app

COPY . .
COPY alf /usr/local/bin/alf

RUN git config --global pull.rebase false && \
    git config --global user.email "tester@testland.com" && \
    git config --global user.name "Approval Tester" && \
    git config --global --add safe.directory '*'

RUN chmod +x /usr/local/bin/alf
