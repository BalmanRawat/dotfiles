#!/usr/bin/env python

from botocore import credentials
import botocore.session
import boto3, sys, os

if len(sys.argv) > 1:
    cache_dir = os.path.join(os.path.expanduser('~'),'.aws/cli/cache')
    _session = botocore.session.Session(profile=sys.argv[1])
    provider = _session.get_component('credential_provider').get_provider('assume-role')                                                                             
    provider.cache = credentials.JSONFileCache(cache_dir)
    session = boto3.Session(botocore_session=_session)
    region_name = session.region_name
    credentials = session.get_credentials().get_frozen_credentials()
    print("export AWS_ACCESS_KEY_ID='{0}'\nexport AWS_SECRET_ACCESS_KEY='{1}'\nexport AWS_SECURITY_TOKEN='{2}'\nexport AWS_SESSION_TOKEN='{2}'\nexport AWS_REGION='{3}'".format(credentials.access_key, credentials.secret_key, credentials.token, region_name))
