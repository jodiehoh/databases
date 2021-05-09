Aditi Sen, asen6@jhu.edu
Jodie Hoh, jhoh5@jhu.edu

One of our biggest challenges was finding the data. Country-specific and disease-specific information were not as readily available as we had expected, and the data that was available was not in the format we wanted. For example, there was no single list of all diseases in the world, and as a result our Disease relation is not comprehensive. It also became hard to distinguish between what was classified as a disease or disability so we just compiled a single Disease table and populated it with all the information we could find. Based on the data that was available, we had to make several design changes to our original ER-diagram from Phase B to represent our data all appropriately.

When we loaded the data from the csv files into our database, we had to give the full path of the file despite the csv files being in the same folder as the sql files. The files couldn't be detected/read otherwise. To run the process without errors, you will have to change the file path to where the files are saved in your computer. Apologies for the additional work and inconvenience.
