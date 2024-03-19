
pkgname=cachyos-fish-config
pkgver=6
pkgrel=2
pkgdesc="Fish configuration of CachyOS"
arch=(any)
url="https://github.com/CachyOS/$pkgname"
license=('MIT')
depends=('bat'
	'exa'
	'expac'
	'fish'
	'fish-autopair'
	'fzf'
	'fisher'
	'fish-pure-prompt'
	'ttf-fantasque-nerd'
	'tealdeer'
	'pkgfile')
makedepends=('git')
conflicts=('kwin-scripts-window-colors')
source=("git+$url.git")
sha256sums=('SKIP')

package() {
	cd $srcdir/$pkgname
	install -D -m644 config.fish $pkgdir/etc/skel/.config/fish/config.fish
	install -D -m644 conf.d/done.fish $pkgdir/etc/skel/.config/fish/conf.d/done.fish
}

