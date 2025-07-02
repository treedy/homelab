import argparse
import redis

def test_redis_connection(hostname, username, password):
    """Tests the connection to a Redis database."""
    try:
        r = redis.Redis(
            host=hostname,
            username=username,
            password=password,
            decode_responses=True
        )
        # Ping the Redis server to check the connection
        r.ping()
        print(f"Successfully connected to Redis at {hostname}")
        return True
    except redis.exceptions.ConnectionError as e:
        print(f"Could not connect to Redis at {hostname}: {e}")
        return False
    except redis.exceptions.AuthenticationError as e:
        print(f"Authentication failed for Redis at {hostname}: {e}")
        return False
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        return False

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Test connection to a Redis database.")
    parser.add_argument("hostname", help="The hostname or IP address of the Redis server.")
    parser.add_argument("-u", "--username", default=None, help="The username for Redis authentication (optional).")
    parser.add_argument("-p", "--password", default=None, help="The password for Redis authentication (optional).")

    args = parser.parse_args()

    test_redis_connection(args.hostname, args.username, args.password)
