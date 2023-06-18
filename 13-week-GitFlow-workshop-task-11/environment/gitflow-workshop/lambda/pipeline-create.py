import json
import boto3

cloudformation = boto3.client('cloudformation')

def lambda_handler(event, context):
    #Log the updated references from the event
    references = { reference['ref'] for reference in event['Records'][0]['codecommit']['references'] }
    #Get the repository from the event
    repo = event['Records'][0]['eventSourceARN'].split(':')[5]
    user = event['Records'][0]['userIdentityARN'].split(':')[5]
    version = event['Records'][0]['eventVersion']
    for ref in references:
        if str(ref).startswith("refs/heads/"):
            branch = str(ref)[len("refs/heads/"):]
            beanstalkName = str(repo) + '-' + ''.join([ i if i.isalnum() or i == '-' else '-' for i in branch ])
    #Info for Debugging
    print("Branch: "  + str(branch) )
    print("EB: " + str(beanstalkName) )
    print("Repo: " + str(repo) )
    print("User: " + str(user) )
    print("Version: " + str(version) )
    print("event: " + str(event) )

    try:
        response = cloudformation.create_stack(
            StackName=str(beanstalkName),
            TemplateURL='https://aws-workshopassets-gitflow.s3.amazonaws.com/envcreate.yaml',
            Parameters=[
                {
                    'ParameterKey': 'Environment',
                    'ParameterValue': str(beanstalkName)[0:40],
                },
                {
                    'ParameterKey': 'BranchName',
                    'ParameterValue': str(branch),
                },
                {
                    'ParameterKey': 'RepositoryName',
                    'ParameterValue': str(repo),
                },
            ],
            Capabilities=[
                'CAPABILITY_IAM',
            ],
        )

    except Exception as e:
        print(e)
        raise e
