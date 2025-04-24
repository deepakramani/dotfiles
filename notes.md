# Notes
## ZSH and related

```shell
brew install zsh # only in linux sub-systems. Mac comes with ZSH installed.
```

To use zsh ability to use plugins to bring in features and also be aware of performance,
**antidote**, a framework is used to install plugins. 

```shell
brew install antidote
```
All plugins necessary go inside a text file and that file is bundled to a shell script. 
To install the `.zsh_plugins.txt`(use `stow zsh` to get in the right directory),

```bash
echo -n 'source /path/to/antidote.zsh' >> ~/.zshrc
echo -n 'antidote load' >> ~/.zshrc #loads whenever `zsh_plugins.txt` changes.
```

To update antidote, use `antidote update`.

##homebrew
To know the dependencies of an installed package 
```
brew deps --tree --installed <packagename> # eg. brew deps --tree --installed ruby
```
## Neovim

**Important**: Neovim version must be greater than 0.6.0 for most plugins to work. Latest
development version is preferred. 

In Mac, neovim is installed via homebrew. [Link](https://github.com/neovim/neovim/wiki/Installing-Neovim#homebrew-on-macos-or-linux).

### Stable Version

```bash
brew install neovim
```

### Development version

```bash
brew install --HEAD luajit neovim

To update dev version,
brew reinstall neovim
or
brew upgrade neovim
```

For Ubuntu, use this [link](https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu).
```bash
sudo apt remove neovim
sudo apt autoclean && sudo apt autoremove  # unistall older version of neovim and remove dependencies
```
**Note**: Removes also xclip, neovim-runtime along with it. 

### fzf, ripgrep, xclip,neovim 
```bash
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim fzf ripgrep xclip
```
### tree-sitter
```bash
brew install tree-sitter # Mac
```
**Ubuntu**
Download the latest from [here](https://github.com/tree-sitter/tree-sitter/releases) and
place the executable(make it as one) inside `~/.local/bin/`.

### [vim-plug](https://github.com/junegunn/vim-plug)

To install

```shell
sh -c curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
Auto install check
```bash
if empty(glob('$HOME/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
```
### Dependent packages for nvim
Plugin/packages/language servers such as `pyright`, `ripgrep`, `fd`, `texlab` are installed using `brew install ...`

### Troubleshooting

Mar 1, 2022 - `telescope-fzf-native.nvim` is throwing error at fresh install. Possibly due to `make` not compiling. 
Goto the installed dir path and execute `make` or reinstall fzf-native. 

## GNU Stow

GNU Stow is installed through homebrew `brew install stow`. To update formula in Mac, run `brew update` first.

`sudo apt install stow` for Ubuntu. 

Helpful resource - https://www.jakewiesler.com/blog/managing-dotfiles

Stow ignore - https://unix.stackexchange.com/questions/121910/gnu-stow-how-to-stow-only-selected-files-folders

## Tree command for directory tree
A pretty awesome tool to display a directory's tree structure. See [here](https://github.com/Old-Man-Programmer/tree)  


```bash
brew install tree #for mac
sudo apt install tree #for ubuntu
```
## Kitty Terminal

### Themes
Easiest way to preview and download themes is `kitty +kitten themes`.


## VS CODE 
**Install**
`brew install --cask visual-studio-code`

**Uninstall**
use this link to uninstall the app in vs code -- https://stackoverflow.com/a/42603699, https://stackoverflow.com/a/53839847

`brew uninstall visual-studio-code`
### list extensions
`code --list-extensions`

`code --list-extensions >> ~/extension.txt`


## Conda

### Install Conda

**Miniconda3** [https://docs.conda.io/en/latest/miniconda.html](https://docs.conda.io/en/latest/miniconda.html)
Also [the archive](https://repo.anaconda.com/miniconda/). Look for Miniconda3-latest.

```shell
wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```

```shell
wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh
bash Miniconda3-latest-MacOSX-arm64.sh
```

**Miniforge3** [https://github.com/conda-forge/miniforge#miniforge3](https://github.com/conda-forge/miniforge#miniforge3)

```shell
wget -q https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
bash Miniforge3-Linux-x86_64.sh
```
or 

```shell
wget -q https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh
bash Miniforge3-MacOSX-arm64.sh
```

**Install Mamba package manager**

`conda install -n base mamba -c conda-forge` or `conda install -n base mamba -c fastchan`

After installing Mamba, every command starting with `conda` can be replaced with `mamba`.

### Create an environment

`conda create -n <env-name>`

`conda env create -n ENVNAME --file ENV.yml` # import with an environment.yml file 

`conda create --name myclone --clone myenv` # Clone an existing environment 

`conda list --explicit > spec-file.txt` # Save installed packages for later use in same OS.

`conda create --name myenv --file spec-file.txt` # Import env from a file.txt

`conda install --name myenv --file spec-file.txt` # install packages in an existing env.

### Delete an environment

`conda info --envs`  or `conda env list` # check environments available

`conda env remove -n <env-name>` # To delete

### Sharing an environment

1. Activate the environment that is to be shared.

2. `conda env export ENVNAME>ENV.yml` export to a `yml` file.

### Update packages

`conda update -n <env-name> <package name> -c <channel-name>` # updates only mentioned package

or 

`conda update -n <env-name> --all -c <channel-name>` # updates all installed packages

### Clear cache

`conda clean --all` # Remove index cache, lock files, unused cache packages, and tarballs.

## Cheatsheet

https://docs.conda.io/projects/conda/en/latest/_downloads/843d9e0198f2a193a3484886fa28163c/conda-cheatsheet.pdf

## Terraform install 

**Ubuntu** 

```
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

**Mac** with Homebrew

```
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

## Latex Installation

2025 update(takes 1-2hours totally. Use profile to save time)

(For quick install using the texlive.profile file. `./install-tl -profile texlive.profile`)

- Before upgrading to 2025 version, check previous version present inside home directory `~/texlive/{year}`
- Instructions for upgrade are given here - https://www.tug.org/texlive/upgrade.html (upgrade seems little technical. Didn’t proceed.)
- Instructions for fresh install are given here - https://www.tug.org/texlive/quickinstall.html (perl install-tl -gui). Version 74223.
- Goto this link — https://www.tug.org/texlive/acquire-netinstall.html, download unx-tar.gz file(ca. 5 mb).
- change install folder prefix to home directory to avoid permissions.
- change installation root to `/Users/dross/texlive/2025`(Choose prefix `/Users/dross/`, leave rest as it is and click OK). Go back again to see that the path is correct.(will create `2025` on its own). Will show some 9GB big files to install. No need for those.
- Click `advanced`.  (use the installation save profile option to use for next upgrade).
    - Leave `texmf-local` localtion as it is. It is for custom local files not to be overwritten by Tex live upgrade. 
    - In ‘platforms’, make sure only mac is selected. 
    - ‘Selections’ is the most important.
        - Need to change ‘Schema’ to only needed packages. Click ‘Change’, choose ‘custom schema’.
        - In ’N.of Collections’, click ‘customise’. Select ‘None’ in languages and select only English.
            - In ‘other collections’ - select ‘None’ and choose only needed. (I saved texlive.profile). Use that for later.
            - In short, languages- English and German, all latex, luatex, xetex, basic fonts and packages. about 725MB.
    - In Options, deselect everything. No need for docs or source tree. Use google or LLM. Also no need for symlinks. Put PATH, MANPATH and INFOPATH in `.zshenv`.
- Save profile or click install. I think source as CTAN is automatically selected. Install takes around 20 mins to complete depending on the server. 


export PATH=/usr/dross/texlive/2025/bin/universal-darwin:$PATH
export MANPATH=/usr/dross/texlive/2025/texmf-dist/doc/man:$MANPATH
export INFOPATH=usr/dross/texlive/2025/texmf-dist/doc/info:$INFOPATH
