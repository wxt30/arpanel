# arPanel
arPanel is a mobile friendly web dashboard for Arweave pool mining using virdpool's miner.  
Use this dashboard to control and monitor your miner's status and performance.

# Installation

### Requirements
arPanel is **not** a standalone miner, it is simply a dashboard for Vird's miner which is available here: [Virdpool Miner](https://github.com/virdpool/miner)  
Follow the instructions to install the [miner](https://github.com/virdpool/miner) first. Then, follow the instructions below to setup arPanel.  
arPanel has been tested on Ubuntu 18.04 and Ubuntu 20.x

### Setup
IMPORTANT: Clone the arPanel repository inside your miner's directory.  
1) Move to the directory where virdpool miner is installed and do:  
```
git clone https://github.com/wxt30/arpanel.git
cd arpanel
```
2) Edit `mine.sh` using your favorite editor to set your WALLET where pool rewards will be sent. If you don't have one, get your own [Arweave Web Extension Wallet](https://docs.arweave.org/info/wallets/arweave-web-extension-wallet).

3) Optionally you can set your arweave data directory using the `data_dir` option. You need this if you have previously synced. And finally, do some performance tuning for better mining hashrate speeds. See the notes in `mine.sh` for tuning details.

### Start & Stop arPanel
Start arPanel with: `./arpanel-start.sh` or `sudo ./arpanel-start.sh` if you see startup errors in `arpanel/logs/arweave.log`  

Open a web browser to see your dashboard: `http://your-rigs-ip:3030`  
You can also open/forward port `3030` and use your public ip: `http://your-public-ip:3030`  
You can change the port number in `./arpanel-start.sh`  

Stop arPanel with: `./arpanel-stop.sh` or `sudo ./arpanel-stop.sh`

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
A: No, arPanel is a dashboard for vird's pool miner, it is not a miner.  

Q: Why are there ads in arPanel?  
A: arPanel is free to use therefore ads helps us with development and support.

# License
Copyright (c) 2021 arPanel

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
