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

    response = get_ec2_from_tags(args.tags, ec2)
    public_instances_ip = [instance.get('PublicIpAddress', "") for instances in response.get('Reservations', []) for instance in
                    instances.get('Instances', []) if instance.get('State', {}).get('Name', {}) != "terminated"]

    logging.info(f"Public IPs found: {public_instances_ip}")
    # The inventory will be used by Ansible
    with open('inventory.ini', 'w+') as inventory:
        for ip in public_instances_ip:
            inventory.write(ip+'\n')

    private_instances_ip = [instance.get('PrivateIpAddress', "") for instances in response.get('Reservations', []) for instance in
                           instances.get('Instances', []) if instance.get('State', {}).get('Name', {}) != "terminated"]

    logging.info(f"Private IPs found: {private_instances_ip}")
    # The private_ip file will be used to correctly set up the MongoDB replica set
    with open('private_ip', 'w+') as inventory:
        for ip in private_instances_ip:
            inventory.write(ip+'\n')

    logging.info("Complete.")
