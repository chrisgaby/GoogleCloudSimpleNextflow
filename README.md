# GoogleCloudSimpleNextflow

The Dockerfile here has some tools we need but but is based on Nextflowtools we need.We should add a Dockerfile  for Mash  as   well.

The first line of main.nf is the SRAid that we can process. 
We can use .fromSRA to create the list of gs:// locations and dump to a file.
the FTP locations in the example are not the only locations.
You can limit the Location to 'GCP' to get the gs:// locations.

