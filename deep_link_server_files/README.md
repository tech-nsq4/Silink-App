Upload both files under `https://silink-api.nasaq4.com/.well-known/`:

- `/.well-known/assetlinks.json`
- `/.well-known/apple-app-site-association` (no extension)

Both must be served over HTTPS with status 200, no redirects, and
`Content-Type: application/json`.

`assetlinks.json` currently holds the debug keystore SHA-256. Replace the
second entry with the release / Play App Signing SHA-256.
