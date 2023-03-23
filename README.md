# Forgit, a git abstraction in Neovim
The meaning of this plugin was to satisfy my desire to use git as quick as possible inside the editor. It basically helps me to write atomic commits (commits that only describes one task) and avoid losing all my time trying to debug something that was working but now it is not.

![image](https://user-images.githubusercontent.com/67799433/227077395-d3c545e8-c795-4280-9ac6-61e6af0391fc.png)
![image](https://user-images.githubusercontent.com/67799433/227077428-082894fc-8dd2-4bab-9264-09ac0aa96539.png)

## Installation Guide
First things first, this plugin does os.execute() calls with the git command, so make sure to have git installed. If you don't have it installed, you can use your favorite package manager to install it:

#### Arch-based distributions
```bash
$ sudo pacman -S git
```
### Debian-based distributions
```bash
$ sudo apt-get install git
```
If you use Windows, rethink about your life choices.
Just kidding, go to the git website, install the binary and make sure to put git in the path.

To install forgit.nvim with packer.nvim you can use
```lua
use { 
	'lucasmelodev1/forgit.nvim',
	requires = { 'MunifTanjim/nui.nvim' }
}
```
If you use other plugin managers, you can do the same, but you will need to install both plugins separatedly.
If you don't use a plugin manager... I really recommend you to.

## Usage
For now, there is only 2 command that you can use:
- ```:ForgitAdd``` opens the _git add_ interface from which you can select all the files you want to add and press -- CONFIRM -- to add all of them. It is a simple ```git add {file}```.

- ```:ForgitCommit``` opens the _git commit_ interface fro which you can type your commit message. From there you can also see which files are going to be added so no mistakes here. The underlying command is just ```git commit -m "{message}"```

To set keybinds in lua you can put this code in a remap.lua file inside your nvim/lua folder or wherever you want it.
```lua
vim.keymap.set("n", "<leader>ga", "<cmd>ForgitAdd<cr>")
vim.keymap.set("n", "<leader>gc", "<cmd>ForgitCommit<cr>")
```
## The future os this plugin
I plan on expanding this plugin as I become more and more productive in Neovim. You can see that currently the plugin don't even have tests, but I plan on adding them as I become better in lua and plugin creation.

I would LOVE if you _star_ this repository since I am new on this thing and seeing that people are liking what I do is pretty important to me. Thanks to tj and ThePrimeagen for helping my out with this, you guys are awesome.
