
# Test Dockerfile with rspec

I saw this post about testing Dockerfile builds with serverspec:
https://robots.thoughtbot.com/tdd-your-dockerfiles-with-rspec-and-serverspec

I wondered if it wass possible to do the same testing using docker itself (docker-in-docker).

So you won't depend on any gems or packages isntalled locally.

With a little bit of hacking - sure its possible!

Install whatever ruby wants to run rspec/serverspec:

```
docker run --rm -ti \
       --net host  \
       --name ruby \
       -e BUNDLE_PATH=/usr/src/app/rubies \
       -e BUNDLE_BIN=/usr/src/app/rubies \
       -e BUNDLE_APP_CONFIG=/usr/src/app/rubies \
       -e GEM_HOME=/usr/src/app/rubies \
       -v /var/run/docker.sock:/var/run/docker.sock \
       -v "$PWD":/usr/src/app \
       -e PATH=/usr/local/bundle/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/src/app:/usr/src/app/rubies \
       -w /usr/src/app ruby:2.1  \
       bundler install
```

And then run tests with ```rspec``` instead of ```bundler install```  
