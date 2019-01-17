# Just put on $HOME and execute.
#Restores git files from linked repositorie and backups up pre existing files in folder 'dot-files-backup'

mkdir -p .dots-repo
git clone --bare https://github.com/vdufloth/dots-repo.git $HOME/.dots-repo
function dots-git {
   /usr/bin/git --git-dir=$HOME/.dots-repo/ --work-tree=$HOME $@
}
mkdir -p .dot-files-backup
dots-git checkout
if [ $? = 0 ]; then
  echo "Checked out.";
  else
    echo "Backing up pre-existing dot files.";
    dots-git checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dot-files-backup/{}
fi;
dots-git checkout
dots-git config status.showUntrackedFiles no

# original source: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
