awk -F, '$2~/^441/  {print "update eas_org_basicinfo set organizationname=\047"$3"\047  where organizationcode=\047"$2"\047 ;" }' org/Org_BaseInfo.csv 
