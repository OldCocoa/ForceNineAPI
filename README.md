# ForceNineAPI
Forces legacy Discord clients to use /v9 instead of /v6.
# What versions does it support?
- [x] Discord 2.3.10 (Last iOS 9.x version) (Using DiscOld and manifest.json patch)
# How do I patch manifest.json?
You will need to grab manijest.json from `/var/mobile/Containers/Data/Application/(Discord UUID)/Documents/RCTAsyncLocalStorage_V1/` and add token and email_cache properties to the end of the JSON file, like in this JSON example.

```
{...\"device_vendor_id\":\"...\"}","token":"...","email_cache":"..."}
```
Replace token and email_cache with your Discord token and Discord e-mail address.

Put the file back, make sure to have DiscOld installed, and use Discord as normal!
