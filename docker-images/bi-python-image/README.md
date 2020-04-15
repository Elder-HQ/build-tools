## First time login
    docker login
Ask a fellow developer for the credentials

## To build an image
    docker build . -t elderhq/bi-python-image:20200415-1
    docker push elderhq/bi-python-image:20200415-1

...or just run:

    ./build-tag-push 20200415-1
