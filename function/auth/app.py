import json
import boto3
from botocore.exceptions import ClientError

client = boto3.client("cognito-idp")

#TODO: configure dotenv
USER_POOL_ID = ""
CLIENT_ID = ""


def lambda_handler(event, context):
    username = event["username"]
    password = event["password"]

    try:
        response = client.initiate_auth(
            ClientId=CLIENT_ID,
            AuthFlow="USER_PASSWORD_AUTH",
            AuthParameters={"USERNAME": username, "PASSWORD": password},
        )

        return {
            "statusCode": 200,
            "body": json.dumps(
                {
                    "message": "Authentication successful",
                    "id_token": response["AuthenticationResult"]["IdToken"],
                    "access_token": response["AuthenticationResult"]["AccessToken"],
                    "refresh_token": response["AuthenticationResult"]["RefreshToken"],
                }
            ),
        }

    except ClientError as e:
        return {
            "statusCode": 401,
            "body": json.dumps({"message": f"Error authenticating user: {str(e)}"}),
        }
