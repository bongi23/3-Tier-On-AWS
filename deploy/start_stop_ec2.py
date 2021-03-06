import logging
import argparse
import boto3
from botocore.config import Config

logging.basicConfig(level=logging.INFO)


def get_ec2_from_tags(tag_list, ec2):
    # build filters list
    tags = tag_list.split(',')
    tag_list = []
    for key_val in tags:
        split = key_val.split('=')
        tag_list.append({
            'Name': f'tag:{split[0]}',
            'Values': [split[1]]
        })

    logging.info("Retrieving EC2 instances according to the specified tags.")

    return ec2.describe_instances(Filters=tag_list)


if __name__ == '__main__':
    logging = logging.getLogger()

    parser = argparse.ArgumentParser()
    parser.add_argument("-t", "--tags", help="Tags to filter which EC2 retrive. Format: Key1=Value1,Key2=Value2...",
                        required=True)
    parser.add_argument("-r", "--region", help="AWS regione", default="eu-central-1")
    parser.add_argument("-p", "--profile", help="AWS porfile to be used")
    parser.add_argument("-c", "--command", help="AWS porfile to be used", required=True)
    args = parser.parse_args()

    boto_conf = Config(
        region_name=args.region,
        retries={
            'max_attempts': 10,
            'mode': 'standard'
        })

    logging.info(f"Configuring EC2 client. Region: {args.region}")

    if args.profile:
        logging.info(f"Using AWS profile {args.profile}. Environmental variables will be ignored.")
        ec2 = boto3.session.Session(profile_name=args.profile).client('ec2', config=boto_conf)
    else:
        ec2 = boto3.client('ec2', region_name=args.region, config=boto_conf)

    # get EC2 by tags
    retrieved_instances = get_ec2_from_tags(args.tags, ec2)
    instance_ids = [instance.get('InstanceId', "") for instances in retrieved_instances.get('Reservations', []) for instance in
                   instances.get('Instances', []) if instance.get('State', {}).get('Name', {}) != "terminated"]

    if args.command == 'start':
        logging.info(f"Starting instances: {instance_ids}")
        ec2.start_instances(InstanceIds=instance_ids)
    elif args.command == 'stop':
        logging.info(f"Stopping instances: {instance_ids}")
        ec2.stop_instances(InstanceIds=instance_ids)

    logging.info("Success.")
