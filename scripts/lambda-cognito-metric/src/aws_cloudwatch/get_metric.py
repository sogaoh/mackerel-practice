# -*- coding: utf-8 -*-

import boto3
from datetime import datetime, timedelta


def get_metric_statistics(namespace, name, dimensions, statistics, period=5, unit='None'):
    cloudwatch = boto3.resource('cloudwatch')
    metric = cloudwatch.Metric(namespace, name)
    stats = metric.get_statistics(
        Dimensions=dimensions,
        StartTime=datetime.now() - timedelta(minutes=period),
        EndTime=datetime.now(),
        Period=period * 60,
        Statistics=statistics,
        Unit=unit
    )
    return stats
