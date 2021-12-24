'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "favicon.ico": "13d8929ecf9188548cbdf5b8bf71ca34",
"canvaskit/canvaskit.js": "62b9906717d7215a6ff4cc24efbd1b5c",
"canvaskit/profiling/canvaskit.js": "3783918f48ef691e230156c251169480",
"canvaskit/profiling/canvaskit.wasm": "6d1b0fc1ec88c3110db88caa3393c580",
"canvaskit/canvaskit.wasm": "b179ba02b7a9f61ebc108f82c5a1ecdb",
"main.dart.js": "5565eb12b57c8f83ffc1f001a29d55af",
"version.json": "b5e1a139ffb14fcc3703c0813e39035a",
"splash/img/light-4x.png": "7cdb951278aec65d9ca533e4544c1e13",
"splash/img/dark-3x.png": "3d691a8c1a349ee34a7aed38df126013",
"splash/img/dark-2x.png": "57dad9faf1932f09220e5719a29771f7",
"splash/img/light-3x.png": "3d691a8c1a349ee34a7aed38df126013",
"splash/img/dark-1x.png": "585b0a6372e4a7f82722b29f99f6ba32",
"splash/img/light-1x.png": "585b0a6372e4a7f82722b29f99f6ba32",
"splash/img/dark-4x.png": "7cdb951278aec65d9ca533e4544c1e13",
"splash/img/light-2x.png": "57dad9faf1932f09220e5719a29771f7",
"splash/style.css": "64227ec06c71fef909f75868ada72c30",
"manifest.json": "f7d72189c022f3ca914c263689015584",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"assets/content/reviews/001_l1.json": "a2def6a214a58fd919a63807ec55d8c7",
"assets/content/reviews/009_l5.json": "d600d5d8e00bc6c04893c7cb38d046fa",
"assets/content/reviews/002_l1.json": "095984f0e5f5a768cbe6863f6965c104",
"assets/content/reviews/003_l2.json": "d5e8b1ab69ad48a0e1568ac8a26d3457",
"assets/content/reviews/004_l2.json": "4310f7d3e09546db490683a785c77e52",
"assets/content/reviews/005_l3.json": "06784462680075143dca240299d9b15a",
"assets/content/reviews/010_l5.json": "d519febcde22b1a45cbf73635a1dc9ca",
"assets/content/reviews/008_l4.json": "876e56e6136e98d6f5ead8dcf4c75f88",
"assets/content/reviews/007_l4.json": "042d0ce27467b63a35bae603265f0202",
"assets/content/reviews/006_l3.json": "bfb968e85d4a75af5a7d9217efd4c0ec",
"assets/content/lessons/002__%25D0%25A2%25D0%25B5%25D1%2585%25D0%25BD%25D0%25B8%25D1%2587%25D0%25B5%25D1%2581%25D0%25BA%25D0%25B8%25D0%25B5_%25D1%2581%25D1%2580%25D0%25B5%25D0%25B4%25D1%2581%25D1%2582%25D0%25B2%25D0%25B0_%25D0%25B7%25D0%25B0%25D1%2589%25D0%25B8%25D1%2582%25D1%258B_%25D0%25B8%25D0%25BD%25D1%2584%25D0%25BE%25D1%2580%25D0%25BC%25D0%25B0%25D1%2586%25D0%25B8%25D0%25B8.png": "a124c8e5b032e3d27891f8628dba312f",
"assets/content/lessons/002__%25D0%25A2%25D0%25B5%25D1%2585%25D0%25BD%25D0%25B8%25D1%2587%25D0%25B5%25D1%2581%25D0%25BA%25D0%25B8%25D0%25B5_%25D1%2581%25D1%2580%25D0%25B5%25D0%25B4%25D1%2581%25D1%2582%25D0%25B2%25D0%25B0_%25D0%25B7%25D0%25B0%25D1%2589%25D0%25B8%25D1%2582%25D1%258B_%25D0%25B8%25D0%25BD%25D1%2584%25D0%25BE%25D1%2580%25D0%25BC%25D0%25B0%25D1%2586%25D0%25B8%25D0%25B8.md": "c9a5141ce8556ce93fed07f1fc0c57ff",
"assets/content/lessons/003__%25D0%259F%25D0%25B5%25D1%2580%25D1%2581%25D0%25BE%25D0%25BD%25D0%25B0%25D0%25BB%25D1%258C%25D0%25BD%25D1%258B%25D0%25B5_%25D0%25B4%25D0%25B0%25D0%25BD%25D0%25BD%25D1%258B%25D0%25B5_%25D0%25B8_%25D0%25B0%25D0%25BD%25D0%25BE%25D0%25BD%25D0%25B8%25D0%25BC%25D0%25BD%25D0%25BE%25D1%2581%25D1%2582%25D1%258C.md": "3b63ab244776a6035585bc5f62a5b317",
"assets/content/lessons/004_p__%25D0%2591%25D0%25B5%25D0%25B7%25D0%25BE%25D0%25BF%25D0%25B0%25D1%2581%25D0%25BD%25D1%258B%25D0%25B5_%25D0%25BF%25D0%25BE%25D0%25BA%25D1%2583%25D0%25BF%25D0%25BA%25D0%25B8.md": "4ee13f3a8b8fd323dc18e1bb3639345e",
"assets/content/lessons/001__%25D0%2592%25D0%25B8%25D0%25B4%25D1%258B_%25D0%25BC%25D0%25BE%25D1%2588%25D0%25B5%25D0%25BD%25D0%25BD%25D0%25B8%25D1%2587%25D0%25B5%25D1%2581%25D1%2582%25D0%25B2%25D0%25B0_%25D0%25B2_%25D0%25B8%25D0%25BD%25D1%2582%25D0%25B5%25D1%2580%25D0%25BD%25D0%25B5%25D1%2582.md": "f2fa707f39c5baaa6585d64ee66aedf1",
"assets/content/lessons/001__%25D0%2592%25D0%25B8%25D0%25B4%25D1%258B_%25D0%25BC%25D0%25BE%25D1%2588%25D0%25B5%25D0%25BD%25D0%25BD%25D0%25B8%25D1%2587%25D0%25B5%25D1%2581%25D1%2582%25D0%25B2%25D0%25B0_%25D0%25B2_%25D0%25B8%25D0%25BD%25D1%2582%25D0%25B5%25D1%2580%25D0%25BD%25D0%25B5%25D1%2582.png": "4f21097cccf73a6ce3162e020148ee6d",
"assets/content/lessons/004_p__%25D0%2591%25D0%25B5%25D0%25B7%25D0%25BE%25D0%25BF%25D0%25B0%25D1%2581%25D0%25BD%25D1%258B%25D0%25B5_%25D0%25BF%25D0%25BE%25D0%25BA%25D1%2583%25D0%25BF%25D0%25BA%25D0%25B8.png": "2a9b3c03a065acc3f00a796b1247ab78",
"assets/content/lessons/003__%25D0%259F%25D0%25B5%25D1%2580%25D1%2581%25D0%25BE%25D0%25BD%25D0%25B0%25D0%25BB%25D1%258C%25D0%25BD%25D1%258B%25D0%25B5_%25D0%25B4%25D0%25B0%25D0%25BD%25D0%25BD%25D1%258B%25D0%25B5_%25D0%25B8_%25D0%25B0%25D0%25BD%25D0%25BE%25D0%25BD%25D0%25B8%25D0%25BC%25D0%25BD%25D0%25BE%25D1%2581%25D1%2582%25D1%258C.png": "6a4f9366bd51c2b5d5126d43c64f6b42",
"assets/content/lessons/005_p__%25D0%25AD%25D0%25BB%25D0%25B5%25D0%25BA%25D1%2582%25D1%2580%25D0%25BE%25D0%25BD%25D0%25BD%25D1%258B%25D0%25B5_%25D0%25B3%25D0%25BE%25D1%2581%25D1%2583%25D0%25B4%25D0%25B0%25D1%2580%25D1%2581%25D1%2582%25D0%25B2%25D0%25B5%25D0%25BD%25D0%25BD%25D1%258B%25D0%25B5_%25D1%2583%25D1%2581%25D0%25BB%25D1%2583%25D0%25B3%25D0%25B8.md": "f396f72edf44d511f24ac8739bb3472d",
"assets/content/lessons/005_p__%25D0%25AD%25D0%25BB%25D0%25B5%25D0%25BA%25D1%2582%25D1%2580%25D0%25BE%25D0%25BD%25D0%25BD%25D1%258B%25D0%25B5_%25D0%25B3%25D0%25BE%25D1%2581%25D1%2583%25D0%25B4%25D0%25B0%25D1%2580%25D1%2581%25D1%2582%25D0%25B2%25D0%25B5%25D0%25BD%25D0%25BD%25D1%258B%25D0%25B5_%25D1%2583%25D1%2581%25D0%25BB%25D1%2583%25D0%25B3%25D0%25B8.png": "40d6e55e918ffba6d2760b8109e3f44c",
"assets/NOTICES": "c62e51f1126f49f35ce027509bd9e4e2",
"assets/AssetManifest.json": "b3224b4a809dea5e668290886b70c2e1",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"index.html": "e3b9c82326c83e4c5a3a0a03b57dd4b7",
"/": "e3b9c82326c83e4c5a3a0a03b57dd4b7",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"CNAME": "6658c2a126b8a2f980638fbc7eeb0e85"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
