<<<<<<< HEAD
# Vapor Example

Fork this example project as a boilerplate for working with Vapor.

Check out the [live demo](http://example.qutheory.io) running on Ubuntu.

## Badges
[![Build Status](https://img.shields.io/travis/qutheory/vapor-example.svg?style=flat-square)](https://travis-ci.org/qutheory/vapor-example)
[![PRs Welcome](https://img.shields.io/badge/prs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Slack Status](http://slack.qutheory.io/badge.svg?style=flat-square)](http://slack.qutheory.io)

## Deploy

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Documentation

View [Vapor](https://github.com/qutheory/vapor) for documentation.

## Requirements

Swift 3.0 preview 2 is required (Xcode 8 beta 2 on macOS). 

Works on Ubuntu, Docker, Heroku, macOS.

Run the following script to check if you have Swift 3.0 beta 2 properly installed and configured.

```
curl -sL check.qutheory.io | bash
```

## Building

Visit [Getting Started](http://docs.qutheory.io) in the documentation.

### Compiling

If you have the [Vapor Toolbox](https://github.com/qutheory/vapor-toolbox), use `vapor new <project-name>` to create your new application.

Then run `vapor build` and `vapor run`.

Otherwise, clone this repo and run `swift build` to compile your application, then run `.build/debug/App`.

### Xcode 8

Run `vapor xcode` which will create the Xcode Project and open Xcode 8.

![Xcode](https://cloud.githubusercontent.com/assets/1342803/15592631/3e740df8-2373-11e6-8624-3c89260322aa.png)

## Deploying

Check the [Vapor](https://github.com/qutheory/vapor) documentation for more in-depth deployment instructions.

### Upstart

To start your `Vapor` site automatically when the server is booted, add this file to your server.

You can check if Upstart is installed with 

```sh
initctl --version
```

You may need to install Upstart if it is not already on your installation of Linux.

```sh
sudo apt-get install upstart
```

`/etc/init/vapor-example.conf`

```conf
description "Vapor Example"

start on startup

env PORT=8080

exec /home/<user_name>/vapor-example/.build/release/App --env=production
```

You additionally have access to the following commands for starting and stopping your server.

```shell
sudo stop vapor-example
sudo start vapor-example
```

The following script is useful for upgrading your website.

```shell
git pull
swift build --configuration release
sudo stop vapor-example
sudo start vapor-example
```

### Heroku

Use the `vapor heroku` commands in the Vapor Toolbox to push to Heroku.

### Docker

You can run this demo application locally in a Linux environment using Docker.

Make sure you have installed the Vapor Toolbox.

1. Ensure [Docker](https://www.docker.com) is installed on your local machine.
2. Start the Docker terminal
3. cd into `vapor-example`
4. Create the Dockerfile `vapor docker init`
5. Build the container `vapor docker build`
6. Run the container `vapor docker run`
7. Optionally enter the container `vapor docker enter`
5. Configure VirtualBox to [forward ports 8080 to 8080](https://www.virtualbox.org/manual/ch06.html)
6. Visit http://0.0.0.0:8080

### Nginx / Supervisor

You can also run your Vapor app through Nginx.  It’s recommended you use [Supervisor](http://supervisord.org) to run the app instance to protect against crashes and ensure it’s always running.

#### Supervisor

To setup Vapor running through Supervisor, follow these steps:

`apt-get install -y supervisor`

Edit the config below to match your environment and place it in `/etc/supervisor/conf.d/your-app.conf`:

```shell
[program:your-app]
command=/path/to/app/.build/release/App serve --ip=127.0.0.1 --port=8080
directory=/path/to/app
user=www-data
stdout_logfile=/var/log/supervisor/%(program_name)-stdout.log
stderr_logfile=/var/log/supervisor/%(program_name)-stderr.log
```

Now register the app with Supervisor and start it up:
```shell
supervisorctl reread
supervisorctl add your-app
supervisorctl start your-app # `add` may have auto-started, so disregard an “already started” error here
```

#### Nginx

With the app now running via Supervisor, you can use this sample nginx config to proxy it through Nginx:

```nginx
server {
	server_name your.host;
	listen 80;

	root /path/to/app/Public;

	# Serve all public/static files via nginx and then fallback to Vapor for the rest
	try_files $uri @proxy;

	location @proxy {
		# Make sure the port here matches the port in your Supervisor config
		proxy_pass http://127.0.0.1:8080;
		proxy_pass_header Server;
		proxy_set_header Host $host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_connect_timeout 3s;
		proxy_read_timeout 10s;
	}
}
```
=======
# 📔 Vapor Todo Backend

Run the specs [here](https://todo-backend-vapor.herokuapp.com)

[Vapor](https://github.com/vapor/vapor) is a Swift backend framework to build server-side applications in Swift.

[TodoBackend](http://www.todobackend.com) is a proof-of-concept catalog to demonstrate the implementation of the same simple API using different backend frameworks.

This project is a TodoBackend implementation using Vapor, Swift and MySQL as a backend stack.

## 🌎 Environment

- Swift 3.0 Gold Master
- MySQL Database Credentials

## 🦄 Deploy

Fully deploy w/ MySQL Database included on Heroku.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## 🛠 Setup

### Swift 3.0

Download latest Xcode 8 and make sure it's been opened at least once. Also make sure command line tools are set to Xcode 8 in Xcode's preferences.

> Xcode > Preferences > Locations > Command Line Tools

### MySQL Config

To build, the first place you'll want to look is the `Config/` directory. In their, you should create a `secrets` folder and a nested `mysql.json`. Here's how my `Config/` folder looks locally.

```
Config/
  - mysql.json
	secrets/
	  - mysql.json
```

The `secrets` folder is under the gitignore and shouldn't be committed.

Here's an example `secrets/mysql.json`

```json
{
  "host": "z99a0.asdf8c8cx.us-east-1.rds.amazonaws.com",
  "user": "username",
  "password": "badpassword",
  "database": "databasename",
  "port": "3306",
  "encoding": "utf8"
}

```

### Vapor CLI

The Vapor Command Line Interface makes it easy to build and run Vapor projects. Install it on Mac by running

#### Brew

```sh
brew install vapor/tap/toolbox
```

#### Curl

```sh
curl -sL toolbox.vapor.sh | bash
```

## Manual Deploy

When deploying, one may optionally include the `secrets` folder if they have a secure way of doing so. The official deploy is done through use of environment variables configured on the server that match the following scheme.

#### `mysql.json`

```
{
  "host": "$MYSQL_HOST",
  "user": "$MYSQL_USER",
  "password": "$MYSQL_PASS",
  "database": "$MYSQL_DB",
  "port": "$MYSQL_PORT",
  "encoding": "utf8"
}

// OR

{
  "url": "mysql://user:pass@host:3306/database"
}
```


Checkout [more documentation here](https://vapor.github.io/documentation/)

## 🙌 Thanks

A great deal of work on this library was originally done by @sarbogast. Thanks 🙌
>>>>>>> 772ef2a018d8fd83ffae6b9e8716937a55474a33
