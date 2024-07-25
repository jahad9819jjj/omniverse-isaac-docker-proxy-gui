# omniverse-isaac-docker-proxy-gui
This repository summarizes how to run omniverse-launcher and isaac-sim in a docker environment with GUI display.  
It also supports proxy environments, so you can easily run isaac-sim on your company PC.  
*Not tested in a WSL2 environment, so someone please try it.
# Usage
## 1. Setting host PC
1. Grant access privileges to root.  
```
xhost +local:root
```
2. Add to .bashrc.  
```
echo 'xhost +local:root > nul >> ~/.bashrc
```
3. Kill processes.
```
fuser -k 33480/tcp
fuser -k 34080/tcp
```
4. Use the command line to log in to NGC before pulling the Isaac Sim container.
```
docker login nvcr.io
``` 
5. Clone this repository and change directory.
```
git clone https://github.com/kentar0kozai/omniverse-isaac-docker-proxy-gui.git
cd omniverse-isaac-docker-proxy-gui
```
6. Modify line 8 of the Dockerfile to your own proxy and port.
```
e.g.
ENV PROXY=***.***.***.***:**
￬
ENV PROXY=192.0.2.1:8080
```
7. Run docker compose.  
*Download and installation takes a long time.
```
docker compose up
```
8. Success if Container isaac-sim-enhanced Created / Attaching to isaac-sim-enhanced is displayed.　　
  
9. Run the command in another terminal.
```
docker exec -it isaac-sim-enhanced bash
```
## 2. How to execute Omniverse-launcher
1. Run the command the docker terminal.
```
ov-launcher
```
2. Create an NVIDIA account and log in.

3. Select the NUCLEUS tab and register the local server.

4. Click 'Connect to a Server' to connect to the localhost server.
   *Log in with ID: admin, Password: admin if you cannot log in.

5. Select the EXCHANGE tab and install 'Cache'.
6. Install Isaac-Sim.
7. Select the Library tab and run Isaac-Sim.
8. A select tab will appear and you can start with any setting.
9. After loading, try running one of the Isaac Examples.
10. Press “load” on the pop-up tab to load the environment.  
    (The initial loading takes a while, so be patient; from the second time on, the environment is saved in Cache, which is faster.)
11. The isaac-sim directory also contains Python scripts and sample code, allowing you to start the Python tutorial right away.
