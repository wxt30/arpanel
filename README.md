# arPanel
arPanel is a mobile friendly web dashboard for Arweave pool mining using Virdpool miner.  
Use this dashboard to control and monitor your miner's status and performance.

# Installation

### Requirements
arPanel is **not** a standalone miner, it is simply a dashboard for Virdpool miner which is available here: [Virdpool Miner](https://github.com/virdpool/miner)  
Follow the instructions to install the [miner](https://github.com/virdpool/miner) first. Then, follow the instructions below to setup arPanel.  
arPanel has been tested and runs on Ubuntu 18.04 and Ubuntu 20.04.

### Setup
IMPORTANT: Open a terminal, elevate priveleges and clone the arPanel repository inside the Virdpool miner directory.
```
sudo su
# cd miner
```
1) Ensure you have moved to the directory where Virdpool miner is installed and do:  
```
git clone https://github.com/wxt30/arpanel.git
cd arpanel
```
2) Edit `mine.sh` using your favorite editor to set your WALLET where pool rewards will be sent. If you don't have one, get your own [Arweave Web Extension Wallet](https://docs.arweave.org/info/wallets/arweave-web-extension-wallet).

3) Optionally you can set your arweave data directory using the `data_dir` option. You need this if you have previously synced. And finally, do some performance tuning for better mining hashrate speeds. See the notes in `mine.sh` for tuning details.

### Start & Stop arPanel
Start arPanel with: `./arpanel-start.sh`  

Open a web browser to see your dashboard: `http://your-rigs-ip:3030`  
You can also open/forward port `3030` and use your public ip: `http://your-public-ip:3030`  
If needed, the port number can be changed in `./arpanel-start.sh`  

Stop arPanel with: `./arpanel-stop.sh`

### Update arPanel
NOTE: Backup `mine.sh` first so you don't lose your miner settings.  

Stop your miner using arPanel.
Move to the arPanel installation directory and do:
```
./arpanel-stop.sh
git pull
```
Edit `mine.sh` to set your mining WALLET and startup options.  
Edit `arpanel-start.sh` to set your custom port, if needed.  

Start arPanel.
```
./arpanel-start.sh
```
Start your miner using arPanel.

### FAQ
Q: Is arPanel free to use?  
A: Yes, it is totally free.  

Q: Is arPanel an Arweave miner?  
A: No, arPanel is a dashboard for Virdpool miner, it is not a miner.  

Q: Why are there ads in arPanel?  
A: arPanel is free to use therefore ads helps us with development and support.

# License
Copyright (c) 2021 arPanel

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
