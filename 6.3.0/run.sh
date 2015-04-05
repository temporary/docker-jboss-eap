mkdir jfr
chmod o+w jfr
docker run -p 9990:9990 -p 9999:9999 -p 8080:8080 -p 8787:8787 -v $(pwd)/jfr:/tmp/jboss/jfr -it --rm temporary/jboss-eap:6.3.0
