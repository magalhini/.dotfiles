# Work
alias cd-app='cd ~/Documents/Work/gathercontent-app'
alias syncgc='bash ~/Documents/Work/sync-sh'
alias apisync='php artisan dev:sync api.gatherdevricardo.com --composer --migrate --verbose'
alias apimigrate='php artisan migrate:refresh --seed'

# System: Lock
alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Open this bash
alias openbash='open ~/.bash_profile'

# System: clear trash and remove slippage
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash; sudo rm /private/var/vm/sleepimage"

# List ALL files (colorized() in long format, show permissions in octal
alias la="ls -l | awk '
{
  k=0;
  for (i=0;i<=8;i++)
    k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));
  if (k)
    printf(\"%0o \",k);
  printf(\" %9s  %3s %2s %5s  %6s  %s %s %s\n\", \$3, \$6, \$7, \$8, \$5, \$9,\$10, \$11);
}'"

# IP
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

alias sshdev='ssh www-data@dev-app01'
alias resize='mkdir small && for i in *.JPG; do sips -Z 1280 $i --out “small/${i%.*}.jpg;” done'

alias server="python -m SimpleHTTPServer 8100 & /usr/bin/open -a '/Applications/Google Chrome.app' 'http://localhost:8100/'"
alias killserver="kill -9 echo /tmp/server"

# Functions

# Create a new directory and enter it
function md() {
	mkdir -p "$@" && cd "$@"
}


# find shorthand
function f() {
    find . -name "$1" 2>&1 | grep -v 'Permission denied'
}

# cd into whatever is the forefront Finder window.
cdf() {  # short for cdfinder
  cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
}

# animated gifs from any video
# from alex sexton   gist.github.com/SlexAxton/4989674
gifify() {
  if [[ -n "$1" ]]; then
    if [[ $2 == '--good' ]]; then
      ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
      time convert -verbose +dither -layers Optimize -resize 900x900\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $1.gif
      rm out-static*.png
    else
      ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
    fi
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}

# turn that video into webm.
# brew reinstall ffmpeg --with-libvpx
webmify(){
	ffmpeg -i $1 -vcodec libvpx -acodec libvorbis -isync -copyts -aq 80 -threads 3 -qmax 30 -y $2 $1.webm
}

function t() {
    tree —-dirsfirst —-filelimit 15 -L ${1:-3} -C $2
}

function cdev() {
    git checkout develop && git pull
}

function ghotfix() {
    git checkout master && git pull && git checkout -b "hotfix-$1"
}

function gfeature() {
    git checkout develop && git pull && git checkout -b "feature-$1"
}

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

export PATH=~/bin:/usr/local/php5/bin:$PATH

# Get auto-complete branch script
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
