#!/usr/bin/env python3
import argparse
import speedtest

def get_formatted_speed(s,bytes=False):
    unit = ""
    if s > 1024**3:
        s = s / 1024**3
        unit = "G"
    elif s > 1024**2:
        s = s / 1024**2
        unit = "M"
    elif s > 1024:
        s = s / 1024
        unit = "K"
    if bytes:
        return f"{(s/8):.2f} {unit}iB/s"
    return f"{s:.2f} {unit}ib/s"
    


parser = argparse.ArgumentParser()
parser.add_argument('--upload', action="store_true")
parser.add_argument('--bytes', action="store_true")
args= parser.parse_args()

# try:
#     s = speedtest.Speedtest()
# except:
#     exit(0)

try:
    s = speedtest.Speedtest()
except speedtest.ConfigRetrievalError:
    # print("Error: Failed to retrieve speedtest configuration.")
    print("?")
    exit(1)
except speedtest.NoMatchedServers:
    print("Error: No matched servers found.")
    exit(1)
except speedtest.SpeedtestException as e:
    print(f"Speedtest error: {e}")
    exit(1)



# if args.upload:
#     s.upload(pre_allocate=False)
#     print(" " + get_formatted_speed(s.results.upload,args.bytes))
# else:
#     s.download()
#     print(" " + get_formatted_speed(s.results.download,args.bytes))

try:
    if args.upload:
        s.upload(pre_allocate=False)
        print(" " + get_formatted_speed(s.results.upload, args.bytes))
    else:
        s.download()
        print(" " + get_formatted_speed(s.results.download, args.bytes))
except speedtest.SpeedtestException as e:
    # print(f"Error during speed test: {e}")
    print("??")
    exit(1)
