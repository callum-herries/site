build-css-dev:
  postcss resources/css/app-utilities.pcss -o resources/public/css/app-utilities.css
  postcss resources/css/app-components.pcss -o resources/public/css/app-components.css -w --verbose

build-css-prod:
  #!/usr/bin/env bash
  NODE_ENV=production postcss resources/css/app-utilities.pcss -o resources/public/css/app-utilities.css
  NODE_ENV=production postcss resources/css/app-components.pcss -o resources/public/css/app-components.css
  ls -lh resources/public/css

for:
  #!/usr/bin/env bash
  for filename in $(find . -name '*.clj'); do 
    echo $filename
  done

build-html:
  #!/usr/bin/env bash
  bb posts.clj
  bootleg index.clj -o index.html

dev:
  npx onchange -i $(find . -name '*.clj' -o -name '*.md') -- just build-html

build-assets:
  build-css-prod
  build-html

sync:
  browser-sync start --server --files "**/*.html" "**/*.css"

deploy:
  just build-css-prod
  fossil addremove
  fossil ci -m "Built css"
  fossil git export