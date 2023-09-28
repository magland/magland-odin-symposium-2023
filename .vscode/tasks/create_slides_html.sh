#!/bin/bash

# Create slides.html from slides.md
marp slides.md --theme theme.css --html -o slides.html

# open slides.html in a browser
google-chrome slides.html