# Power Monitor
A stupidly simple KDE Plasma 5 widget to view your private and public ip addresses


## Installation
`kpackagetool5 -t Plasma/Applet --install package`
It can sometimes take a little time to load so be patient

## Customization
You can configure the following:
1. Update timer (this will do a query to [trackip](http://trackip.net/pfsense))
2. Display Public IP
3. Display Private IP
4. Make Text bold
5. Font size

### Note
I get the private ip address from `/proc/net/fib_trie` which is not the ideal way to do this.

If I port this to c++ in the future I will change it to a more robust method.

I also only made this because I really couldn't find anything that would display my private ip address

### Acknowledgments
https://github.com/atul-g/plasma-power-monitor
