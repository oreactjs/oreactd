[![Circle CI](https://circleci.com/gh/abernix/meteord/tree/master.svg?style=svg)](https://circleci.com/gh/abernix/meteord/tree/master)

# MeteorD - Docker image for MUP

## Supported tags

Please see the explanation of the [tag variations](#tag-variations) (e.g. `-binbuild`, `-onbuild`) below.

### Node 8 (Meteor 1.6, 1.7+)

#### Node 8.11.2

* `node-8-base`, `node-8.11.2-base`
* `node-8-binbuild`, `node-8.11.2-binbuild`
* `node-8-onbuild`, `node-8.11.2-onbuild`
* `node-8-devbuild`, `node-8.11.2-devbuild`

### Node 4 (Meteor 1.4, 1.5)

#### Node 4.8.7

* `node-4-base`, `node-4.8.7-base`
* `node-4-binbuild`, `node-4.8.7-binbuild`
* `node-4-onbuild`, `node-4.8.7-onbuild`
* `node-4-devbuild`, `node-4.8.7-devbuild`

### Older Node versions

For brevity, not all possibilities are listed above and there are many more available.  It's recommended that you use the latest version within the series which your Meteor was designed for (see titles above).  The most recent version will be tagged with a `node-x-*` tag accordingly.  For the full list, please see the ["Tags" tab](https://hub.docker.com/r/abernix/meteord/tags/) above.

## Tag Variations

There are three variations of each major Node-based release.

* `-base`
* `-binbuild`
* `-onbuild`
* `-devbuild`


There are two main ways you can use Docker with Meteor apps. They are:

1. Build a Docker image for your app
2. Running a Meteor bundle with Docker

**MeteorD supports these two ways. Let's see how to use MeteorD**

### 1. Build a Docker image for your app

With this method, your app will be converted into a Docker image. Then you can simply run that image.  

For that, you can use `abernix/meteord:onbuild` as your base image. Magically, that's only thing you have to do. Here's how to do it:

Add following `Dockerfile` into the root of your app:

~~~shell
FROM abernix/meteord:onbuild
~~~

Then you can build the docker image with:

~~~shell
docker build -t yourname/app .
~~~

Then you can run your meteor image with

~~~shell
docker run -d \
    -e ROOT_URL=http://yourapp.com \
    -e MONGO_URL=mongodb://url \
    -e MONGO_OPLOG_URL=mongodb://oplog_url \
    -p 8080:80 \
    yourname/app
~~~
Then you can access your app from the port 8080 of the host system.

#### Stop downloading Meteor each and every time (mostly in development)

So, with the above method, MeteorD will download and install Meteor each and every time. That's bad especially in development. So, we've a solution for that. Simply use `aberaber/meteord:devbuild` as your base image.

> WARNING: Don't use `abernix/meteord:devbuild` for your final build. If you used it, your image will carry the Meteor distribution as well. As a result of that, you'll end up with an image with ~700 MB.

### 2. Running a Meteor bundle with Docker

For this you can directly use the MeteorD to run your meteor bundle. MeteorD can accept your bundle either from a local mount or from the web. Let's see:

#### 2.1 From a Local Mount

~~~shell
docker run -d \
    -e ROOT_URL=http://yourapp.com \
    -e MONGO_URL=mongodb://url \
    -e MONGO_OPLOG_URL=mongodb://oplog_url \
    -v /mybundle_dir:/bundle \
    -p 8080:80 \
    abernix/meteord:base
~~~

With this method, MeteorD looks for the tarball version of the meteor bundle. So, you should build the meteor bundle for `os.linux.x86_64` and put it inside the `/bundle` volume. This is how you can build a meteor bundle.

~~~shell
meteor build --architecture=os.linux.x86_64 ./
~~~

#### 2.1 From the Web

You can also simply give URL of the tarball with `BUNDLE_URL` environment variable. Then MeteorD will fetch the bundle and run it. This is how to do it:

~~~shell
docker run -d \
    -e ROOT_URL=http://yourapp.com \
    -e MONGO_URL=mongodb://url \
    -e MONGO_OPLOG_URL=mongodb://oplog_url \
    -e BUNDLE_URL=http://mybundle_url_at_s3.tar.gz \
    -p 8080:80 \
    abernix/meteord:base
~~~

#### 2.2 With Docker Compose

docker-compose.yml
~~~shell
dashboard:
  image: yourrepo/yourapp
  ports:
   - "80:80"
  links:
   - mongo
  environment:
   - MONGO_URL=mongodb://mongo/yourapp
   - ROOT_URL=http://yourapp.com
   - MAIL_URL=smtp://some.mailserver.com:25

mongo:
  image: mongo:latest
~~~

When using Docker Compose to start a Meteor container with a Mongo container as well, we need to wait for the database to start up before we try to start the Meteor app, else the container will fail to start.

This sample docker-compose.yml file starts up a container that has used abernix/meterod as its base and a mongo container. It also passes along several variables to Meteor needed to start up, specifies the port number the container will listen on, and waits 30 seconds for the mongodb container to start up before starting up the Meteor container.

#### Rebuilding Binary Modules

Sometimes, you need to rebuild binary npm modules. If so, expose `REBUILD_NPM_MODULES` environment variable. It will take couple of seconds to complete the rebuilding process.

~~~shell
docker run -d \
    -e ROOT_URL=http://yourapp.com \
    -e MONGO_URL=mongodb://url \
    -e MONGO_OPLOG_URL=mongodb://oplog_url \
    -e BUNDLE_URL=http://mybundle_url_at_s3.tar.gz \
    -e REBUILD_NPM_MODULES=1 \
    -p 8080:80 \
    abernix/meteord:binbuild
~~~
