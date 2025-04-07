# Spotify-Rails
This application was created and developed on a Windows computer. If you are running this application from a Windows computer, for a better experience, please use the Windows Subsystem for Linux (WSL), which allows you to run Linux distributions natively without the need for a Virtual Machine (VM). This application was developed on a Linux server. 

## Application Description
Spotify-Rails is a streaming music platform enabling artist payments via Stripe.

This app uses:
* Cron Jobs for task scheduling and process automation for daily artist payouts.
* Integrated Stimulus for dynamic frontend interactions.
* Utilized AWS S3 for scalable audio and image storage.
* Deployed and managed the application on Heroku using Ubuntu and the Heroku CLI.

## How to run this project?
* If you are using a Windows computer, please open Ubuntu and run the following command to initialize the PostgreSQL database: `sudo service postgresql start`
* Run the server: `bin/dev`
* To run the seeds: `rails db:seed`

## Technologies used to develop this project:
<p align="center">
  <a href="https://skillicons.dev">
    <img src="https://skillicons.dev/icons?i=rails,js,postgresql,tailwind" />
  </a>
</p>

##### Make sure you install and run the latest features: 

* Ruby version: 3.3.5

* System dependencies

* Configuration

# Website 
Click the following link to access the website: https://spotify-rails-5858064d71c3.herokuapp.com/
