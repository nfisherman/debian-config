# debian-config
my debian stuff

## Dependencies
``curl git wget``

## Installing
```sh
sh -c "$(wget -O- https://raw.githubusercontent.com/nfisherman/debian-config/main/tools/pull-latest.sh)"

# append "--no-install" to pull script without automatic installatin
sh -c "$(wget -O- https://raw.githubusercontent.com/nfisherman/debian-config/main/tools/pull-latest.sh) --no-install"
```


## Uninstalling
```sh
sh uninstall.sh

# skip uninstall confirmation
sh uninstall.sh -y
```

---

my swag too tuff