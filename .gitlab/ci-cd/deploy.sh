set -e

# Login to docker registry.
echo $CI_DEPLOY_PASSWORD | docker login $CI_REGISTRY -u $CI_DEPLOY_USER --password-stdin

# Check for the project availability, otherwise pull it from the repo.
cd $SERVER_DIRECTORY || mkdir $SERVER_DIRECTORY
echo "accessing $SERVER_DIRECTORY directory"
cd $SERVER_DIRECTORY/$CI_PROJECT_NAME || (cd $SERVER_DIRECTORY && git clone $REPOSITORY_URL && \
echo "$CI_PROJECT_NAME has been cloned")
echo "accessing $CI_PROJECT_NAME directory"
(cd $SERVER_DIRECTORY/$CI_PROJECT_NAME && \
git fetch && \
git checkout $CHECKOUT_BRANCH && \
git branch && \
git pull origin $CHECKOUT_BRANCH && \
echo "latest update on $CHECKOUT_BRANCH branch has been pulled")

# Set WORKDIR to the project.
cd $SERVER_DIRECTORY/$CI_PROJECT_NAME
echo "accessing $CI_PROJECT_NAME directory"
git checkout $CHECKOUT_BRANCH

# Pull the latest image(s).
docker-compose -f docker-compose.yml -f .docker/$RAILS_ENV.yml pull

# Start the container(s).
docker-compose -f docker-compose.yml -f .docker/$RAILS_ENV.yml up -d

exit
