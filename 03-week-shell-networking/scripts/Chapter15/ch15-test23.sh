#!/bin/bash
#It reads a .csv formatted data fi le and outputs SQL INSERT statements to insert the data into a database

outfile=members.sql
IFS=','
while read lname fname address city state zip
do
 cat >> $outfile << EOF
 INSERT INTO members (lname,fname,address,city,state,zip) VALUES 
('$lname', '$fname', '$address', '$city', '$state', '$zip');
EOF
done < ${1}