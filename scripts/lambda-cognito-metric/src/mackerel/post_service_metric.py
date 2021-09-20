# -*- coding: utf-8 -*-

import json, pprint, logging
import urllib.request

import sys; sys.path.append('./functions')
import respond as r


pp = pprint.PrettyPrinter(indent=4)
mackerel_url = "https://mackerel.io/api/v0/services/%s/tsdb"


def build_post_data(metric_name, time, value):
    return json.dumps(
        [{
            "name": metric_name,
            "time": time,
            "value": value
        }]
    ).encode('utf-8')


def post_mackerel(service_name, api_key, data):
    url = mackerel_url % service_name
    headers = {
        'X-Api-Key': api_key,
        'Content-Type': 'application/json'
    }
    post_data = build_post_data(
        data['metric_name'], data['time'], data['value']
    )
    # pp.pprint(post_data)

    req = urllib.request.Request(
        url, post_data, headers, method='POST'
    )

    try:
        with urllib.request.urlopen(req) as res:
            body = res.read().decode('utf-8')
            return r.respond(body)
    except urllib.error.HTTPError as he:
        logging.error(he)
        return r.respond('{"http_error_reason" : "' + he.reason + '"}', he.code)
    except urllib.error.URLError as ue:
        logging.error(ue)
        return r.respond('{"url_error_reason" : "' + ue.reason + '"}', 404)
