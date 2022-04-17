###############################################################################
# Step 1 : Builder image
#
FROM node:8-stretch AS builder

# Change working directory
WORKDIR "/app"

# Update packages and install dependency packages for services
RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get clean \
 && echo 'Finished installing dependencies'


# Install npm production packages
COPY package.json /app/
RUN cd /app; npm install

COPY . /app

###############################################################################
# Step 2 : Satge image
#
FROM builder AS prod


ENV PORT 3000

EXPOSE 3000

CMD ["npm", "start"]
