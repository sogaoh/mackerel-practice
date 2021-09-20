# -*- coding: utf-8 -*-

def respond(content=None, status_code=200):
    return {
        'statusCode': status_code,
        'body': content,
        'headers': {
            'Content-Type': 'application/json',
        }
    }
