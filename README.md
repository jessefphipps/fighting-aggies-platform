# Fightin Aggies Platform

Developing a analytical panel to generate insights that help facilitate the post-game analysis done by the coaches and players of Fightin Texas Aggies Football team.

### Deployment - [Heroku](https://fightin-aggies.herokuapp.com/)

### Dependencies
- Ruby~3.1.2
  - For Windows
  ```bash
  winget install RubyInstallerTeam.Ruby
  ```
  - For Ubuntu
  ```bash
  sudo apt-get install ruby-full // for Ubuntu
  ```
  - For MacOS using [Homebrew](https://brew.sh/)
  ```bash
    brew install ruby // for MacOS
  ```
- Rails~7.0.4
 ```bash
 gem install rails
 ```
- yarn~1.22.19
- ffmpeg
  - For Windows,
    - Go to the [link](https://www.gyan.dev/ffmpeg/builds/ffmpeg-git-full.7z).
    - Extract the file to where you want it to be and rename it as ffmpeg.
    - Run the Command Prompt as admin and write 
    ```bash
    setx /m PATH "path\to\ffmpeg\bin;%PATH%"
    ```
  - For Ubuntu,
  ```bash
  sudo apt install ffmpeg
  ```
- Cucumber
  - For Ubuntu,
  ```bash
  sudo apt install cucumber
  ```
- ChromeDriver
  - For Ubuntu,
  ```bash
  sudo wget sudo wget https://chromedriver.storage.googleapis.com/106.0.5249.61/chromedriver_linux64.zip
  sudo unzip chromedriver_linux64.zip
  sudo mv chromedriver /usr/bin/chromedriver
  ```
- Chrome
  - For Ubuntu,
  ```bash
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo apt install ./google-chrome-stable_current_amd64.deb
  ```
  
### Installation and Running Instructions
```bash
git clone https://github.com/jessefphipps/fighting-aggies-platform.git
cd fighting-aggies-platform
bundle install
yarn install
/bin/dev
```
### Testing Instructions
```bash
cd fighting-aggies-platform
cucumber
```
