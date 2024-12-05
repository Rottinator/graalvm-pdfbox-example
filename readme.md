Sample project to demonstrate an issue with graalvm native image, when using pdfbox, that is based on AWT.
On linux this throws an error when trying to load native libraries via JNI.

To build the project run  
`docker build . -t pdfbox-example`

Then run the container with  
`docker run --rm pdfbox-example`

The sample Dockerfile is based on aarch64, but the issue also happens on x64 linux systems. 
To build the same Dockerfile on x64 machines just switch the download url of graalvm in the Dockerfile to
https://download.oracle.com/graalvm/23/archive/graalvm-jdk-23_linux-x64_bin.tar.gz

This should produce the following output:

Read image from scan 15929 size   
Image to embed: width 768,000000, height 200,000000   
Finished creating pdf. Size 16801   


But it will lead in an error

**Fatal error reported via JNI: Could not allocate library name**