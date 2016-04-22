Requirement
-----------

- GNU Source-highlight
- grc (Generic Colouriser)
- landscape-sysinfo (for Linux)

Install Requirement
-------------------

- curl

Reference
---------

### iTerm2

- [Use ⌥ ← and ⌥→ to jump forwards / backwards words in iTerm 2, on OS X](https://coderwall.com/p/h6yfda/use-and-to-jump-forwards-backwards-words-in-iterm-2-on-os-x)

### Base16 Support

To make remote machine support base16 colorscheme, setup the configuration following:

In `~/.ssh/config` (local):

```
SendEnv BASE16_SUPPORT
```

In `/etc/ssh/sshd_config` (remote):

```
AcceptEnv BASE16_SUPPORT
```
