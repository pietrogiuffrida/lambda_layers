import sklearn
import boto3
from io import BytesIO
import joblib
import json
import numpy as np

class NpEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, np.integer):
            return int(obj)
        elif isinstance(obj, np.floating):
            return float(obj)
        elif isinstance(obj, np.ndarray):
            return obj.tolist()
        else:
            return super(NpEncoder, self).default(obj)

def lambda_handler(event, context):
    """Sample pure Lambda function

    Parameters
    ----------
    event: dict, required
        API Gateway Lambda Proxy Input Format

        Event doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html#api-gateway-simple-proxy-for-lambda-input-format

    context: object, required
        Lambda Context runtime methods and attributes

        Context doc: https://docs.aws.amazon.com/lambda/latest/dg/python-context-object.html

    Returns
    ------
    API Gateway Lambda Proxy Output Format: dict

        Return doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html
    """

    input_data = event["body"]['input_data']

    s3_client = boto3.client('s3')

    data = BytesIO()
    s3_client.download_fileobj(
        Bucket='onemodelone',
        Key="estimator.pkl",
        Fileobj=data
    )

    estimator = joblib.load(data)
    p = estimator.predict([input_data])[0]

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "hello world",
            "result": p,
        }, cls=NpEncoder),
    }
