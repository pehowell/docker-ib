# Headless IB Gateway Docker image

An Arch Linux Docker image running the IB-Controller and TWS AUR packages.

# How To Use

You first need to run IB Gateway on your local desktop to get some additional details. Login with the user you will use later for headless operation, then go into Settings and configure the API as you want.  This includes enabling the API, disabling Read-Only (or leaving it enabled), and configuring the source IPs that should be allowed to connect.  Click OK then exit IB Gateway.  Find the Jts folder created in your home directory (on MacOS, not sure about Windows).  Inside there you will find a special directory that is an obfuscation of your username, possibly starting with 'd'. Make note of that directory name, and copy the ibg.xml out of this directory.

Now, when running this docker image, you will need to do two things.  First, specify the directory name as the USERID environment variable.  For example, ```-e USERID:dhslabcd```.  Next, you will need to specify the location where your specific config is stored and mount it (using --volumes) to /home/ib/config.  For example, ```-v /tmp/config:/home/ib/config```.  This local directory is where you should put ibg.xml from earlier, as well as the ib-controller's config.ini (see their documentation for format).
