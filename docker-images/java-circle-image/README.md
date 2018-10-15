## First time login
    docker login
Ask a fellow developer for the credentials
## To build an image
    docker build . -t elderhq/java-circle-image:20170318-1
    docker push elderhq/java-circle-image:20170318-1

## To update the Elder dependencies
* Update the java-dependencies project in this repository and push changes
* Update the Dockerfile to have a unique line printed when pulling the repository
* Build and push a new version of the image as per above
* Use new image in the circle.yml file where it's needed
