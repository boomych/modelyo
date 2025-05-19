import json
import os

CONFIG_FILE = "../configuration/envs.json"
OUT_DIR = "tf/envs"

def main():
    with open(os.path.join(os.path.dirname(__file__),CONFIG_FILE)) as f:
        envs = json.load(f)

    os.makedirs(OUT_DIR, exist_ok=True)

    for env in envs:
        name = env["name"]
        out_path = os.path.join(OUT_DIR, f"{name}.tfvars.json")

        filtered = {k: v for k, v in env.items() if k not in ["name", "needs"]}

        with open(out_path, "w") as f:
            json.dump(filtered, f, indent=2)

        print(f"Generated {out_path}")

if __name__ == "__main__":
    main()
