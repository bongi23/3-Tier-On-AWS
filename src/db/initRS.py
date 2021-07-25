from pymongo import MongoClient
import logging
import argparse

logging.basicConfig(level=logging.INFO)

if __name__ == '__main__':
    logging = logging.getLogger()

    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--hosts", help="Hosts for the replica set", default='inventory.ini')
    parser.add_argument("-rs", "--repl-set", help="Replica set name", required=True)
    parser.add_argument("-p", "--port", help="Mongo port", default=27017)
    args = parser.parse_args()

    logging.info("Reading replica set members addresses")
    with open(args.hosts, 'r') as f:
        hosts = f.read().split('\n')

    rs_config = {'_id': args.repl_set, 'members': []}
    for idx, h in enumerate(hosts):
        if h.strip() != "":
            rs_config['members'].append({'_id': idx, 'host': f"{h}:{args.port}"})

    # pick one member
    member = rs_config['members'][0]['host']

    logging.info("Replica set init...")
    c = MongoClient(member[:-(1+len(str(args.port)))], args.port)
    logging.info(c.admin.command("replSetInitiate", rs_config))
