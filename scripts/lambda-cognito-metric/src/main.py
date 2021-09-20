# -*- coding: utf-8 -*-

import os, json, logging, pprint, calendar
from datetime import datetime, timedelta, timezone

from aws_ssm import get_perameter as ssm
from aws_cloudwatch import get_metric as cw
from mackerel import post_service_metric as mkr
from functions import respond as res

pp = pprint.PrettyPrinter(indent=4)


def post_cognito_sign_in_stats(event, content):
    pp.pprint(event)
    env = event['environment']
    mackerel_service = event['mackerel_service']
    path_to_parameter = event['path_to_parameter']

    # Get Parameters
    mackerel_api_key = ssm.get_parameter_value(
        '/' + env + path_to_parameter + '/MACKEREL_API_KEY'
    )
    user_pool_id = ssm.get_parameter_value(
        '/' + env + path_to_parameter + '/AWS_COGNITO_USER_POOL_ID'
    )
    cognito_client_id = ssm.get_parameter_value(
        '/' + env + path_to_parameter + '/AWS_COGNITO_CLIENT_ID'
    )

    # Now Second (epoch)
    now_sec = calendar.timegm(datetime.now(timezone.utc).timetuple())

    # Get Stats
    cognito_sign_in_stats = cw.get_metric_statistics(
        'AWS/Cognito',
        'SignInSuccesses',
        [
            {'Name': 'UserPool', 'Value': user_pool_id},
            {'Name': 'UserPoolClient', 'Value': cognito_client_id}
        ],
        ['Sum', 'SampleCount']
    )

    # Summary Stats
    sample_count_all = 0
    sum_all = 0
    for data in cognito_sign_in_stats['Datapoints']:
        sample_count_all += data['SampleCount']
        sum_all += data['Sum']

    # Post Metric
    post_sample_count_result = mkr.post_mackerel(
        mackerel_service,
        mackerel_api_key,
        {
            'metric_name': 'cognito.SignIn_Attempt',
            'time': now_sec,
            'value': sample_count_all
        }
    )
    post_sum_result = mkr.post_mackerel(
        mackerel_service,
        mackerel_api_key,
        {
            'metric_name': 'cognito.SignIn_Success',
            'time': now_sec,
            'value': sum_all
        }
    )

    return res.respond(
        {
            'sum_result': post_sum_result,
            'sample_result': post_sample_count_result
        }
    )
