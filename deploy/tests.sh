#!/bin/bash

ELB_URI="http://$(grep "elb.amazonaws" ../terraform.tfstate | tr -s [[:blank:]] | cut -d':' -f2 | tr -d "\"" | tr -d "," | head -n1)"

echo "Inserting one doc"
curl -X POST -H "Content-Type: application/json" --data '{"doc": {"username":"xyz","password":"xyz"}}' "${ELB_URI}/insert"
if [[ $? -ne 0 ]]
then
  echo "A problem occurred while inserting the doc."
  exit 1
fi
echo "Success!"

echo "Retrieve the doc"
curl -X POST "${ELB_URI}/find?username=xyz"
if [[ $? -ne 0 ]]
then
  echo "A problem occurred while retrieving the doc."
  exit 1
fi
echo "Success!"

echo "Updating the doc"
curl -X PUT -H "Content-Type: application/json" --data '{"doc": {"username":"abc"}, "query":{"username": "xyz"}}' "${ELB_URI}/insert"
if [[ $? -ne 0 ]]
then
  echo "A problem occurred while updating the doc."
  exit 1
fi
echo "Success!"

echo "Deleting the doc"
curl -X POST -H "Content-Type: application/json" --data '{"doc": {"username":"abc"}, "query":{"username": "xyz"}}' "${ELB_URI}/insert"
if [[ $? -ne 0 ]]
then
  echo "A problem occurred while updating the doc."
  exit 1
fi
echo "Success!"
