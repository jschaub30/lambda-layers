# AWS Lambda layers

Part of my previous job was to deploy open-source software, typically installing
these in docker containers or directly onto the source (Redhat) servers.

The process to deploy these in a serverless fashion on AWS Lambda is similar.
Here's my collection of Lambda layers, typically built on x86_64 EC2 Instances.
I've included build scripts if you'd like to modify or build these on other platforms.

- [Poppler utilities, an open source PDF rendering library](poppler/)
- [Tesseract, an open source OCR engine](tesseract/)
- [Leptonica, open source library broadly useful for image processing analysis](leptonica/)
