<div align="center">

# volfade
### Change *volume* levels with smooth *fade* transitions

</div>

##

<div align="justify">
	
If you're like me, you surely like to hear music while working or maybe you're attending a videocall. Sometimes we need to attend someone requiring our attention and we toggle the mute button; or maybe you're back to work and get a bump surprise when you unmute the volume and only then remember that you left it at a high level. `volfade.sh` makes stepped increase/decrease volume operations in a `PulseAudio` server, making the volume changes to sound with a really smooth *crescendo* or *diminuendo* fade feeling. `volfade.sh` is a bash script wrapper around `pulsectl` and `pamixer` utilities.

</div>

## How to get

To download volfade.sh clone this repository:
```sh
$ git clone https://github.com/macydnah/volfade.sh
```

Change working directory to the source tree and give execute permissions to the script:
```sh
$ cd volfade.sh
$ chmod u+x ./volfade.sh
```

Execute it with:
```sh
$ ./volfade.sh
```

## How to use
```
Usage: ./volfade.sh <operation>

Change volume levels with smooth fade transitions.

Operations:
	-d	decrease volume in diminuendo
	-i	increase volume in crescendo
	-m	al niente/dal niente
		(fade out and mute/unmute and fade in)
Options:
	-h	show this help and exit

Operations are mutually exclusive, e.g. the volume levels
can't be increased and decreased at the same time
```

## Dependencies
`volfade.sh` is a bash script wrapper around `pulsectl` and `pamixer` utilities so make sure those are installed in your system.

## Contributing

Please feel free to make a pull request if you have an idea, or open an issue if you're facing problems. Any contribution will be appreciated 🥳🤙!

## License
volfade.sh is licensed under the terms of the [GNU General Public License v3.0](LICENSE)
