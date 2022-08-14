
pkgname=cachyos-fish-config
pkgver=r3.d82caf9
pkgrel=1
pkgdesc="Fish configuration of CachyOS"
arch=(any)
url="https://gitlab.com/cachyos/themes-and-settings/theme/$pkgname"
license=('MIT')
depends=('bat'
	'exa'
	'expac'
	'fish'
	'fish-autopair'
	'fzf'
	'fisher'
	'fish-pure-prompt'
	'nerd-fonts-fantasque-sans-mono'
	'tealdeer'
	'pkgfile')
makedepends=('git')
conflicts=('kwin-scripts-window-colors')
source=("git+$url.git")
sha256sums=('SKIP')
pkgver() {
	cd "$srcdir/$pkgname"
	printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}
package() {
	cd $srcdir/$pkgname
	install -D -m644 config.fish $pkgdir/etc/skel/.config/fish/config.fish
	install -D -m644 conf.d/done.fish $pkgdir/etc/skel/.config/fish/conf.d/done.fish
}

