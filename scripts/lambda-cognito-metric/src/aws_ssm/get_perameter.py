# -*- coding: utf-8 -*-

# refs https://docs.aws.amazon.com/code-samples/latest/catalog/python-ssm-ssm_get_parameter.py.html

import boto3, logging
from botocore.exceptions import ClientError


def get_parameter_value(parameter_name, with_decryption=True):
    ssm_client = boto3.client('ssm')

    try:
        result = ssm_client.get_parameter(
            Name=parameter_name,
            WithDecryption=with_decryption
        )
    except ClientError as e:
        logging.error(e)
        return ''

    return result['Parameter']['Value']