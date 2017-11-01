PS1="\[\e[32m\][\[\e[m\]\[\e[0;36m\!\e[m|\\e[36m\](¬_¬)\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[31m\]\h\[\e[m\]:\[\e[32m\]\W\[\e[m\]\[\e[32m\]]\[\e[m\]\[\\]\\$\[\] "
# Author: Eli Fatsi
# https://www.viget.com/articles/create-a-github-repo-from-the-command-line
github-create() {
 repo_name=$1

 dir_name=`basename $(pwd)`

 if [ "$repo_name" = "" ]; then
 echo "Repo name (hit enter to use '$dir_name')?"
 read repo_name
 fi

 if [ "$repo_name" = "" ]; then
 repo_name=$dir_name
 fi

 username=`git config github.user`
 if [ "$username" = "" ]; then
 echo "Could not find username, run 'git config --global github.user <username>'"
 invalid_credentials=1
 fi

 token=`git config github.token`
 if [ "$token" = "" ]; then
 echo "Could not find token, run 'git config --global github.token <token>'"
 invalid_credentials=1
 fi

 if [ "$invalid_credentials" == "1" ]; then
 return 1
 fi

 echo -n "Creating Github repository '$repo_name' ..."
 curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}' > /dev/null 2>&1
 echo " done."

 echo -n "Pushing local code to remote ..."
 git remote add origin git@github.com:$username/$repo_name.git > /dev/null 2>&1
 git push -u origin master > /dev/null 2>&1
 echo " done."
}

subl_link=/usr/local/bin/subl
subl_bin=/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl
if [ ! -f "$subl_link" ] && [ -f "$subl_bin" ]; then
    ln -s "$subl_bin" "$subl_link"
fi
alias ll='ls -alF'
alias gogit='cd ~/Documents/github/penguin02007'
alias gst='git status'
alias gdi='git diff'
export PATH=/usr/local/bin:$PATH
# Get aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi
