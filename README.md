nvimr
=====

Uses [rocks.nvim](https://github.com/nvim-neorocks/rocks.nvim) to configure this all, so that needs installed first.

## LSPs

To install various LSPs:

### gopls

* Install Go
* Ensure Go bin path is in path: `export PATH=$PATH:$(go env GOPATH)/bin`
* Install go-tools: `go install -v golang.org/x/tools/gopls@latest`
* Ensure `gopls` is found: `gopls version`

### Intelephense

* Install NPM (nvm is a good option, ish)
* Install Intelephense: `npm i -g intelephense`
* Ensure `$HOME/intelephense/licence.txt` exists with key


