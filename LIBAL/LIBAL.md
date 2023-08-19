--------
# Directories and Files

- LIBAL/
	- Anlogic TD IDE cell library
		- al/
		- ef2/
		- ef3/
		- eg/
		- elf/
	- LIBAL.md
		- This article.

## Anlogic TD IDE cell library

### Copy:
 Copy all the files under "sim/" in the TD IDE installation directory to "LIBAL/" by yourself.

- \<InstallDir\>/Anlogic/TD4.6.4/sim/  ==copy=>  LIBAL/
	- al/
	- ef2/
	- ef3/
	- eq/
	- elf/

 For details in Japanese, please see the following URL.

- http://hello.world.coocan.jp/ARDUINO15/arduino15_8.html#SIMCT

### Modify:
 Comment out "`resetall" directive at the beginning of following files.

- LIBAL/al/al_map_addr.v
- LIBAL/al/al_map_mux4.v

--------
