#!/bin/zsh

mkr update --roleFullname STNS:1_ApiGateway      $(mkr hosts | jq -r '.[] | select(.displayName=="stns-api-endpoint") | .id')
mkr update --roleFullname STNS:2_LambdaFunctions $(mkr hosts | jq -r '.[] | select(.displayName=="stns-api-function") | .id')
mkr update --roleFullname STNS:2_LambdaFunctions $(mkr hosts | jq -r '.[] | select(.name=="stns-api-authorizer") | .id')
mkr update --roleFullname STNS:3_DynamoDb  $(mkr hosts | jq -r '.[] | select(.name=="stns-users") | .id')
mkr update --roleFullname STNS:3_DynamoDb  $(mkr hosts | jq -r '.[] | select(.name=="stns-groups") | .id')
mkr update --roleFullname STNS:3_DynamoDb  $(mkr hosts | jq -r '.[] | select(.name=="stns-authorizations") | .id')
