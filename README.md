# Headless TWS Docker image

An Arch Linux Docker image running the IB-Controller and TWS AUR packages.

# How To Use

You first need to run TWS on your local desktop.  Once logged in under paper or live (whichever mode you will use headless), go to settings.  There, enable the API, disable read-only mode, set the port (4001 by default in this docker container), and uncheck localhost only.  Add the IP(s) of clients that will connect.  Note, this can be IPs of other docker containers.  Make sure to save the settings to the server and exit.

Now, when running this docker image, you will need to specify the location where your specific config is stored and mount it (using --volumes) to /home/ib/config.  For example, ```-v /tmp/config:/home/ib/config```.  This local directory is where you should put the ib-controller's config.ini (see their documentation for format).
