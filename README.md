# Sync your Mac automatically to a remote server
## Even if you don't have root access to it


Useful for web development, this is a couple of little background scripts you can start up when you sit down
to do some local work, and want to see the changes reflected immediately on a remote server.

## Install

### Simple instructions (for UW students)

Even this requires a little bit of manual groundwork:

You need to have your UW webservice set up
See this page for details: http://www.washington.edu/itconnect/connect/web-publishing/shared-hosting/activating-shared-web-hosting/

After that, if you have not already,
you first need to log into the vergil server manually to
add the server to your list of allowed fingerprints

```
ssh <your_username>@vergil.u.washington.edu
```
and log in as usual.

**This setup assumes that you have a folder called `files` under ~/public_html (which should have been created for you).**
To set this up, while logged into vergil, run:

```
mkdir -p ~/public_html/files
```

If you want to be able to navigate to LALALA and see a directory structure of the synced folder, run the following:

```
echo "Options +Indexes" >> ~/public_html/files/.htaccess"
```

Then just run `sh setup.sh`. There will be instructions at the end telling you to do the above steps, which you can ignore.


### Slightly more complicated instructions (for anyone else)

You'll need to change the hostname and path in sync.sh:

```
HOST=vergil.u.washington.edu
URL=${user}@${HOST}:/da00/d24/$user/public_html/files/
```

This should be pretty simple -- $HOST should be the base URL of the server you're syncing to, and $URL builds the rest of the path onto that string.

When the setup.sh script prompts you for your UW NetID/password, just substitute that with your server's login credentials. If you want, change the ~/.uwrc filename to something different, but remember to also change it in sync.sh.


## Run

To run automatic syncing, simply copy watch.sh and sync.sh into the directory you wish to keep in sync and run:

```
sh watch.sh &
```
