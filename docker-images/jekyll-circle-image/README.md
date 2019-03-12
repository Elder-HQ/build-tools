## First time login
    docker login
Ask a fellow developer for the credentials
## To build an image
    docker build . -t elderhq/jekyll-circle-image:{date}
    docker push elderhq/jekyll-circle-image:{date}
Replace `{date}` with format `YYYYMMDD-1`
