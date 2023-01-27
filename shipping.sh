source common.sh

if [ -z ${root_shipping_password} ]
then
  echo “variable root_shipping_password is missing”
exit
fi


# declaring variable for the component Catalogue
component=shipping

# declaring variable so that schema loading commands are implemented "true", by using "if" condition
schema_load=true

# to keep the code DRY we sholud remove repetion, so the solution is using "Functions"
MAVEN