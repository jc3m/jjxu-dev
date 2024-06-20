#!/bin/bash

cd "$(dirname "$0")"
cd ..

aws s3 cp nw s3://nwchi.jjxu.dev --recursive

aws cloudfront create-invalidation --distribution-id E1785FPXZ6H2QS --paths '/*'
