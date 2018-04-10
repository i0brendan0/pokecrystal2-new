# Instructions

The game is build using [**rgbds**](https://github.com/rednex/rgbds).
These instructions explain how to set up the tools required to build.

## Linux

```bash
sudo apt-get install make gcc bison git libpng-dev

git clone https://github.com/rednex/rgbds
cd rgbds
sudo make install
cd ..

git clone https://github.com/i0brendan0/pokecrystal2-new
cd pokecrystal2-new
make
```


## Mac

In **Terminal**, run:

```bash
xcode-select --install

git clone https://github.com/rednex/rgbds
cd rgbds
sudo make install
cd ..

git clone https://github.com/i0brendan0/pokecrystal2-new
cd pokecrystal2-new
make
```


## Windows

Download [**Cygwin**](http://cygwin.com/install.html): **setup-x86_64.exe** for 64-bit Windows, **setup-x86.exe** for 32-bit.

Run setup and leave the default settings. At "Select Packages", choose to install the following:

- `make`
- `git`
- `gcc-core`

You may need to search for them as the installer has many packages. The ones you need are exactly as written.

Then download [**rgbds**](https://github.com/rednex/rgbds/releases/): the latest **win64.tar.gz** or **win32.tar.gz** release. Extract it and put all the `exe` and `dll` files individually in **C:\Cygwin64\usr\local\bin**.

**Note: If you have an older rgbds, you will need to update to 0.3.3 or newer.** Ignore this if you have never installed rgbds before.

In the **Cygwin terminal**, enter these commands:

```bash
git clone https://github.com/i0brendan0/pokecrystal2-new
cd pokecrystal2-new
make
```
