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

### Installation and Running Instructions
```bash
git clone https://github.com/jessefphipps/fighting-aggies-platform.git
cd fighting-aggies-platform
bundle install
yarn install
/bin/dev
```
