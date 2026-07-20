#!/usr/bin/env python3
"""AMD GPU query helper for waybar/scripts/gpu_info.

Prints a JSON object with GPU Temperature, GPU Load, GPU Core Clock and
GPU Power Usage. Uses pyamdgpuinfo when available, otherwise falls back
to sysfs hwmon, and prints "No AMD GPUs detected." when nothing is found.
"""

import glob
import json
import sys


def query_pyamdgpuinfo():
    import pyamdgpuinfo

    if pyamdgpuinfo.detect_gpus() == 0:
        return None
    gpu = pyamdgpuinfo.get_gpu(0)
    return {
        "GPU Temperature": f"{gpu.query_temperature():.0f}°C",
        "GPU Load": f"{gpu.query_load() * 100:.0f}%",
        "GPU Core Clock": f"{gpu.query_sclk() / 1e6:.0f} MHz",
        "GPU Power Usage": f"{gpu.query_power():.0f} Watts",
    }


def query_sysfs():
    for hwmon in glob.glob("/sys/class/hwmon/hwmon*"):
        try:
            with open(f"{hwmon}/name") as f:
                if f.read().strip() != "amdgpu":
                    continue
        except OSError:
            continue

        info = {}
        try:
            with open(f"{hwmon}/temp1_input") as f:
                info["GPU Temperature"] = f"{int(f.read()) / 1000:.0f}°C"
        except OSError:
            pass
        try:
            with open(f"{hwmon}/device/gpu_busy_percent") as f:
                info["GPU Load"] = f"{f.read().strip()}%"
        except OSError:
            pass
        try:
            with open(f"{hwmon}/freq1_input") as f:
                info["GPU Core Clock"] = f"{int(f.read()) / 1e6:.0f} MHz"
        except OSError:
            pass
        try:
            with open(f"{hwmon}/power1_average") as f:
                info["GPU Power Usage"] = f"{int(f.read()) / 1e6:.0f} Watts"
        except OSError:
            pass
        if info:
            return info
    return None


def main():
    info = None
    try:
        info = query_pyamdgpuinfo()
    except Exception:
        pass
    if info is None:
        info = query_sysfs()
    if info is None:
        print("No AMD GPUs detected.")
        sys.exit(0)
    print(json.dumps(info))


if __name__ == "__main__":
    main()
