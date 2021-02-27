# GoogleCloudSimpleNextflow

The Dockerfile is a simple container with a MASH install.

The first line of main.nf is the SRAid that we can process. 
We can use .fromSRA to create the list of gs:// locations and dump to a file.
the FTP locations in the example are not the only locations.
You can limit the Location to 'GCP' to get the gs:// locations.

