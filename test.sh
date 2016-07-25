#!/bin/bash

set -ex

sudo apt --assume-yes purge kitteh || true
sudo apt --assume-yes purge meows || true

sudo apt --allow-unauthenticated install kitteh=1
sudo apt --allow-unauthenticated install kitteh
dpkg -s meows
