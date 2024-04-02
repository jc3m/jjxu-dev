#!/bin/bash

cd "$(dirname "$0")"
cd ../ui

npm run build
aws s3 cp build s3://www.jjxu.dev --recursive

aws cloudfront create-invalidation --distribution-id E3IIFWUWLF81BZ --paths '/*'
