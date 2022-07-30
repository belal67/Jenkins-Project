import json
import boto3
def lambda_handler(event, context):
    # TODO implement
    ses = boto3.client('ses')

    body = """
	    Hello this is first lab in lambda
	    thanks
    """

    ses.send_email(
	    Source = 'belal.hany.kamal@gmail.com',
	    Destination = {
		    'ToAddresses': [
			    'belal.hany.kamal@gmail.com'
		    ]
	    },
	    Message = {
		    'Subject': {
			    'Data': 'SES Lambda_S3',
			    'Charset': 'UTF-8'
		    },
		    'Body': {
			    'Text':{
				    'Data': body,
				    'Charset': 'UTF-8'
			    }
		    }
	    }
    )
    
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
