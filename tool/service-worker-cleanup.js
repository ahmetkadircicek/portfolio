// Deployed as /flutter_service_worker.js by the predeploy hook in firebase.json.
// Replaces the caching service worker that earlier versions of this site
// installed. Browsers re-check this file on navigation; this version clears
// the old caches, unregisters itself and reloads open tabs onto the live site.
self.addEventListener('install', () => self.skipWaiting());
self.addEventListener('activate', (event) => {
  event.waitUntil((async () => {
    const keys = await caches.keys();
    await Promise.all(keys.filter((key) => key.startsWith('flutter-')).map((key) => caches.delete(key)));
    await self.registration.unregister();
    const clients = await self.clients.matchAll({ type: 'window' });
    clients.forEach((client) => client.navigate(client.url));
  })());
});
