source common.sh

if [ -z ${root_mysql_password} ]
then
  echo “variable root_mysql_password is missing”
exit
fi


# declaring variable for the component Catalogue
component=shipping

# declaring variable so that schema loading commands are implemented "true", by using "if" condition
schema_load=true

schema_type=mysql

# to keep the code DRY we sholud remove repetion, so the solution is using "Functions"
MAVEN