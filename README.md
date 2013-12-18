dotfiles
========
Bootstrap a home directory. Clone into wherever you like and run setup.sh.
Says it's dotfiles, but there's things here that aren't really dotfiles.
Probably better to call it 'homedir' but then that's not what I called it.

external setup
==============
Relatively minimal at this point, but make sure to grab:

* https://github.com/Lokaltog/powerline-fonts/tree/master/SourceCodePro

This will make vim look a lot prettier with airline and so forth.

post-setup
==========
* pop into vim and run :BundleInstall
* configure ssh keys/authorized keys & keychain

things to install on an ubuntu box 
==================================
* git duplicity zsh python-paramiko subversion python-pygments
