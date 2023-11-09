# cacheIT !
Hide your apps in a cache to prevent deleting

## How do this works ?
It simply copy over all your files and folders (even hidden ones) contained in the Printers folder to a cached folder every second.
It watches for modifications in your Printers folder every second. If something is added, it puts it in the cache. If something is deleted, put it back in Printers from the cache.
If an app is updated in Printers, update app in cache.

## Power and performance consumption
Really really low. The first time it runs it could take some time depending on your apps size but it shouldn't slow down your computer at all.

## Fake apps (fixed in v0.3)
If you see those zero kb apps that is an error. simply ignore it or delete it from cache and from printers folder.
<img width="625" alt="image" src="https://github.com/c22dev/cacheIT/assets/102235607/3682533d-319a-4e11-885e-9d7f097d2d90">

## The big disadvantage
- If you want to delete an app manually you have to delete it both in the cache and in the Printers folder in less than a second (you gotta be fast)


Some real printers app might not be recovered if deleted.

Some app bundle's parts might not be copied.
