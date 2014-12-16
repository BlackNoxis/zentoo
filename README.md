# Argent Linux

Argent Linux is a variant of [Gentoo Linux](http://www.gentoo.org) with an
emphasis on server deployment on x86_64 platforms.

Just like Gentoo Linux it is a source based Linux distribution with a live
package tree. Argent Linux is at the same time more conservative and more
bleeding-edge. Package updates tend to happen in batches that are known to work
and are supported by [ZenOps Chef](https://github.com/zenops/chef). Still
package versions tend to be more up-to-date and new server-related packages
have been added to the tree.

Argent uses [systemd](http://www.freedesktop.org/wiki/Software/systemd/)
exclusively. OpenRC is still installed for various helper scripts though. As
soon as Gentoo has fixed [Bug
373219](https://bugs.gentoo.org/show_bug.cgi?id=373219) we will remove OpenRC
support completely.

Argent also provides a binary kernel image (`sys-kernel/argent-image`) with
VirtualBox modules, a Dracut initramfs and a `pkg_config` action that detects
and installs a boot loader, fstab and everything else that is neccesary to
boot.

## Usage

Argent provides stages and images that can be used in the same way as Gentoo.
You can simply follow the [Gentoo Handbook](http://www.gentoo.org/doc/en/handbook/handbook-amd64.xml)
or you can use tools like [Quickstart](https://github.com/argent/quickstart) to
bootstrap your servers.

Download Argent stages and images from the [ZenOps
mirror](http://mirror.zenops.net/argent). This mirror also contains the portage
rsync module and distfiles:

* `SYNC="rsync://mirror.zenops.net/argent-portage"`
* `GENTOO_MIRRORS="http://mirror.zenops.net/argent"`

## Contributing

To start contributing to Argent you need to clone the repository including
submodules:

```
git clone --recursive https://github.com/argent/argent
```

The repository contains various helper scripts in the `scripts` folder which
are described below.

Consult the [Gentoo Development Guide](http://devmanual.gentoo.org/) on how to
create and maintain ebuilds.

### Keywording Policy

Argent does not have a distinction between stable and unstable packages. All
packages in the tree are always installable (stable).

### Dependency Tree

Argent tries very hard to stay lean and fast. After all, most packages in the
Gentoo repository are not needed on servers. At the time of writing this the
Argent repository contained only about 7% (1236) of Gentoos packages. As a
result dependency calculation is very fast in Argent.

To prevent unnecessary dependencies in the tree we extensively use the
following profile files:

* `profiles/releases/argent/package.use.mask`
  to mask USE flags on a per-package basis
* `profiles/releases/argent/use.mask`
  to mask USE flags globally

### Testing

We use Jenkins Continuous Integration to verify every change that is made to
the repository. A push will trigger the following tests:

* `./scripts/scantree full`
* `./scripts/generate-cache`
* update all distfiles
* a full build of Argent stages and images using
  [metro](https://github.com/argent/metro) and
  [packer](https://github.com/zenops/packer-templates)

### Using Gentoo ebuilds

In case you want to copy ebuilds from Gentoo, you need to get a local copy of
the Gentoo repository using `sync-gentoo-cache`:

```
./scripts/sync-gentoo-cache
```

The cache is now located at `cache/gentoo-portage`.

Copying ebuilds manually is a very tedious task but also not trivial to
automate. Over the years we have developed a hybrid approach to keeping
upstream ebuilds in sync. The main entry point is `eupdate` located in the
scripts folder.

Using `eupdate` takes care of following issues automatically:

* parsing package versions
* blacklisting and version expansion
* copying patches, init scripts, etc
* copying used eclasses
* CVS header cleanup
* keywording
* manifest generation

In it's simplest form you invoke `eupdate` with a basic package atom:

```
./scripts/eupdate app-editors/vim
```

### Version Expansion

In case you want to stick to a specific package version you can specify an advanced atom to `eupdate`:

```
./scripts/eupdate =app-editors/vim-7.4.52
```

Expansions can be made permanent by adding them to
`profiles/releases/argent/eupdate.exand.sh`. If you passed a specific version
to `eupdate` it will print the entry you need to add to `eupdate.expand.sh`.

### Blacklisting

In a few cases Argent does things differently than Gentoo and packages cannot
be copied from the Gentoo repository. To prevent accidental clobbering all
packages that should not be touched by `eupdate` are added to
`profiles/release/argent/eupdate.blacklist`.
