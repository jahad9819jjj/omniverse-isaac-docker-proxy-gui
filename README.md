# omniverse-isaac-docker-proxy-gui
This repository summarizes how to run omniverse-launcher and isaac-sim in a docker environment with GUI display.  
It also supports proxy environments, so you can easily run isaac-sim on your company PC.  
*Not tested in a WSL2 environment, so someone please try it.
# Usage
## 1. Setting host PC
Grant access privileges to root  
```
xhost +local:root
```
Add to .bashrc  
```
echo 'xhost +local:root > /dev/null 2>&1' >> ~/.bashrc
```
Kill processes
```
fuser -k 33480/tcp
fuser -k 34080/tcp
```
Clone this repository and change directory
```
git clone 
```
