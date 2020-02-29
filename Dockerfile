FROM alpine

RUN apk --no-cache add bash git diffutils grep curl

ENV PS1 "\n\n>> alf \W \$ "

WORKDIR /app

COPY . .
COPY alf /usr/local/bin/alf

RUN git config --global user.email "tester@testland.com" && \
    git config --global user.name "Approval Tester"

RUN chmod +x /usr/local/bin/alf
