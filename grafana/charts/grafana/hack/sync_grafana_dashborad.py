#!/usr/bin/env python3

import requests
import yaml
import json

# 从URL获取YAML数据
def load_yaml_from_url(url):
    response = requests.get(url)
    if response.status_code == 200:
        yaml_data = yaml.safe_load(response.text)
        return yaml_data
    else:
        print(f"Failed to retrieve YAML data from {url}")
        return None

# 将JSON数据写入文件
def write_json_to_file(key, json_data):
    file_name = f"../dashboards/{key}"
    with open(file_name, 'w') as file:
        json.dump(json_data, file)

# 提取并写入JSON数据
def extract_and_write_json(configmap_list):
    for item in configmap_list['items']:
        config_data = item['data']
        for key, value in config_data.items():
            if key.endswith('.json'):
                try:
                    json_data = json.loads(value)
                    # 将JSON数据写入文件
                    write_json_to_file(key, json_data)
                    print(f"JSON data has been written to {key}")
                except json.JSONDecodeError:
                    print(f"Value in {key} is not a valid JSON format.")

# 从URL获取YAML数据
url = 'https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/release-0.13/manifests/grafana-dashboardDefinitions.yaml'
configmap_list = load_yaml_from_url(url)

if configmap_list:
    # 提取并写入JSON数据
    extract_and_write_json(configmap_list)
