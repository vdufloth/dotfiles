# Just put on $HOME and execute.
# Restores git files from linked repositorie and backs up pre existing files to created folder 'dot-files-backup'

mkdir -p .dotfiles-git
git clone --bare https://github.com/vdufloth/dotfiles.git $HOME/.dotfiles-git
function dots-git {
   /usr/bin/git --git-dir=$HOME/.dots-repo/ --work-tree=$HOME $@
}
mkdir -p .dotfiles-backup
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
