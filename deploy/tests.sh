#!/bin/bash

ELB_URI="http://$(grep "elb.amazonaws" ../terraform.tfstate | tr -d [[:blank:]] | cut -d':' -f2 | tr -d "\"" | tr -d "," | head -n1 )"

echo "Inserting one doc"
RC=$(curl -s -X POST -H "Content-Type: application/json" --data '{"doc": {"username":"xyz","password":"xyz"}}' "${ELB_URI}/insert" > tmp | grep -i "success" -c )
if [[ $RC -ne 0 ]]
then
  echo "A problem occurred while inserting the doc."
  exit 1
fi
echo "Success!"

echo "Retrieve the doc"
RC=$(curl -s -X POST "${ELB_URI}/find?username=xyz" > tmp | grep -i "success" -c)
if [[ $RC -ne 0 ]]
then
  echo "A problem occurred while retrieving the doc."
  exit 1
fi
echo "Success!"

echo "Updating the doc"
RC=$(curl -s -X PUT -H "Content-Type: application/json" --data '{"doc": {"username":"abc"}, "query":{"username": "xyz"}}' "${ELB_URI}/update" > tmp | grep -i "success" -c)
if [[ $RC -ne 0 ]]
then
  echo "A problem occurred while updating the doc."
  exit 1
fi
echo "Success!"

echo "Deleting the doc"
RC=$(curl -s -X POST -H "Content-Type: application/json" --data '{"query":{"username": "xyz"}}' "${ELB_URI}/delete" > tmp| grep -i "success" -c)
if [[ $RC -ne 0 ]]
then
  echo "A problem occurred while updating the doc."
  exit 1
fi
echo "Success!"
